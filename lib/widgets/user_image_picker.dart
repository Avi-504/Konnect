import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;
  UserImagePicker(this.imagePickFn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final _picker = ImagePicker();
  File _pickedImage;
  void _pickImage() async {
    final pickedImageFile = await _picker.getImage(
      source: ImageSource.camera,
      imageQuality: 75,
      maxWidth: 220,
    );
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.imagePickFn(File(pickedImageFile.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: _pickedImage != null
                ? FileImage(_pickedImage)
                : AssetImage('assets/camera.png'),
            backgroundColor: Colors.black45,
          ),
          onTap: _pickImage,
        ),
        // FlatButton.icon(
        //   textColor: Theme.of(context).primaryColor,
        //   onPressed: _pickImage,
        //   icon: Icon(Icons.image),
        //   label: Text('Pick Image'),
        // ),
      ],
    );
  }
}
