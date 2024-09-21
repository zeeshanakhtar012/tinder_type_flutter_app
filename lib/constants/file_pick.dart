import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class PickedImageData {
  final String name;
  final String path;
  final String fileType;

  PickedImageData(this.name, this.path, this.fileType);
}

class FilePick{
  Future<FilePickerResult?> PickFile(List<String> type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: type,
    );
    var files = [];
    if (result != null) {
      PlatformFile file = result.files.first;
      print(file.name);
      print(file.bytes);
      print(files);
      print(file.size);
      print(file.extension);
      print(file.path);
    } else {
      Get.snackbar("Alert", "No File Pick");
    }
    return result;
  }
  static String getFileType(String fileName) {
    return fileName.split('.').last.toLowerCase();
  }
  Future<PickedImageData?> pickFile(FileType fileType) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: false, // Ensure only one file is selected
          type:fileType
      );
      if (result == null || result.files.isEmpty) return null;
      if (result != null) {
        var files= result.files.single;
        final name = files.name;
        final path = files.path;
        final fileType = getFileType(name);
        return PickedImageData(name, path!, fileType);
      }
    } catch (e) {
      Get.snackbar("Alert", e.toString());
    }
  }
  Future<String> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile == null) {
        print("User canceled the picker");
        return "User canceled the picker"; // User canceled the picker
      }
      return pickedFile.path;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
  Future<List<String>> pickMultipleImages() async {
    List<String> imagePaths = [];

    try {
      var result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: ["png","jpg","jpeg"],// Allow picking multiple files
      );

      if (result != null) {
        // Get paths of selected images
        for (var res in result.files) {
          imagePaths.add(res.path!);
        }
      }
    } catch (e) {
      // Handle any errors that occur during the image picking process
      print('Error picking images: $e');
    }

    return imagePaths;
  }

}