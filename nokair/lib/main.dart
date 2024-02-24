import 'dart:io';
import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
=======
>>>>>>> refs/remotes/origin/main
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
<<<<<<< HEAD
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
=======
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: MyHomePage(),
      ),
    );
  }
>>>>>>> refs/remotes/origin/main
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  String? imagePath; // Store the path of the captured image

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void setCapturedImage(String path) {
    imagePath = path;
    notifyListeners();
  }
}

class MyHomePage extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    // File? selectedImage; 
=======
    var appState = context.watch<MyAppState>();

>>>>>>> refs/remotes/origin/main
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MenuBITE',
          style: TextStyle(
            fontSize: 70,
            fontFamily: 'Arial',
            color: Colors.orange,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Handle the item tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Handle the item tap
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(title: 'Take a Photo :)' icon: Icons.camera_alt_outlined, onClick: () =>{}),
          Center(
            child: ElevatedButton(
<<<<<<< HEAD
              onPressed: () {
                // appState.getNext();
                // print('button pressed!');
                  takePhoto();
                },
=======
              onPressed: () async {
                // Open the gallery to pick an image
                final pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );

                if (pickedFile != null) {
                  // Save the image path to the app state
                  appState.setCapturedImage(pickedFile.path);

                  // Run our methods that we want to run

                  print('Image selected from gallery: ${pickedFile.path}');
                }
              },
>>>>>>> refs/remotes/origin/main
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 150),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt_outlined, size: 100),
                ],
              )
            ),
          ),
<<<<<<< HEAD
          //selectedImage != null ? Image.file(selectedImage!) : const Text("Please Select An Image")
=======
          SizedBox(height: 20),
          // Display the selected image if available
          appState.imagePath != null
              ? Image.file(File(appState.imagePath!))
              : Container(),
>>>>>>> refs/remotes/origin/main
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
