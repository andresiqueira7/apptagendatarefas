import 'package:flutter/material.dart';
import '/pages/home_page.dart'; // conecto à pasta de home.

// StatelessWidget = tela que não muda dinamicamente
class LoginPage extends StatelessWidget {
  // aqui crio a classe do login, que é um StatelessWidget porque a tela não muda dinamicamente, só tem os campos de email e senha e o botão de login.
  // Controllers capturam o que o usuário digita
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // aqui é onde construo a interface do login, que tem um fundo com gradiente, um container centralizado com os campos de email e senha e o botão de login.
    return Scaffold(
      // estrutura da tela
      body: Container(
        // Fundo com gradiente
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 233, 227, 244),
              const Color.fromARGB(255, 0, 97, 76),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          // Centraliza o conteúdo na tela
          child: Container(
            // aqui crio o container que vai conter os campos de email e senha e o botão de login
            padding: EdgeInsets.all(30), // espaço interno
            margin: EdgeInsets.all(20), // espaço externo

            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7), // fundo semi-transparente
              borderRadius: BorderRadius.circular(20), // bordas arredondadas
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min, // ocupa só o necessário
              children: [
                // TÍTULO
                Text(
                  'LOGIN\nAGENDA DE TAREFAS', // aqui crio o título do login, que tem o nome do app e um subtítulo.
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 20),

                // CAMPO EMAIL
                TextField(
                  controller: emailController, // captura o texto
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 15),

                // CAMPO SENHA
                TextField(
                  controller: senhaController,
                  obscureText: true, // esconde a senha
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 20),

                // BOTÃO LOGIN
                newMethod(context),

                SizedBox(height: 10),

                // TEXTO CADASTRO
                TextButton(
                  onPressed: () {
                    //  criar tela de cadastro
                  },
                  child: Text('Criar conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton newMethod(BuildContext context) {
    //aqui crio o botão de login
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purpleAccent,
        minimumSize: Size(double.infinity, 50), // largura total
      ),

      onPressed: () {
        // validar login

        // ir para inicio
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      },

      child: Text('Entrar'),
    );
  }
}
