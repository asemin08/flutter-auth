import 'package:flutter_auth/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/form_input_component.dart';
import 'package:flutter_auth/components/form_valid_component.dart';
import 'package:flutter_auth/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
        title: const Text(
          "S'enregistrer",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringColor("69E663"),
                hexStringColor("9EFC60"),
                hexStringColor("5CF2AB")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                FormInputComponent("Pseudo", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                FormInputComponent("Email", Icons.email, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                FormInputComponent("Mot de passe", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                FormValidComponent(context, "S'enregistrer", () 
                {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _emailTextController.text, 
                    password: _passwordTextController.text,
                  ).then((value) {
                    print("Le compte à été créer ! ");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen()
                      ),
                    );
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  }
                  );
                }
                )
              ],
            ),
          ))),
    );
  }
}