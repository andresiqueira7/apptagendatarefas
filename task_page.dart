import 'package:flutter/material.dart';

// StatefulWidget = tela dinâmica
class TaskPage extends StatefulWidget {
  final DateTime data; // data selecionada
  final Map<String, List<Map<String, dynamic>>> tarefasPorData;

  TaskPage({
    required this.data,
    required this.tarefasPorData,
  });

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  // 🔑 Gera chave da data
  String getDataKey(DateTime data) {
    return "${data.year}-${data.month}-${data.day}";
  }

  // 📋 Lista de tarefas daquele dia
  List<Map<String, dynamic>> get tarefas {
    String chave = getDataKey(widget.data);
    return widget.tarefasPorData[chave] ?? [];
  }

  // ➕ Adicionar tarefa
  void adicionarTarefa(String titulo) {
    if (titulo.isEmpty) return;

    String chave = getDataKey(widget.data);

    setState(() {
      widget.tarefasPorData.putIfAbsent(chave, () => []);

      widget.tarefasPorData[chave]!.add({
        'titulo': titulo,
        'concluida': false,
      });
    });
  }

  // ❌ Remover tarefa
  void removerTarefa(int index) {
    String chave = getDataKey(widget.data);

    setState(() {
      widget.tarefasPorData[chave]?.removeAt(index);
    });
  }

  // ✔️ Marcar como concluída
  void toggleTarefa(int index) {
    String chave = getDataKey(widget.data);

    setState(() {
      widget.tarefasPorData[chave]![index]['concluida'] =
          !widget.tarefasPorData[chave]![index]['concluida'];
    });
  }

  // 📝 Dialog para nova tarefa
  void mostrarDialogo() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],

        title: Text('Nova tarefa'),

        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Digite a tarefa...'),
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancelar'),
          ),

          ElevatedButton(
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

    // 🔥 LISTA ORDENADA (não concluídas primeiro)
    List<Map<String, dynamic>> listaOrdenada = List.from(tarefas);

    listaOrdenada.sort((a, b) {
      if (a['concluida'] == b['concluida']) return 0;
      return a['concluida'] ? 1 : -1;
    });

    return Scaffold(
      appBar: AppBar(
        // 📅 Mostra data no topo
        title: Text(
          "${widget.data.day}/${widget.data.month}/${widget.data.year}",
        ),
        backgroundColor: Colors.blueAccent,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: mostrarDialogo,
        child: Icon(Icons.add),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: tarefas.isEmpty
            ? Center(
                child: Text(
                  'Nenhuma tarefa neste dia 😢',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
            : ListView.builder(
                itemCount: listaOrdenada.length,
                itemBuilder: (context, index) {
                  final tarefa = listaOrdenada[index];

                  return Card(
                    color: Colors.black.withOpacity(0.6),
                    margin: EdgeInsets.all(8),

                    child: ListTile(
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
                        value: tarefa['concluida'],
                        onChanged: (value) {
                          // 🔥 usa index original
                          toggleTarefa(tarefas.indexOf(tarefa));
                        },
                      ),

                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          removerTarefa(tarefas.indexOf(tarefa));
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