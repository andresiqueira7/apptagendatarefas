// Aqui crio o calendário, onde o usuário pode ver os dias do mês e clicar para ver as tarefas.
import 'package:flutter/material.dart';
import '/pages/task_page.dart'; //conecto à pasta de tarefas.

class CalendarPage extends StatefulWidget {
  final Map<String, List<Map<String, dynamic>>> tarefasPorData;

  CalendarPage({required this.tarefasPorData});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime dataAtual = DateTime.now();

  void mudarMes(int valor) {
    setState(() {
      dataAtual = DateTime(dataAtual.year, dataAtual.month + valor);
    });
  }

  // VERIFICA SE TEM TAREFA
  bool temTarefa(DateTime data) {
    String chave = "${data.year}-${data.month}-${data.day}";
    return widget.tarefasPorData[chave]?.isNotEmpty ?? false;
  }

  @override
  Widget build(BuildContext context) {
    int diasNoMes = DateTime(dataAtual.year, dataAtual.month + 1, 0).day;

    return Scaffold(
      appBar: AppBar(title: Text('Calendário')),

      body: Column(
        children: [
          // HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => mudarMes(-1),
              ),

              Text(
                '${dataAtual.month}/${dataAtual.year}',
                style: TextStyle(fontSize: 20),
              ),

              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () => mudarMes(1),
              ),
            ],
          ),

          // DIAS
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemCount: diasNoMes,

              itemBuilder: (context, index) {
                int dia = index + 1;

                DateTime data = DateTime(dataAtual.year, dataAtual.month, dia);

                bool tem = temTarefa(data);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TaskPage(
                          data: data,
                          tarefasPorData: widget.tarefasPorData,
                        ),
                      ),
                    );
                  },

                  child: Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: tem ? Colors.green : Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            '$dia',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                        if (tem)
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
