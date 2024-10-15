import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final String title;
  const MainPage({Key? key, required this.title}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  List<Map<String, String>> userData = [];

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple, // Cor do AppBar
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(32),
          children: <Widget>[
            createField(
              controller: firstNameController,
              errorMessage: 'Nome necessário!',
              hintName: 'Abner',
              labelName: 'Nome',
              inputType: TextInputType.name,
            ),
            const SizedBox(height: 20),
            createField(
              controller: lastNameController,
              errorMessage: 'Sobrenome necessário!',
              hintName: 'Silva',
              labelName: 'Sobrenome',
              inputType: TextInputType.name,
            ),
            const SizedBox(height: 20),
            createField(
              controller: emailController,
              errorMessage: 'Por favor, insira um E-mail válido!',
              hintName: 'exemplo@teste.com',
              labelName: 'Email',
              inputType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'Digite um e-mail válido!';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            createField(
              controller: passwordController,
              errorMessage: 'Senha deve ter pelo menos 6 caracteres!',
              hintName: 'Sua senha...',
              labelName: 'Senha',
              inputType: TextInputType.visiblePassword,
              minLength: 6,
              isPassword: true,
            ),
            const SizedBox(height: 20),
            createField(
              controller: confirmPasswordController,
              errorMessage: 'Confirme sua senha!',
              hintName: 'Repita sua senha...',
              labelName: 'Confirmar Senha',
              inputType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null || value != passwordController.text) {
                  return 'As senhas não coincidem!';
                }
                return null;
              },
              isPassword: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Cor do botão
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    userData.add({
                      'Nome': firstNameController.text,
                      'Sobrenome': lastNameController.text,
                      'Email': emailController.text,
                    });
                    firstNameController.clear();
                    lastNameController.clear();
                    emailController.clear();
                    passwordController.clear();
                    confirmPasswordController.clear();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Dados salvos com sucesso!')),
                  );
                }
              },
              child: const Text('Enviar'),
            ),
            const SizedBox(height: 20),
            if (userData.isNotEmpty)
              ...userData.map((data) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nome: ${data['Nome']} ${data['Sobrenome']}'),
                      Text('Email: ${data['Email']}'),
                      const SizedBox(height: 10),
                    ],
                  )),
          ],
        ),
      ),
    );
  }

  Widget createField({
    required TextEditingController controller,
    required String errorMessage,
    required String hintName,
    required String labelName,
    required TextInputType inputType,
    bool isPassword = false,
    int minLength = 0,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return errorMessage;
            }
            if (isPassword && minLength > 0 && value.length < minLength) {
              return '$labelName deve ter pelo menos $minLength caracteres!';
            }
            return null;
          },
      decoration: InputDecoration(
        hintText: hintName,
        labelText: labelName,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple), // Cor ao focar
        ),
      ),
      keyboardType: inputType,
    );
  }
}
