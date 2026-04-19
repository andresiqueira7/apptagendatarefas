import 'package:flutter/material.dart';
import '/pages/calendar_page.dart'; //conecto à pasta de calendário.
import '/pages/ra_page.dart'; //conecto à pasta de RA.

class HomePage extends StatelessWidget {
  //  AQUI ficam TODAS as tarefas do app
  final Map<String, List<Map<String, dynamic>>> tarefasPorData = {};

  @override
  Widget build(BuildContext context) {
    // aqui construo a interface do home page, que tem um fundo, um título, um subtítulo e dois cards para acessar o calendário e o RA.
    return Scaffold(
      body: Container(
        // Fundo bonito
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blueAccent], //
            begin: Alignment.topLeft,
            end: Alignment
                .bottomRight, // aqui crio um gradiente de cor para o fundo.
          ),
        ),

        child: SafeArea(
          // aqui uso o SafeArea para evitar que os elementos fiquem embaixo da barra
          child: Padding(
            padding: EdgeInsets.all(20),

            child: Column(
              // aqui crio a coluna que vai conter a mensagem inicial.
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TÍTULO
                Text(
                  //
                  'Bem-vindo 👋',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 10),

                // SUBTEXTO
                Text(
                  'Organize seu dia de forma inteligente 📅',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),

                SizedBox(height: 40),

                Expanded(
                  child: Column(
                    children: [
                      // 📅 CALENDÁRIO
                      buildCard(
                        // aqui chamo a função para criar o card do calendário, passando o título, a cor e a página do calendário, que recebe o map de tarefas por data para mostrar os dias com tarefas.
                        context,
                        title: '📅 Acessar Calendário',
                        color: Colors.purpleAccent,
                        page: CalendarPage(
                          tarefasPorData: tarefasPorData, //  PASSA O MAP
                        ),
                      ),

                      SizedBox(height: 20),

                      // 👤 SOBRE / RA
                      buildCard(
                        // aqui chamo a função para criar o card do RA, passando o título, a cor e a página do RA, que é uma página simples com informações do aluno.
                        context,
                        title: '👤 ALUNO E RA',
                        color: Colors.greenAccent,
                        page: RaPage(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // FUNÇÃO PARA CRIAR CARDS
  Widget buildCard(
    // aqui crio uma função para criar os cards do home page, que recebe o contexto, o título, a cor e a página para navegar quando clicar.
    BuildContext context, {
    required String title,
    required Color color,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },

      child: Container(
        // aqui crio o container do card
        width: double.infinity,
        padding: EdgeInsets.all(25),

        decoration: BoxDecoration(
          color: color.withOpacity(0.85),
          borderRadius: BorderRadius.circular(20),
        ),

        child: Text(
          //card
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
