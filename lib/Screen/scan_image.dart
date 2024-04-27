// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanCardScreen extends StatefulWidget {
  const ScanCardScreen({super.key, required this.code});
  final String code;

  @override
  _ScanCardScreenState createState() => _ScanCardScreenState();
}

class _ScanCardScreenState extends State<ScanCardScreen>
    with SingleTickerProviderStateMixin {
  File? _image;
  final picker = ImagePicker();

  bool textScanning = false;

  XFile? imageFile;

  String scannedText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'اشحنلي',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              fontStyle: FontStyle.italic,
              color: Color.fromARGB(255, 13, 67, 111)),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.grey[400],
            child: Center(
              child: imageFile == null
                  ? const Text('قم باختيار صوره')
                  : Image.file(
                      File(imageFile!.path),
                      fit: BoxFit.fill,
                    ),
            ),
            width: 200,
            height: 300,
          ),
          const SizedBox(height: 20),
          // Add a Text widget to display the recognized text
          Text(
            scannedText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.grey[400],
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.image,
                            size: 30,
                          ),
                          Text(
                            "المعرض",
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[600]),
                          )
                        ],
                      ),
                    ),
                  )),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.grey[400],
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.camera_alt,
                            size: 30,
                          ),
                          Text(
                            "الكاميرا",
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[600]),
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),

          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 28, 81, 125))),
            onPressed: _launchUrl,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.call,
                    size: 30,
                    color: Colors.white,
                  ),
                  Text(
                    "Call",
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await picker.pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;

        // Crop the selected image
        final croppedFile = await ImageCropper()
            .cropImage(sourcePath: pickedImage.path, aspectRatioPresets: [
          CropAspectRatioPreset.original,
        ], uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
        ]);

        if (croppedFile != null) {
          imageFile = XFile(croppedFile.path);
          setState(() {});
          getRecognisedText(imageFile!);
        }
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occurred while scanning: $e";
      print("Error getting image: $e");
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    try {
      final inputImage = InputImage.fromFilePath(image.path);
      final textDetector = GoogleMlKit.vision.textRecognizer();
      RecognizedText recognisedText =
          await textDetector.processImage(inputImage);

      String extractedText = '${widget.code}${recognisedText.text}#';

      await textDetector.close();

      print(extractedText);

      setState(() {
        scannedText = extractedText;
      });
    } catch (e) {
      // Handle errors
      print("Error getting recognised text: $e");
      setState(() {
        scannedText = "Error occurred while recognizing text: $e";
      });
    }
  }

  Future<void> _launchUrl() async {
    final String encodedScannedText = Uri.encodeComponent(scannedText);
    final Uri url = Uri.parse('tel:$encodedScannedText');

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
