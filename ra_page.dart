import 'package:flutter/material.dart';

class RaPage extends StatelessWidget {
  //Crio a classe da pagina de RA;
  @override //interface
  Widget build(BuildContext context) {
    return Scaffold(
      //estrutura básica da tela, com appBar e body.
      appBar: AppBar(title: Text('Perfil')),

      body: Column(
        //coluna que vai conter o card do RA e outras informações
        children: [
          // RA CARD
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ), // aqui crio um gradiente de cor para o card do RA.
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),

            child: Row(
              // aqui crio uma linha para colocar as informações do RA.
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.deepPurple),
                ),

                SizedBox(width: 16),

                Column(
                  // aqui crio uma coluna para colocar o nome e o RA do usuário.
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Andre Luiz Siqueira",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      "RA: 1184031-1",
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
