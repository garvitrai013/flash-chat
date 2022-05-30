import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String? _email, _password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.blue),
                  onChanged: (value) {
                    _email = value;
                  },
                  decoration: kTextFieldInputDecoration.copyWith(
                      hintText: 'Enter your email')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  style: const TextStyle(color: Colors.blue),
                  onChanged: (value) {
                    _password = value;
                  },
                  decoration: kTextFieldInputDecoration.copyWith(
                      hintText: 'Enter your password')),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  text: 'Log In',
                  color: Colors.lightBlueAccent,
                  onPressed: () async {
                    try {
                      setState(() {
                        showSpinner = true;
                      });
                      final loggedInUser =
                          await _auth.signInWithEmailAndPassword(
                              email: _email!, password: _password!);
                      if (loggedInUser != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
