import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:usman_todo/get_all_task.dart';
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
                FirebaseMessaging.instance.getToken().then((val) {
                  log(val.toString());
                });
                // try {
                //   await AuthServices()
                //       .loginUser(
                //           email: emailController.text,
                //           password: pwdController.text)
                //       .then((value) {
                //     if (value!.emailVerified == false) {
                //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //           content: Text("Kindly verify your email address")));
                //     } else {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => GetAllTaskView()));
                //     }
                //   });
                // } catch (e) {
                //   ScaffoldMessenger.of(context)
                //       .showSnackBar(SnackBar(content: Text(e.toString())));
                // }
              },
              child: Text("Login"))
        ],
      ),
    );
  }
}
