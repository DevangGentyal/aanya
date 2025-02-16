import 'dart:typed_data';

import 'package:Aanya/common_vars.dart';
import 'package:Aanya/database/user_management.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:image_gallery_saver/image_gallery_saver.dart';

var userManagement = Get.find<UserManagement>();

class EnlargeableImage extends StatelessWidget {
  final ImageProvider image;
  const EnlargeableImage({Key? key, required this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.black,
              child: Stack(
                children: [
                  Container(
                    width: 300 * fem,
                    height: 300 * fem,
                    child: Image(
                      image: image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: ElevatedButton(
                      onPressed: () async {
                        await saveImageToGallery(image, context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(129, 255, 255, 255),
                      ),
                      child: Icon(
                        Icons.download_sharp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.all(10 * fem),
        width: 130 * fem,
        height: 130 * fem,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(image: image),
        ),
      ),
    );
  }

  Future<void> saveImageToGallery(
      ImageProvider imageProvider, BuildContext context) async {
    String imageUrl = '';

    if (imageProvider is FileImage) {
      imageUrl =
          userManagement.getImageURL(path.basename(imageProvider.file.path));
    } else {
      NetworkImage networkImage = imageProvider as NetworkImage;
      imageUrl = networkImage.url;
    }
    var response = await Dio()
        .get(imageUrl, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: DateTime.now().toString());
    print(result);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image Saved to Gallery!'),
      ),
    );
  }
}
