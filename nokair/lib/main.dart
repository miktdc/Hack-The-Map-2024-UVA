import 'dart:io';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var menuImage;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                // appState.getNext();
                // print('button pressed!');
                File? image; 
                Future takePhoto() async {
                  try {
                    final image = await ImagePicker().pickImage(source: ImageSource.camera);
                    if(image == null) return; 
                    final imageTemp = File(image.path); 
                    menuImage= imageTemp;
                  }
                  on Exception catch(e){
                    print('Failed to pick image: $e');
                  }
                  }
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
