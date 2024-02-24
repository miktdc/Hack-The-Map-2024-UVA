import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MenuBITE',
          style: TextStyle(
            fontSize: 40, // Adjust the font size as needed
            fontFamily: 'Arial', // Change the font family as needed
            color: Colors.orange, // Change the text color as needed
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
                color: Colors.green, // Adjust the color as needed
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white, // Adjust the text color as needed
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Favourites'),
              onTap: () {
                // Handle the item tap
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('History'),
              onTap: () {
                // Handle the item tap
                Navigator.pop(context); // Close the drawer
              },
            ),
            // Add more ListTile items as needed
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                print('button pressed!');
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
