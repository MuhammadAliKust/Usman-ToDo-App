import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:usman_todo/services/auth.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Forgot Password"),
        ),
        body: Column(
          children: [
            TextField(
              controller: emailController,
            ),
            ElevatedButton(
                onPressed: () async {
                  log('called');
                  try {
                    await AuthServices()
                        .forgotPassword(emailController.text)
                        .then((value) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  "An email with password reset link has been sent to your mail box. Kindly tap to reset your password"),
                            );
                          });
                    });
                  } catch (e) {
                    log(e.toString());
                  }
                },
                child: Text("Forgot Password"))
          ],
        ),
      ),
    );
  }
}
