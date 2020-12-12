import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:what_food/Models/ServerModels.dart';
import 'Dio/CustomDio.dart';

class UserService {
  static Future<String> updateAvatar_Dio(urlAvatar) async {
    String apiUrl = "$URL_UPDATEAVATAR";
    var dio = CustomDio().instance;

    dio.post(apiUrl, data: {'image': urlAvatar}).then((res) async {
      print('update avatar thanh cong');
    }).catchError((err) async {
      throw Exception('update avatar that bai');
    });
  }
}
