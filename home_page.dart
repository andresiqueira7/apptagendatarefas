import 'package:flutter/material.dart';
import 'pages/calendar_page.dart';
import 'pages/ra_page.dart';

class HomePage extends StatelessWidget {
  // 🔥 AQUI fica TODAS as tarefas do app
  final Map<String, List<Map<String, dynamic>>> tarefasPorData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Fundo bonito
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TÍTULO
                Text(
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
        width: double.infinity,
        padding: EdgeInsets.all(25),

        decoration: BoxDecoration(
          color: color.withOpacity(0.85),
          borderRadius: BorderRadius.circular(20),
        ),

        child: Text(
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
