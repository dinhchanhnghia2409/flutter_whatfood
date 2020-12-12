import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:what_food/Models/ServerModels.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:what_food/Models/UserModel.dart';
import 'package:what_food/Screens/NavigationPage/navigation_page.dart';
import 'package:what_food/Screens/Login/login_screen.dart';
import 'package:what_food/Screens/Profile/profile_screen.dart';
import 'Dio/CustomDio.dart';

class AuthService {
  static Future<String> signup_Dio(phone, password, email, name) async {
    String apiUrl = '$URL_SIGNUP';
    var dio = CustomDio().instance;

    dio.post(apiUrl, data: {
      'phone': phone,
      'password': password,
      'email': email,
      'name': name
    }).then((res) async {
      Get.to(LoginScreen());
      Get.snackbar(
        "Thông báo",
        "Đăng ký thành công",
        snackPosition: SnackPosition.TOP,
      );
    }).catchError((err) {
      Get.snackbar(
        "Thông báo",
        "Đăng ký thất bại",
        snackPosition: SnackPosition.TOP,
      );
    });
  }

  static Future<String> login_Dio(phone, password) {
    var dio = CustomDio().instance;
    String apiUrl = "$URL_LOGIN";
    dio.post(apiUrl, data: {'phone': phone, 'password': password}).then(
        (res) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', res.data['token']);
      await prefs.setString('id', res.data['_id']);
      Get.snackbar(
        "Thông báo",
        "Đăng nhập thành công",
        snackPosition: SnackPosition.TOP,
      );
      Get.offAll(NavigationPage());
      print(res.data['token']);
      print(res.data['_id']);
    }).catchError((err) {
      Get.snackbar(
        "Thông báo",
        "Đăng nhập thất bại",
        snackPosition: SnackPosition.TOP,
      );
    });
  }

  static Future<User> get profile_Author async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String apiUrl = '$URL_PROFILE';
    http.Response response =
        await http.get(apiUrl, headers: {'Authorization': 'Bearer $value'});
    if (response.statusCode == 200) {
      var user = User.fromJson(json.decode(response.body));
      print('${user.email}' + '${user.name}' + '${user.bio}');
      Get.snackbar(
        "Thông báo",
        "Xin chào ${user.name}",
        snackPosition: SnackPosition.TOP,
      );
      return user;
    } else {
      print('Lấy Profile Về Thất Bại');
      return null;
    }
  }

  static Future<User> profile_Dio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    String apiUrl = '$URL_PROFILE';
    var dio = CustomDio().instance;
    print("dang lay profile...");
    dio
        .get(apiUrl,
            options: Options(headers: {"Authorization": "Bearer $token"}))
        .then((res) async {
      var user = User.fromJson(res.data);
      print('${user.email}');
      return user;
    }).catchError((err) {
      throw Exception('Lấy profile Về Thất Bại');
    });
  }

  static Future<User> getUserWithId_Dio(idUser) async {
    String apiUrl = '$URL_USERWITHID$idUser';
    var dio = CustomDio().instance;

    dio.get(apiUrl).then((res) async {
      print('Lấy User Về Thành Công');
      return User.fromJson(res.data);
    }).catchError((err) {
      throw Exception('Lấy User Về Thất Bại');
    });
  }

  static Future<User> upDateProfileUser(name, email, bio) async {
    final prefs = await SharedPreferences.getInstance();
    final keyToken = 'token';
    final token = prefs.get(keyToken) ?? 0;

    String apiUrl = '$URL_UPDATEPROFILE';
    http.Response response = await http.put(apiUrl, body: {
      'name': name,
      'email': email,
      'bio': bio,
    }, headers: {
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      print("Result: ${response.body}");
      print('Up Date Thành Công');
      return json.decode(response.body);
    } else {
      print('Up Date Thất Bại');
      return null;
    }
  }

  static Future<User> upDateProfileUser_Dio(name, email, bio) async {
    String apiUrl = '$URL_UPDATEPROFILE';
    var dio = CustomDio().instance;

    dio.put(apiUrl, data: {
      'name': name,
      'email': email,
      'bio': bio,
    }).then((res) async {
      Get.to(ProfileScreen());
      Get.snackbar(
        "Thông báo",
        "Cập nhật thành công",
        snackPosition: SnackPosition.TOP,
      );
    }).catchError((err) {
      throw Exception('UpDate That bai');
    });
  }

  static Future logout_Author_Dio() async {
    var dio = CustomDio().instance;
    String apiUrl = '$URL_LOGOUT';
    dio.post(apiUrl).then((res) async {
      print("logout done");
    }).catchError((err) {
      throw Exception('Logout fail');
    });
  }
}
