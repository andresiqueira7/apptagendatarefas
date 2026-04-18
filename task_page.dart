import 'package:flutter/material.dart';

// StatefulWidget = tela dinâmica
class TaskPage extends StatefulWidget {
  //criando a classe da página de tarefas, que é um StatefulWidget porque a lista de tarefas pode mudar dinamicamente.
  final DateTime data; // data selecionada
  final Map<String, List<Map<String, dynamic>>>
  tarefasPorData; // mapa que guarda as tarefas por data, onde a chave é uma string no formato "ano-mês-dia" e o valor é uma lista de mapas com o título da tarefa e se ela está concluída ou não.

  TaskPage({
    required this.data,
    required this.tarefasPorData,
  }); // construtor da classe, que recebe a data e o mapa de tarefas por data.

  @override
  _TaskPageState createState() => _TaskPageState(); // aqui crio o estado da página de tarefas, que é onde vai ficar a lógica para adicionar, remover e marcar as tarefas como concluídas.
}

class _TaskPageState extends State<TaskPage> {
  // aqui é onde vai ficar a lógica para adicionar, remover e marcar as tarefas como concluídas.
  // 🔑 Gera chave da data
  String getDataKey(DateTime data) {
    return "${data.year}-${data.month}-${data.day}";
  }

  // 📋 Lista de tarefas daquele dia
  List<Map<String, dynamic>> get tarefas {
    // aqui crio uma função que retorna a lista de tarefas daquele dia, usando a chave gerada pela função getDataKey para acessar o mapa de tarefas por data.
    String chave = getDataKey(widget.data);
    return widget.tarefasPorData[chave] ?? [];
  }

  // ➕ Adicionar tarefa
  void adicionarTarefa(String titulo) {
    // aqui crio a função para adicionar uma tarefa, que recebe o título da tarefa e adiciona no mapa de tarefas por data, usando a chave gerada pela função getDataKey para acessar o mapa e adicionando um novo mapa com o título da tarefa e o status de concluída como false.
    if (titulo.isEmpty) return;

    String chave = getDataKey(
      widget.data,
    ); // aqui gero a chave da data usando a função getDataKey, passando a data atual da página de tarefas.

    setState(() {
      widget.tarefasPorData.putIfAbsent(
        chave,
        () => [],
      ); // aqui uso o putIfAbsent para garantir que a chave exista no mapa de tarefas por data, se não existir eu crio uma nova lista vazia para aquela chave.

      widget.tarefasPorData[chave]!.add(
        {'titulo': titulo, 'concluida': false},
      ); // aqui adiciono um novo mapa com o título da tarefa e o status de concluída como false na lista de tarefas daquela data, usando a chave para acessar o mapa de tarefas por data.
    });
  }

  //  Remover tarefa
  void removerTarefa(int index) {
    String chave = getDataKey(widget.data);

    setState(() {
      widget.tarefasPorData[chave]?.removeAt(index);
    });
  }

  //  Marcar como concluída
  void toggleTarefa(int index) {
    String chave = getDataKey(widget.data);

    setState(() {
      // aqui uso o setState para atualizar a interface quando a tarefa for marcada como concluída ou não, usando o index para acessar a tarefa na lista de tarefas daquela data e invertendo o valor do status de concluída.
      widget.tarefasPorData[chave]![index]['concluida'] =
          !widget.tarefasPorData[chave]![index]['concluida'];
    });
  }

  //  Dialog para nova tarefa
  void mostrarDialogo() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],

        title: Text(
          'Nova tarefa',
        ), // aqui crio o título do diálogo para adicionar uma nova tarefa.

        content: TextField(
          // aqui crio o campo de texto para digitar o título da nova tarefa, usando um TextEditingController para capturar o que o usuário digita.
          controller: controller,
          decoration: InputDecoration(hintText: 'Digite a tarefa...'),
        ),

        actions: [
          // aqui crio os botões de ação do diálogo, um para cancelar e outro para adicionar a tarefa, onde o botão de adicionar chama a função para adicionar a tarefa passando o texto digitado no campo de texto e depois fecha o diálogo.
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancelar'),
          ),

          ElevatedButton(
            // aqui crio o botão de adicionar, que chama a função para adicionar a tarefa passando o texto digitado no campo de texto e depois fecha o diálogo.
            onPressed: () {
              adicionarTarefa(controller.text);
              Navigator.pop(context);
            },
            child: Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // aqui é onde construo a interface da página de tarefas, que tem um appBar com a data selecionada, um botão flutuante para adicionar uma nova tarefa e um corpo que mostra a lista de tarefas daquele dia, usando um ListView.builder para criar os itens dinamicamente.
    // 🔥 LISTA ORDENADA (não concluídas primeiro)
    List<Map<String, dynamic>> listaOrdenada = List.from(tarefas);

    listaOrdenada.sort((a, b) {
      // aqui uso a função sort para ordenar a lista de tarefas, colocando as tarefas não concluídas primeiro e as concluídas depois, comparando o valor do status de concluída de cada tarefa.
      if (a['concluida'] == b['concluida'])
        return 0; // se as duas tarefas tiverem o mesmo status de concluída, elas ficam na mesma posição.
      return a['concluida']
          ? 1
          : -1; // se a tarefa a estiver concluída e a tarefa b não estiver, a tarefa a vai para depois da tarefa b, retornando 1. Se a tarefa a não estiver concluída e a tarefa b estiver, a tarefa a vai para antes da tarefa b, retornando -1.
    });

    return Scaffold(
      // aqui crio a estrutura básica da tela, com um appBar que mostra a data selecionada, um botão flutuante para adicionar uma nova tarefa e um corpo que mostra a lista de tarefas daquele dia.
      appBar: AppBar(
        //  Mostra data no topo
        title: Text(
          "${widget.data.day}/${widget.data.month}/${widget.data.year}",
        ),
        backgroundColor: Colors.blueAccent,
      ),

      floatingActionButton: FloatingActionButton(
        // aqui crio o botão flutuante para adicionar uma nova tarefa, que chama a função mostrarDialogo para abrir o diálogo de adicionar tarefa.
        backgroundColor: Colors.greenAccent,
        onPressed: mostrarDialogo,
        child: Icon(Icons.add),
      ),

      body: Container(
        // aqui crio o container que vai conter a lista de tarefas, com um fundo bonito usando um gradiente de cor.
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child:
            tarefas
                .isEmpty // aqui verifico se a lista de tarefas daquele dia está vazia, se estiver eu mostro uma mensagem dizendo que não tem nenhuma tarefa naquele dia, se não estiver eu mostro a lista de tarefas usando um ListView.builder para criar os itens dinamicamente.
            ? Center(
                child: Text(
                  'Nenhuma tarefa neste dia 😢', //Mensagem de retorno, usei emogi para me conectar mais com o usuário.
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
            : ListView.builder(
                // aqui crio o ListView.builder para mostrar a lista de tarefas daquele dia, usando a lista ordenada para mostrar as tarefas não concluídas primeiro e as concluídas depois.
                itemCount: listaOrdenada.length,
                itemBuilder: (context, index) {
                  final tarefa = listaOrdenada[index];

                  return Card(
                    // aqui crio um card para cada tarefa
                    color: Colors.black.withOpacity(0.6),
                    margin: EdgeInsets.all(8),

                    child: ListTile(
                      // aqui crio um ListTile para mostrar o título da tarefa, um checkbox para marcar como concluída e um botão de delete para remover a tarefa.
                      title: Text(
                        tarefa['titulo'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          decoration: tarefa['concluida']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),

                      leading: Checkbox(
                        // aqui crio o checkbox para marcar a tarefa como concluída, usando o valor do status de concluída da tarefa e chamando a função toggleTarefa passando o index original da tarefa na lista de tarefas daquele dia para atualizar o status de concluída.
                        value: tarefa['concluida'],
                        onChanged: (value) {
                          //  usa index original
                          toggleTarefa(tarefas.indexOf(tarefa));
                        },
                      ),

                      trailing: IconButton(
                        // aqui crio o botão de delete para remover a tarefa, usando um ícone de lixeira e chamando a função removerTarefa passando o index original da tarefa na lista de tarefas daquele dia para remover a tarefa do mapa de tarefas por data.
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          removerTarefa(
                            tarefas.indexOf(tarefa),
                          ); // aqui uso o index original da tarefa na lista de tarefas daquele dia para remover a tarefa do mapa de tarefas por data, garantindo que a tarefa correta seja removida mesmo com a ordenação.
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
