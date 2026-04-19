import 'package:flutter/material.dart';
import '../pages/login_page.dart';

void main() {
  //inicio
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //criada a classe do app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AGENDA DE TAREFAS', //titulo do app.
      debugShowCheckedModeBanner: false, //tira a tag de debug do app.
      theme: ThemeData.dark(), //tema escuro para o app.
      home: LoginPage(), // começa no login
    );
  }
}
