import 'package:flutter/material.dart';
import 'package:flutter_auth/utils/color_utils.dart';
import 'package:flutter_auth/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/services/auth_google_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
        title: const Text(
          "Mes comptes",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await FirebaseServices().googleSignOut();
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen())
                );
            },
            icon: const Icon(
              Icons.logout
            ),
          )
        ],
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
                Text("Vous êtes connecté : ${FirebaseAuth.instance.currentUser!.email}"),
              ],
            ),
          ))),
    );
  }
}