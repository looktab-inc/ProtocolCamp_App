// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../data.dart';
import '../key.dart';
import '../swipe/swipe.dart';
import 'join.dart';
import 'login/sign_in_button.dart';

/// The scopes required by this application.
const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);

void main() {
  runApp(
    const MaterialApp(
      title: 'Google Sign In',
      home: SignInDemo(),
    ),
  );
}

/// The SignInDemo app.
class SignInDemo extends StatefulWidget {
  ///
  const SignInDemo({super.key});

  @override
  State get createState => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // In mobile, being authenticated means being authorized...
      bool isAuthorized = account != null;
      // However, in the web...

      final GoogleSignInAuthentication googleAuth =
          await _googleSignIn.currentUser!.authentication;
      print("\n\accessToken\n\n\n");
      print(googleAuth.accessToken);
      print(account?.email);

      dynamic res = (await TinjiApi()
          .userLogin(email: account!.email, token: googleAuth.accessToken!));
      print(res);
      String jwt = res['jwt'];
      String user_id = res['user_id'];
      bool exist = res['exist'];

      print("jwt");
      print(jwt);
      print("user_id");
      print(user_id);
      saveData(ACCESS_KEY, jwt, () {
        // 데이터 저장 후 실행할 코드
        print('saveData ACCESS_KEY saved successfully');
      });
      saveData(EMAIL, account.email, () {
        // 데이터 저장 후 실행할 코드
        print('saveData EMAIL saved successfully');
      });

      if (exist) {
        saveData(USER_ID, user_id, () {
          // 데이터 저장 후 실행할 코드
          print('saveData USER_ID saved successfully');
          // 스와이프 화면으로
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Swipe()),
          );
        });
      }

      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }

      setState(() {
        _currentUser = account;
        _isAuthorized = isAuthorized;
      });

      // Now that we know that the user can access the required scopes, the app
      // can call the REST API.
      if (isAuthorized) {
        _handleGetContact(account!);
      }
    });

    // In the web, _googleSignIn.signInSilently() triggers the One Tap UX.
    //
    // It is recommended by Google Identity Services to render both the One Tap UX
    // and the Google Sign In button together to "reduce friction and improve
    // sign-in rates" ([docs](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
    _googleSignIn.signInSilently();
  }

  // Calls the People API REST endpoint for the signed-in user to retrieve information.
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know ${_currentUser}   $namedContact!';
      } else {
        _contactText = 'No contacts to displa';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
        (dynamic name) =>
            (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  // This is the on-click handler for the Sign In button that is rendered by Flutter.
  //
  // On the web, the on-click handler of the Sign In button is owned by the JS
  // SDK, so this method can be considered mobile only.
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  // Prompts the user to authorize `scopes`.
  //
  // This action is **required** in platforms that don't perform Authentication
  // and Authorization at the same time (like the web).
  //
  // On the web, this must be called from an user interaction (button click).
  Future<void> _handleAuthorizeScopes() async {
    final bool isAuthorized = await _googleSignIn.requestScopes(scopes);
    setState(() {
      _isAuthorized = isAuthorized;
    });
    if (isAuthorized) {
      _handleGetContact(_currentUser!);
    }
  }

  // logout
  //ElevatedButton(
  //   onPressed: _handleSignOut,
  //   child: const Text('SIGN OUT'),
  // ),
  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Join();
      // The user is Authenticated
      // return Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: <Widget>[
      //     ListTile(
      //       leading: GoogleUserCircleAvatar(
      //         identity: user,
      //       ),
      //       title: Text(user.displayName ?? ''),
      //       subtitle: Text(user.email),
      //     ),
      //     const Text('Signed in successfully.'),
      //     if (_isAuthorized) ...<Widget>[
      //       // The user has Authorized all required scopes
      //       ElevatedButton(
      //         child: const Text('REFRESH'),
      //         onPressed: () => _handleGetContact(user),
      //       ),
      //     ],
      //     if (!_isAuthorized) ...<Widget>[
      //       // The user has NOT Authorized all required scopes.
      //       // (Mobile users may never see this button!)
      //       const Text('Additional permissions needed to read your contacts.'),
      //       ElevatedButton(
      //         onPressed: _handleAuthorizeScopes,
      //         child: const Text('REQUEST PERMISSIONS'),
      //       ),
      //     ],
      //     ElevatedButton(
      //       onPressed: _handleSignOut,
      //       child: const Text('SIGN OUT'),
      //     ),
      //   ],
      // );
    } else {
      // The user is NOT Authenticated
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          // This method is used to separate mobile from web code with conditional exports.
          // See: src/sign_in_button.dart
           Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/ic_go.png',
                    ),
                  ),
                ),
              ),
          buildSignInButton(
            onPressed: _handleSignIn,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Google Sign In'),
        // ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}
