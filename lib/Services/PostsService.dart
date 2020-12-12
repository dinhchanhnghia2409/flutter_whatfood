import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:what_food/Models/ServerModels.dart';
import 'package:http/http.dart' as http;
import 'Dio/CustomDio.dart';
import 'package:get/get.dart';
import 'package:what_food/Models/post.dart';

class PostsService {
  static Future<String> create_Post(caption, urlImage) async {
    final prefs = await SharedPreferences.getInstance();
    final keyToken = 'token';
    final token = prefs.get(keyToken) ?? 0;
    String apiUrl = '$URL_CREATEPOST';
    http.Response response = await http.post(apiUrl, body: {
      'image': urlImage,
      'caption': caption,
    }, headers: {
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      print("Result: ${response.body}");
      print('tao post thanh cong');
    } else {
      print('tao post that bai');
    }
  }
}
