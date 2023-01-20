import 'package:flutter/material.dart';
import 'package:sutt_2_sth/main_screen.dart';
import 'package:sutt_2_sth/main.dart';


class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in with Google'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              child: const Text('Google Signin'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context){
                    return MainScreen();
                  },
                  ),
                );
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              child: const Text('Register with Phone No'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context){
                    return MainScreen();
                  },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}