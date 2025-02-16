
import 'dart:io';
import 'package:Aanya/database/user_management.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<File?> imageGenAPI(
  String prompt,
) async {
  await dotenv.load();
  print("Image Gen API called");

  var userManagement = Get.find<UserManagement>();

  try {
    var url = Uri.parse('https://clipdrop-api.co/text-to-image/v1');
    var form = http.MultipartRequest('POST', url);

    form.fields.addAll({
      'prompt': prompt,
    });

    form.headers.addAll({
      'x-api-key':dotenv.env['CLIPDROP_API_KEY'],
    });

    http.Response response = await http.Response.fromStream(await form.send());
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final tempdir = await getTemporaryDirectory();
      final tempname = await DateTime.now().toString().toLowerCase();
      final tempFile = File("${tempdir.path}/" + tempname + ".png");
      await tempFile.writeAsBytes(bytes);
      print("Images Generated Successfully");

      // Updating Activity
      final newactivity = userManagement.createActivity(
          prompt: prompt,
          response: "Generated Images",
          desc_image_path: "null",
          gen_image_path: tempname + ".png");
      userManagement.updateRecentActivites(newactivity);
      userManagement.uploadImage(tempFile);

      return tempFile;
    } else {
      print('Failed to generate image: ${response.statusCode}');
      print('Response Body: ${response.body}');
      return null;
    }
  } catch (e) {
    print('Failed to generate image: $e');
    return null;
  }
}
