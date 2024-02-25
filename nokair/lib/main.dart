import 'dart:io';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:nokair/apis/recognition_api.dart';
import 'package:nokair/apis/translation.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
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
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  String? imagePath; // Store the path of the captured image
  String? shownText;

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void setCapturedImage(String path) {
    imagePath = path;
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (BuildContext context) {
            return Image.asset(
              'assets/menubiteapplogoHorizontal.png',
              height: 60,
            );
          },
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/menubiteapplogo.png',
                    // Replace with your square logo asset path
                    height: 65, // Adjust the height as needed
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Favourites'),
              onTap: () {
                // Handle the item tap
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesPage()),
                );
              },
            ),
            ListTile(
              title: Text('History'),
              onTap: () {
                // Handle the item tap
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                // Open the gallery to pick an image
                final pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (pickedFile != null) {
                  // Save the image path to the app stat
                  File file = File('wics.csv');
                  appState.setCapturedImage(pickedFile.path);
                  final recognizedText = await RecognitionApi.recognizeText(InputImage.fromFile(File(pickedFile.path))); 
                  final translatedText = await TranslationApi.translateText(recognizedText!);
                  appState.shownText = translatedText;
                  // Run our methods that we want to run
                  print('Image selected from gallery: ${pickedFile.path}');
                  await file.writeAsString(translatedText.toString());
                }
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 150),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt_outlined, size: 100),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          if (appState.shownText != null)
            Align(
              alignment: Alignment.center,
              child: Container(
                color: Colors.grey,
                child: Text(
                  appState.shownText!,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            )
          else
            SizedBox(height:50),
            Align(
              alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical:5),
                  color: Colors.green,
                    child: Text(
                        "Failed to parse text due to image quality. Please retake photo!",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white
                      ),
                      textAlign: TextAlign.center,
                    ),
                )
            ),
        ],
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Center(
        child: Text('This is the Favorites Page'),
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 3, // Replace with the number of sections you want
          itemBuilder: (BuildContext context, int index) {
            // Provide different titles and subtitles for each section
            String sectionTitle = 'Section';
            String sectionSubtitle = 'Subtitle';

            return buildSection(sectionTitle, sectionSubtitle);
          },
        ),
      ),
    );
  }

  Widget buildSection(String title, String subtitle) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Left column with title and subtitle
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          // Add any other widgets or spacing as needed between columns
          SizedBox(width: 16),
          // Add more widgets if needed
        ],
      ),
    );
  }
}
