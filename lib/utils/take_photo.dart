import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;
import 'package:permission_handler/permission_handler.dart';

class TakePhotoUtil {
  static Future takePhoto(
      {ImageSource source: ImageSource.camera, int imageQuality: 70}) async {
    PermissionStatus status = await Permission.camera.request();
    if (!status.isGranted) {
      print('[TakePhotoUtil.takePhoto]未获取拍照权限');
      return null;
    }
    File? _image;
    ImagePicker? picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: source, imageQuality: imageQuality);
    // ignore: unnecessary_null_comparison
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('[TakePhotoUtil.takePhoto] No image selected.');
    }
    picker = null;
    return _image;
  }
}
