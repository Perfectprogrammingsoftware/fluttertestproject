
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;










class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
  
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Registrar'),
      ),
       body:  Column(
            children: [
                    TextField(
                      controller: _email,
                      enableSuggestions: true,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    
                    TextField(
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
              
                 TextButton(onPressed: () async {
                
                  final email = _email.text;
                  final password = _password.text;
                  // ignore: non_constant_identifier_names
                  final UserCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                     password: password
                     );
                    devtools.log(UserCredential.toString());
                 },
               child: const Text('Register'),
               ),
               TextButton(onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login/',
                   (route) => false
                   );
               },
               child: const Text('Already Registered? Login here!'),
               ),
               TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/email/', 
                    (route) => false
                    );
                }, 
                child: const Text('Not verified email? Verify here!'), 
                ),
            ],
          ),
    );
  }
}


