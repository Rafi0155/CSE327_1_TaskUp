import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/my_textfield.dart';
import '../components/util.dart';

import 'dart:developer';

import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // final GlobalKey<_MyTextFieldState> emailFieldKey = GlobalKey<_MyTextFieldState>();
  // final GlobalKey<_MyTextFieldState> passwordFieldKey = GlobalKey<_MyTextFieldState>();
  final _formKey = GlobalKey<FormState>();

  String? emailError;
  String? passwordError;

  // login method
  void login() async {
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

      // try login
      try {
        //await FirebaseAuth.instance.signInWithEmailAndPassword(
        await AuthService.instance.signInWithEmailAndPassword(
          emailController.text,
          passwordController.text,
        );
        // remove loading circle
         //Navigator.pop(context);
      } on Exception catch (e) {
        setState(() {
          if (e.toString().contains('invalid-email')) {
            emailError = 'Invalid email';
          } else if (e.toString().contains('invalid-credential')) {
            passwordError = 'Incorrect password';
          } else {
            emailError = e.toString();

            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: Text(e.toString()),
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
        //_formKey.currentState!.validate();
        Navigator.pop(context);
        // on FirebaseAuthException catch (e) {
      //
      //   // Wrong email
      //   setState(() {
      //     //if (e.code == 'auth/user-not-found' || e.code == 'auth/invalid-email') {
      //     if (e.code == 'invalid-email') {
      //       //emailController.clear();
      //       emailError = 'Invalid email';
      //
      //       log('Invalid email');
      //       log('Invalid email error message: ${e.message}');
      //       log('Invalid email error code: ${e.code}');
      //       log('Invalid email error: $e');
      //     //} else if (e.code == 'auth/invalid-password') {
      //     } else if (e.code == 'invalid-credential') {
      //       //passwordController.clear();
      //       passwordError = 'Incorrect password';
      //
      //       log('Incorrect password');
      //       log('Incorrect password error message: ${e.message}');
      //       log('Incorrect password error code: ${e.code}');
      //       log('Incorrect password error : $e');
      //     } else {
      //       //emailController.clear();
      //       //passwordController.clear();
      //
      //       emailError = 'Unknown error: ${e.message}';
      //
      //       log('Unknown error message: ${e.message}');
      //       log('Unknown error code: ${e.code}');
      //       log('Unknown error: $e');
      //
      //       showDialog(
      //             context: context,
      //             builder: (context) {
      //               return AlertDialog(
      //                 title: const Text('Error'),
      //                 content: Text('Unknown error: ${e.message}'),
      //                 actions: [
      //                   TextButton(
      //                     onPressed: () => Navigator.pop(context),
      //                     child: const Text('OK'),
      //                   ),
      //                 ],
      //               );
      //             },
      //           );
      //     }
      //     //setState(() {
      //
      //     });
      //
      //   // remove loading circle
      //   // Navigator.pop(context);
      //   //
      //   // _formKey.currentState!.validate();
      //
      //
      //   // if (e.code == 'invalid-credentials') {
      //   //   emailController.clear();
      //   //   // show error to user
      //   //   //wrongEmailMessage();
      //   //   _showErrorDialog('Incorrect Email');
      //   //   //emailFieldKey.currentState?.showHelperText('Incorrect email');
      //   // }
      //   // // Wrong password
      //   // else if (e.code == 'wrong-password') {
      //   //   passwordController.clear();
      //   //   // show error to user
      //   //   //wrongPasswordMessage();
      //   //   _showErrorDialog('Incorrect Password');
      //   //   //passwordFieldKey.currentState?.showHelperText('Incorrect password');
      //   // } else {
      //   //   // Catch any other unexpected exceptions
      //   //   //passwordFieldKey.currentState?.hideHelperText();
      //   //   _showErrorDialog(e.message ?? 'An unknown error occurred.');
      //   // }
      }finally{
        // remove loading circle
        _formKey.currentState!.validate();
        Navigator.pop(context);
      }
      // catch (e) {
      //   Navigator.pop(context);
      //   // Catch any other unexpected exceptions
      //   //_showErrorDialog(e.toString());
      //   setState(() {
      //     emailError = 'Unknown error: $e';
      //     log('Unknown error: $e');
      //   });
      // }
    }
  }

  // void _showErrorDialog(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Error'),
  //         content: Text(message),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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

  // //wrong email message popup
  // void wrongEmailMessage(){
  //   showDialog(context: context, builder: (context){
  //     return const AlertDialog(
  //       title: Text('Incorrect Email'),
  //     );
  //   },);
  // }
  //
  // //wrong password message popup
  // void wrongPasswordMessage(){
  //   showDialog(context: context, builder: (context){
  //     return const AlertDialog(
  //       title: Text('Incorrect Password'),
  //     );
  //   },);
  // }

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
                /*
                const SizedBox(
                  height: 50,
                ),
                */
                // logo
                Icon(
                  Icons.task_alt,
                  size: 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
                //const Spacer(),

                /*
                Text(
                  "TaskUp",
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              */

                Text(
                  "TaskUp",
                  style: textTheme.labelLarge!.copyWith(
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                /*
                Image.asset(
                    'lib/images/logo.png',
                  height: 100,
                ),
                */
                const SizedBox(
                  height: 50,
                ),

                // Login text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Text(
                        "Login",

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
                  //key: emailFieldKey,
                  controller: emailController,
                  labelText: 'Email',
                  obscureText: false,
                  validator: validateEmail,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter your email';
                  //   }
                  //   // Add more email validation logic if needed
                  //   return null;
                  // },
                ),

                const SizedBox(
                  height: 10,
                ),

                // password text field
                MyTextField(
                  //key: passwordFieldKey,
                  controller: passwordController,
                  labelText: 'Password',
                  obscureText: true,
                  validator: validatePassword,
                ),

                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Create account Button
                      TextButton(
                        onPressed: widget.onTap,
                        child: const Text('Create account'),
                      ),

                      const SizedBox(
                        width: 25,
                      ),

                      // Login button
                      FloatingActionButton.extended(
                        onPressed: login,
                        label: const Text('Login'),
                        icon: const Icon(Icons.login),
                      ),
                    ],
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