import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  XFile? image = await picker.pickImage(source: source);

  if (image != null) {
    return await image.readAsBytes();
  }
  print("no image selected");
}

showSnackbar(BuildContext context, res) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
}
