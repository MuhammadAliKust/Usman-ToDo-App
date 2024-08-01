import 'package:flutter/material.dart';
import 'package:usman_todo/services/auth.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
          ),
          TextField(
            controller: pwdController,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  await AuthServices()
                      .signUpUser(
                      email: emailController.text,
                      password: pwdController.text)
                      .then((value) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Registered Successfully"),
                          );
                        });
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: Text("Login"))
        ],
      ),
    );
  }
}
