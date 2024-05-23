import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/my_textfield.dart';
import '../components/util.dart';

import 'dart:developer';

import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final userNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  // sign up method
  void signUserUp() async {
    // show loading circle
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // try creating account
      try {
        // check if password is confirmed
        if(passwordController.text == confirmPasswordController.text) {
          // await FirebaseAuth.instance.createUserWithEmailAndPassword(
          await AuthService.instance.signUpWithEmailAndPassword(
            emailController.text,
            passwordController.text,
          );
          //Navigator.pop(context);
        }else{
          // show error message, password don't match
          setState(() {
            confirmPasswordError = "Password don't match";
          });
          //_formKey.currentState!.validate();
        }
        // remove loading circle
        // Navigator.pop(context);
      } on Exception catch (e) {
        setState(() {
          if (e.toString().contains('invalid-email')) {
            emailError = 'Invalid email';
          } else if (e.toString().contains('invalid-credential')) {
            passwordError = 'Weak password';
          } else {
            emailError = 'Unknown error: ${e.toString()}';

            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: Text('Unknown error: ${e.toString()}'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        });
      // } on FirebaseAuthException catch (e) {
      //
      //   // Wrong email
      //   setState(() {
      //     if (e.code == 'invalid-email') {
      //       emailError = 'Invalid email';
      //     } else if (e.code == 'invalid-credential') {
      //       passwordError = 'Incorrect password';
      //     } else {
      //       emailError = e.code;
      //
      //       showDialog(
      //         context: context,
      //         builder: (context) {
      //           return AlertDialog(
      //             title: const Text('Error'),
      //             content: Text('Unknown error: ${e.message}'),
      //             actions: [
      //               TextButton(
      //                 onPressed: () => Navigator.pop(context),
      //                 child: const Text('OK'),
      //               ),
      //             ],
      //           );
      //         },
      //       );
      //     }
      //   });
        // remove loading circle
        Navigator.pop(context);
        //
        // _formKey.currentState!.validate();
      }finally{
        // remove loading circle
        Navigator.pop(context);

        _formKey.currentState!.validate();
      }
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (emailError != null) {
      final error = emailError;
      emailError = null; // Clear error after showing it
      return error;
    }
    return null;
  }

  String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    // if (emailError != null) {
    //   final error = emailError;
    //   emailError = null; // Clear error after showing it
    //   return error;
    // }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (passwordError != null) {
      final error = passwordError;
      passwordError = null; // Clear error after showing it
      return error;
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm password';
    }
    if (confirmPasswordError != null) {
      final error = confirmPasswordError;
      confirmPasswordError = null; // Clear error after showing it
      return error;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");

    return Scaffold(
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // logo
                    Icon(
                      Icons.task_alt,
                      size: 100,
                      color: Theme.of(context).colorScheme.primary,
                    ),

                    Text(
                      "TaskUp",
                      style: textTheme.labelLarge!.copyWith(
                        fontSize: 30,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 50,
                    ),

                    // Login text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text(
                            "Create account",

                            //style: TextStyle(
                            style: textTheme.labelLarge!.copyWith(
                              fontSize: 24,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    // email text field
                    MyTextField(
                      controller: emailController,
                      labelText: 'Email',
                      obscureText: false,
                      validator: validateEmail,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // User name text field
                    MyTextField(
                      controller: userNameController,
                      labelText: 'Username',
                      obscureText: false,
                      validator: validateUserName,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // password text field
                    MyTextField(
                      controller: passwordController,
                      labelText: 'Password',
                      obscureText: true,
                      validator: validatePassword,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // confirm password text field
                    MyTextField(
                      controller: confirmPasswordController,
                      labelText: 'Confirm password',
                      obscureText: true,
                      validator: validateConfirmPassword,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints constraints) {
                        return SizedBox(
                          width: constraints.maxWidth,
                          child: Wrap(
                            //mainAxisAlignment: MainAxisAlignment.end,
                            alignment: WrapAlignment.end,
                            spacing: 25, // Horizontal space between children
                            children: [
                              // Create account Button
                              TextButton(
                                onPressed: widget.onTap,
                                child: const Text('Already have an account'),
                              ),

                              // const SizedBox(
                              //   width: 25,
                              // ),

                              // Login button
                              FloatingActionButton.extended(
                                onPressed: signUserUp,
                                label: const Text('Sign up'),
                                icon: const Icon(Icons.account_circle),
                              ),
                            ],
                          ),
                        );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}