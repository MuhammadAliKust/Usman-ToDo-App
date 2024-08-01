import 'package:flutter/material.dart';
import 'package:usman_todo/services/auth.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
                      .loginUser(
                          email: emailController.text,
                          password: pwdController.text)
                      .then((value) {
                    if (value!.emailVerified == false) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Kindly verify your email address")));
                    }else{
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(value!.email.toString()),
                            );
                          });
                    }

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
