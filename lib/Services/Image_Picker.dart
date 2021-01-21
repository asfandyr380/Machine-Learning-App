import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File> pickImage() async 
{
  var pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
  if(pickedImage == null)
  {
    print("No Image Selected");
  }
  File imageFile = File(pickedImage.path);
  return imageFile;

}
