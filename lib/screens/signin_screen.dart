import 'package:flutter_auth/screens/home_screen.dart';
import 'package:flutter_auth/screens/signup_screen.dart';
import 'package:flutter_auth/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/form_input_component.dart';
import 'package:flutter_auth/components/form_valid_component.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: [
                Image.asset('assets/images/user.png',    
                  fit: BoxFit.fitWidth,
                  width: 240,
                  height: 200,
                  color: Colors.white,
                ),
                const Text("Authentification Flutter APP",
                  style: TextStyle(color: Colors.black54, fontSize: 22, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)
                ),
                const SizedBox(
                  height: 40,
                ),
                FormInputComponent("Mail", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                FormInputComponent("Mots de passe", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 5,
                ),
                FormValidComponent(context, "Se connecter", () {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailTextController.text, 
                    password: _passwordTextController.text,
                  ).then((value) {
                    print("Connexion réussi ! ");
                    _emailTextController.text = "";
                    _passwordTextController.text = "";

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
              
               }),
                signUpValidation()
              ],
            ),
          ),
        ),
      ),
    );
  }


  Row signUpValidation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Avez-vous un compte ?",
            style: TextStyle(color: Colors.orange)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            "S'enregistrer ",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

}