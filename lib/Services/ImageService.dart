import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:what_food/Models/ServerModels.dart';
import 'Dio/CustomDio.dart';

class ImageService {
  static Future<String> uploadImagePost_Dio(image) async {
    //String fileName = image.path.split('/').last;
    String apiUrl = '$URL_UPLOADIMAGE';
    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        image.path,
        //filename: fileName,
      ),
    });

    Dio dio = new Dio();

    dio
        .post(apiUrl, data: data)
        .then((response) => print(response))
        .catchError((error) => print(error));
  }

  static Future<String> uploadAvatar_Dio(File image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    String fileName = image.path.split('/').last;
    String apiUrl = '$URL_UPLOADIMAGE';
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
    });
    Dio dio = new Dio();
    dio
        .post(apiUrl,
            options: Options(headers: {"Authorization": "Bearer $token"}),
            data: formData)
        .then((response) => print(response))
        .catchError((error) => print(error));
  }

  static Future<String> updateAvatar_Dio(urlAvatar) async {
    String apiUrl = "$URL_UPDATEAVATAR";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    urlAvatar = prefs.get('');
    var dio = CustomDio().instance;

    dio.post(apiUrl,
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: {'image': urlAvatar}).then((res) async {
      print('update avatar thanh cong');
    }).catchError((err) async {
      throw Exception('update avatar that bai');
    });
  }
}
