import 'package:flutter/material.dart';
import 'package:moviegroove/constants.dart';

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
              mainAxisSize: MainAxisSize.min, // Isso ajuda a centralizar sem espaço extra
              children: [
                // Logo no centro da tela
                Image(
                  image: AssetImage('assets/logoTrab.png'),
                  height: 500, // Ajuste o tamanho conforme necessário
                  width: 500,
                ),
                SizedBox(height: 10), // Espaço reduzido entre a imagem e o botão
                // Botão abaixo da imagem
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Sign In'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF32CD32), // Cor de fundo do botão
                    padding: EdgeInsets.symmetric(
                      horizontal: 70, // Aumentando o tamanho lateral do botão
                      vertical: 15,  // Diminuindo a altura do botão
                    ),
                    textStyle: TextStyle(
                      fontSize: 18, // Tamanho da fonte
                      color: Colors.black, // Cor da fonte
                    ),
                    foregroundColor: Colors.black, // Cor da fonte para garantir que seja preta
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
