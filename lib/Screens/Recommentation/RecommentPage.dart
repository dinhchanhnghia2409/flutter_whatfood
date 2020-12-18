import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:what_food/Screens/SearchPage/search_page.dart';

class DetectMain extends StatefulWidget {
  @override
  _DetectMainState createState() => new _DetectMainState();
}

class _DetectMainState extends State<DetectMain> {
  @override
  void initState() {
    super.initState();
    loadModel().then((val) {
      setState(() {});
    });
  }

  File _image;
  double _imageWidth;
  double _imageHeight;
  var _recognitions;

  loadModel() async {
    Tflite.close();
    try {
      String res;
      res = await Tflite.loadModel(
        model: "assets/mymode/model.tflite",
        labels: "assets/mymode/labels.txt",
      );
      print(res);
    } on PlatformException {
      print("Failed to load the model");
    }
  }

  // run prediction using TFLite on given image
  // chạy dự đoán bằng TFLite trên hình ảnh nhất định
  Future predict(File image) async {
    var recognitions;
    recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );

    print(recognitions);

    setState(() {
      _recognitions = recognitions;
    });
  }

  // send image to predict method selected from gallery or camera
  // gửi hình ảnh để dự đoán phương pháp đã chọn từ thư viện hoặc máy ảnh
  sendImage(File image) async {
    if (image == null) return;
    await predict(image);

    // get the width and height of selected image
    // lấy chiều rộng và chiều cao của hình ảnh đã chọn
    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
            _image = image;
          });
        })));
  }

  // select image from gallery
  selectFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {});
    sendImage(image);
  }

  // select image from camera
  selectFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {});
    sendImage(image);
  }

  search() {
    print(_recognitions);
    print("hihih");
    print(_recognitions[0]['label'].toString());
    Get.to(SearchPage(
      label: _recognitions[0]['label'].toString(),
    ));
    Get.snackbar("Thong Bao", "Go to search screen");
  }

  sreachScreen() {}

  Widget printValue(rcg) {
    if (rcg == null) {
      return Text('',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700));
    } else if (rcg.isEmpty) {
      return Center(
        child: Text("Could not recognize",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
      );
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Center(
        child: Text(
          "Prediction: " + _recognitions[0]['label'].toString().toUpperCase(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  // gets called every time the widget need to re-render or build
  // được gọi mỗi khi tiện ích con cần kết xuất lại hoặc xây dựng
  @override
  Widget build(BuildContext context) {
    // get the width and height of current screen the app is running on
    // lấy chiều rộng và chiều cao của màn hình hiện tại mà ứng dụng đang chạy
    Size size = MediaQuery.of(context).size;

    // initialize two variables that will represent final width and height of the segmentation
    // and image preview on screen
    // khởi tạo hai biến sẽ đại diện cho chiều rộng và chiều cao cuối cùng của phân đoạn
    // và xem trước hình ảnh trên màn hình
    double finalW;
    double finalH;

    // when the app is first launch usually image width and height will be null
    // therefore for default value screen width and height is given
    // khi ứng dụng được khởi chạy lần đầu, thường chiều rộng và chiều cao của hình ảnh sẽ là rỗng
    // do đó cho giá trị mặc định chiều rộng và chiều cao màn hình được đưa ra
    if (_imageWidth == null && _imageHeight == null) {
      finalW = size.width;
      finalH = size.height;
    } else {
      // ratio width and ratio height will given ratio to
      // scale up or down the preview image
      // tỷ lệ chiều rộng và tỷ lệ chiều cao sẽ cho tỷ lệ thành
      // tăng hoặc giảm tỷ lệ hình ảnh xem trước
      double ratioW = size.width / _imageWidth;
      double ratioH = size.height / _imageHeight;

      // final width and height after the ratio scaling is applied
      // chiều rộng và chiều cao cuối cùng sau khi áp dụng chia tỷ lệ
      finalW = _imageWidth * ratioW * .85;
      finalH = _imageHeight * ratioH * .50;
    }
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            "Flutter x TF-Lite",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: printValue(_recognitions),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: _image == null
                  ? Center(
                      child: Text("Select image from camera or gallery"),
                    )
                  : Center(
                      child: Image.file(_image,
                          fit: BoxFit.fill, width: finalW, height: finalH)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Container(
                    height: 50,
                    width: 150,
                    color: Colors.redAccent,
                    child: FlatButton.icon(
                      onPressed: selectFromCamera,
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 30,
                      ),
                      color: Colors.deepPurple,
                      label: Text(
                        "Camera",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 150,
                    color: Colors.tealAccent,
                    child: FlatButton.icon(
                      onPressed: selectFromGallery,
                      icon: Icon(
                        Icons.file_upload,
                        color: Colors.white,
                        size: 30,
                      ),
                      color: Colors.blueAccent,
                      label: Text(
                        "Gallery",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  ),
                ),
              ],
            ),
            FloatingActionButton(
              onPressed: search,
              child: Icon(Icons.search),
            )
          ],
        ));
  }
}
