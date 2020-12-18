import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:what_food/Models/ServerModels.dart';


class ImageService {
  static Future<String> uploadImagePost(image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiUrl = '$URL_UPLOADIMAGE';
    var request = new http.MultipartRequest('POST', Uri.parse(apiUrl));
    final file = await http.MultipartFile.fromPath('image', image);
    request.files.add(file);
    request
        .send()
        .then((result) async {
          http.Response.fromStream(result).then((response) {
            if (response.statusCode == 200) {
              prefs.setString('UrlImage', response.body);
              print("Uploaded! ");
              print('response.body ' + response.body);
            }
            return response.body;
          });
        })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});
  }

  static Future<String> uploadAvatar(image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiUrl = '$URL_UPLOADIMAGE';
    var request = new http.MultipartRequest('POST', Uri.parse(apiUrl));
    final file = await http.MultipartFile.fromPath('image', image);
    request.files.add(file);
    request
        .send()
        .then((result) async {
          http.Response.fromStream(result).then((response) {
            if (response.statusCode == 200) {
              prefs.setString('UrlAvatar', response.body);
              print("Uploaded! ");
              print('response.body ' + response.body);
            }
            return response.body;
          });
        })
        .catchError((err) => print('error : ' + err.toString()))
        .whenComplete(() {});
  }
}
