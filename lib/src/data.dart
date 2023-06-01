import 'package:tinji/src/key.dart';

import 'dio.dart';

class TinjiApi {
  
  Future<double> getUserSol() async {
    String? Token = await getData(ACCESS_KEY);
    String? userId = await getData(USER_ID);
    final response = await dioClient
        .simpleDio(Token.toString())
        .get('/api/user/sol/${userId.toString()}');
    return response.data['balnace'];
  }

  Future<List<dynamic>> getMainStoreData(
      {required double lat, required double lng, required int range}) async {
    String? Token = await getData(ACCESS_KEY);
    String? userId = await getData(USER_ID);

    final response = await dioClient.simpleDio(Token.toString()).post(
        '/api/store/${userId}/reclist',
        data: {"lat": lat, "lng": lng, "range": range});
    //todo 매장 like count 로직 적용요함
    return response.data['store'];
  }

  //좋아요 누른 매장 list
  Future<List<dynamic>> getUserLikeStores() async {
    String? Token = await getData(ACCESS_KEY);
    String? userId = await getData(USER_ID);
    final response = await dioClient
        .simpleDio(Token.toString())
        .get('/api/store/${userId}/like');
    print(response.data);
    return response.data;
  }

  //매장 추천에대한 like
  Future<String> setStoreLike({required String store_id}) async {
    String? Token = await getData(ACCESS_KEY);
    String? userId = await getData(USER_ID);
    final response = await dioClient.simpleDio(Token.toString()).post(
        '/api/store/like',
        data: {"store_id": store_id, "user_id": userId.toString()});
    print(response);
    return response.data['status'];
  }

  //매장정보 불러오기 -> 이슈발생 수정중
  Future<dynamic> getStore({required String store_id}) async {
    String? Token = await getData(ACCESS_KEY);
    final response = await dioClient
        .simpleDio(Token.toString())
        .get('/api/store/${store_id}/detail');
    return response.data;
  }

  //매장정보 추천데이터
  Future<dynamic> getStoreLikeReview({required String store_id}) async {
    String? Token = await getData(ACCESS_KEY);
    final response = await dioClient
        .simpleDio(Token.toString())
        .get('/api/store/${store_id}/rec');
    return response.data;
  }

  //매장정보 리뷰
  Future<List<dynamic>> getStoreReview({required String store_id}) async {
    String? Token = await getData(ACCESS_KEY);
    final response = await dioClient
        .simpleDio(Token.toString())
        .get('/api/store/${store_id}/review');
    return response.data;
  }

  //캔디히스토리
  Future<List<dynamic>> getHistory() async {
    String? Token = await getData(ACCESS_KEY);
    String? userId = await getData(USER_ID);

    final response = await dioClient
        .simpleDio(Token.toString())
        .get('/api/user/candylog/${userId.toString()}');
    
    return response.data;
  }

  //리뷰 작성
  Future<String> setReview({required String content}) async {
    String? Token = await getData(ACCESS_KEY);
    String? userId = await getData(USER_ID);
    String img1 = "https://img.hankyung.com/photo/202209/01.31363897.1.jpg";
    final response = await dioClient.simpleDio(Token.toString()).post(
        '/api/store/${userId}/reclist',
        data: {"user_id": userId, "content": content, "img1": img1});
    print(response);
    return response.data['status'];
  }

  //User 닉네임 중복체크
  Future<bool> setUserName({required String name}) async {
    String? Token = await getData(ACCESS_KEY);
    final response = await dioClient
        .simpleDio(Token.toString())
        .get('/api/user/username/${name}');
    return response.data['available'];
  }

  //login
  Future<dynamic> userLogin(
      {required String email, required String token}) async {
    final response = await dioClient
        .simpleDio(token)
        .get('/auth/oauth/google?email=${email}');
    print(response);
    return response.data;
  }

  //회원가입
  Future<User> userJoin({required String email, required String name}) async {
    String? Token = await getData(ACCESS_KEY);
    final response = await dioClient
        .simpleDio(Token.toString())
        .post('/api/user/newuser', data: {"email": email, "name": name});
    print(response);

    return User(
      user_id: response.data['user_id'],
      username: response.data['username'],
      email: response.data['email'],
      pub_key: response.data['pub_key'],
    );
  }
}

class User {
  final String user_id;
  final String username;
  final String email;
  final String pub_key;

  User(
      {required this.user_id,
      required this.username,
      required this.email,
      required this.pub_key});
}
