import 'package:dio/dio.dart';
import 'dio.dart';

class TinjiApi {
  static String USER_ID = "MH2TIF";
  static String STORE_ID = "5ATS7f";
  static String Token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3RAYXNkZiIsImlhdCI6MTY4NTMzNjY4OSwiZXhwIjoxNjg1MzQyNjg5fQ.1HZvu1EaNuKGoDfyHG5jpzP1TfpZYkXQQSVEjL3FnM8";

  Future<int> getUserSol() async {
    final response =
        await dioClient.simpleDio(Token).get('/api/user/sol/${USER_ID}');
    return response.data['balnace'];
  }

  Future<List<dynamic>> getMainStoreData(
      {required double lat, required double lng, required int range}) async {
    final response = await dioClient.simpleDio(Token).post(
        '/api/store/${USER_ID}/reclist',
        data: {"lat": lat, "lng": lng, "range": range});
    //todo 매장 like count 로직 적용요함
    return response.data['store'];
  }

  //좋아요 누른 매장 list
  Future<List<dynamic>> getUserLikeStores() async {
    final response =
        await dioClient.simpleDio(Token).get('api/store/${USER_ID}/like');
    return response.data;
  }

  //매장 추천에대한 like
  Future<String> setStoreLike({required String store_id}) async {
    final response = await dioClient.simpleDio(Token).post(
        '/api/store/${USER_ID}/reclist',
        data: {"store_id": store_id, "user_id": USER_ID});
    print(response);
    return response.data['status'];
  }

  //매장정보 불러오기 -> 이슈발생 수정중
  Future<dynamic> getStore({required String store_id}) async {
    final response =
        await dioClient.simpleDio(Token).get('api/store/${store_id}/detail');
    return response.data;
  }

  //매장정보 추천데이터
  Future<dynamic> getStoreLikeReview({required String store_id}) async {
    final response =
        await dioClient.simpleDio(Token).get('api/store/${store_id}/user_rec');
    return response.data;
  }

  //매장정보 리뷰
  Future<List<dynamic>> getStoreReview({required String store_id}) async {
    final response =
        await dioClient.simpleDio(Token).get('api/store/${store_id}/review');
    return response.data;
  }

  //리뷰 작성
  Future<String> setReview({required String content}) async {
    String img1 = "https://img.hankyung.com/photo/202209/01.31363897.1.jpg";
    final response = await dioClient.simpleDio(Token).post(
        '/api/store/${USER_ID}/reclist',
        data: {"user_id": USER_ID, "content": content, "img1": img1});
    print(response);
    return response.data['status'];
  }

  //User 닉네임 중복체크
  Future<bool> setUserName({required String name}) async {
    final response =
        await dioClient.simpleDio(Token).get('api/user/username/${name}');
    return response.data['available'];
  }

  //login
  Future<String> userLogin(
      {required String email, required String token}) async {
    final response = await dioClient
        .simpleDio(token)
        .get('auth/oauth/google', queryParameters: {'email': email});
    return response.data;
  }

  //회원가입
  Future<User> userJoin({required String email, required String name}) async {
    final response = await dioClient
        .simpleDio(Token)
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
