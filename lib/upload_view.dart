import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:usman_todo/services/upload_file_services.dart';

class UploadFileView extends StatefulWidget {
  const UploadFileView({super.key});

  @override
  State<UploadFileView> createState() => _UploadFileViewState();
}

class _UploadFileViewState extends State<UploadFileView> {
  File? selectedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload File"),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              getImage();
            },
            child: selectedFile == null
                ? Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Icon(Icons.upload),
                    ),
                  )
                : Image.file(
                    selectedFile!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                UploadFileServices()
                    .getUrl(context, selectedFile)
                    .then((value) {
                  log(value.toString());
                });
              },
              child: Text("Upload"))
        ],
      ),
    );
  }

  getImage() {
    ImagePicker _imagePicker = ImagePicker();
    _imagePicker.pickImage(source: ImageSource.camera).then((value) {
      selectedFile = File(value!.path);
      setState(() {});
    });
  }
}
