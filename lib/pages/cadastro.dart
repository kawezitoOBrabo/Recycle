import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controlador
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();

  // Key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Image.asset(
                      "assets/logo.png",
                      color: Color.fromARGB(199, 71, 224, 97),
                      height: 80,
                    ),
                    Text(
                      'ReCycle',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(199, 71, 224, 97),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    const SizedBox(height: 32),
                    Material(
                      elevation: 20,
                      shadowColor: Colors.black38,
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Campo e-mail obrigatório.';
                          } else if (value!.contains('@')) {
                            return null;
                          } else {
                            return 'Você precisa de um e-mail válido.';
                          }
                        },
                        cursorColor: const Color(0xFF10397B),
                        decoration: buildInputDecoration(
                          'E-mail',
                          Icons.mail_outline_outlined,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Material(
                      elevation: 20,
                      shadowColor: Colors.black38,
                      child: TextFormField(
                        controller: telefoneController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.length >= 6) {
                            return null;
                          } else {
                            return 'Você precisa de uma senha válida.';
                          }
                        },
                        cursorColor: const Color(0xFF10397B),
                        decoration: buildInputDecoration(
                          'Telefone',
                          Icons.phone,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Material(
                      elevation: 20,
                      shadowColor: Colors.black38,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.cell,
                        child: TextFormField(
                          controller: cepController,
                          obscureText: false,
                          validator: (value) {
                            if (value!.length >= 6) {
                              return null;
                            } else {
                              return 'Você precisa de uma senha válida.';
                            }
                          },
                          cursorColor: const Color(0xFF10397B),
                          decoration: buildInputDecoration(
                            'Cep',
                            Icons.location_on,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    Material(
                      elevation: 20,
                      shadowColor: Colors.black38,
                      child: TextFormField(
                        controller: senhaController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.length >= 6) {
                            return null;
                          } else {
                            return 'Você precisa de uma senha válida.';
                          }
                        },
                        cursorColor: const Color(0xFF10397B),
                        decoration: buildInputDecoration(
                          'Senha',
                          Icons.lock_outline,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Validar os campos de e-mail e senha
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(199, 71, 224, 97),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 32,
                        ),
                        elevation: 4,
                      ),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "já tem uma conta?",
                            ),
                            Image.asset("assets/google.png"),
                          ],
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        Column(
                          children: [
                            Text(
                              "Faça login",
                            ),
                            Image.asset("assets/facebook.png"),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildInputDecoration(String label, IconData iconData) {
    return InputDecoration(
      suffixIcon: Icon(iconData),
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      floatingLabelStyle: const TextStyle(
        color: Color.fromARGB(197, 21, 126, 38),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Color.fromARGB(198, 113, 196, 127),
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color.fromARGB(199, 71, 224, 97),
          width: 2,
        ),
      ),
    );
  }
}

/*

Container(
        decoration: BoxDecoration(
          color: Color(0xffC8E6C9),
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text("Olá mundo"),
        ),
      ),
*/
