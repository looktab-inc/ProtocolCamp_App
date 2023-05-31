import 'package:shared_preferences/shared_preferences.dart';

const ACCESS_KEY = "access_key";
const USER_ID = "user_id";
const EMAIL = "email";

// 데이터 저장
void saveData(String key, String value, Function() callback) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
  print("key");
  print(key);
  print("value");
  print(value);
  callback(); // Callback function executed after saving the data
}

// 데이터 가져오기
Future<String?> getData(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}
