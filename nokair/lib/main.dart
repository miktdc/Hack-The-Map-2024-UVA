import 'dart:io';

import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyHomePage createState() => MyHomePage(); 
  // Widget build(BuildContext context) {
  //   return ChangeNotifierProvider(
  //     create: (context) => MyAppState(),
  //     child: MaterialApp(
  //       title: 'Namer App',
  //       theme: ThemeData(
  //         useMaterial3: true,
  //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
  //       ),
  //       home: MyHomePage(),
  //     ),
  //   );
  // }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // File? selectedImage; 
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(title: 'Take a Photo :)' icon: Icons.camera_alt_outlined, onClick: () =>{}),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // appState.getNext();
                // print('button pressed!');
                  takePhoto();
                },
              style: ElevatedButton.styleFrom(
                fixedSize:
                    Size(200, 150), // Adjust the width and height as needed
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt_outlined, size: 100),
                ],
              )
            ),
          ),
          //selectedImage != null ? Image.file(selectedImage!) : const Text("Please Select An Image")
        ],
      ),
    );
  }

  Widget CustomButton({
    required String title,
    required IconData icon,
    required VoidCallback onClick, 
  }) {
    return Container(
      width: 200,
      child: ElevatedButton(
        onPressed: onClick,
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 20,
            ),
            Text(title)
          ],
        )
      )
    )

  }

  Future takePhoto() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      selectedImage = File(returnedImage!.path);
    });

  }
}
