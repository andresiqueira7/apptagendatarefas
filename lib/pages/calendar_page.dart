// Aqui crio o calendário, onde o usuário pode ver os dias do mês e clicar para ver as tarefas.
import 'package:flutter/material.dart';
import '/pages/task_page.dart'; //conecto à pasta de tarefas.

class CalendarPage extends StatefulWidget {
  //criando a classe do calendário, que é um StatefulWidget porque o mês pode mudar.
  final Map<String, List<Map<String, dynamic>>> tarefasPorData;

  CalendarPage({required this.tarefasPorData});

  @override
  _CalendarPageState createState() => _CalendarPageState(); //criando o estado do calendário.
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime dataAtual = DateTime.now();

  void mudarMes(int valor) {
    //função para mudar o mês, recebe um valor que pode ser -1 ou 1.
    setState(() {
      dataAtual = DateTime(dataAtual.year, dataAtual.month + valor);
    });
  }

  // VERIFICA SE TEM TAREFA
  bool temTarefa(DateTime data) {
    //função para verificar se tem tarefa, recebe uma data e retorna um booleano.
    String chave = "${data.year}-${data.month}-${data.day}";
    return widget.tarefasPorData[chave]?.isNotEmpty ?? false;
  }

  @override // aqui é onde construo a interface do calendário.
  Widget build(BuildContext context) {
    // aqui calculo quantos dias tem no mês atual, usando a função do DateTime que retorna o último dia do mês.
    int diasNoMes = DateTime(dataAtual.year, dataAtual.month + 1, 0).day;

    return Scaffold(
      appBar: AppBar(title: Text('Calendário')),

      body: Column(
        // aqui crio a coluna que vai conter o header e os dias do mês.
        children: [
          // HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => mudarMes(
                  -1,
                ), // aqui chamo a função para mudar o mês, passando -1 para voltar um mês.
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
            // aqui crio o grid que vai mostrar os dias do mês, usando o GridView.builder para criar os itens dinamicamente.
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemCount: diasNoMes,

              itemBuilder: (context, index) {
                int dia = index + 1;

                DateTime data = DateTime(dataAtual.year, dataAtual.month, dia);

                bool tem = temTarefa(
                  data,
                ); // aqui chamo a função para verificar se tem tarefa, passando a data atual do dia.
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
                    // aqui crio o container que vai mostrar o dia, com uma cor diferente se tiver tarefa ou não.
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: tem ? Colors.green : Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Stack(
                      // aqui uso o Stack para colocar o número do dia no centro e um ponto no canto se tiver tarefa.
                      children: [
                        Center(
                          child: Text(
                            '$dia',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                        if (tem) // aqui verifico se tem tarefa, se tiver eu mostro um ponto branco no canto inferior direito do dia.
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
