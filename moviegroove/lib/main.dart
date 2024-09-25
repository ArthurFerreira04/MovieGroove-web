import 'package:flutter/material.dart';
import 'package:moviegroove/constants.dart';
import 'movies_catalog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: darkColor,
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            color: darkColor.withOpacity(0.66),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: AssetImage('assets/logoTrab.png'),
                  height: 500,
                  width: 500,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MoviesCatalog()),
                    );
                  },
                  child: Text('Sign In'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF32CD32),
                    padding: EdgeInsets.symmetric(
                      horizontal: 70,
                      vertical: 15,
                    ),
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}