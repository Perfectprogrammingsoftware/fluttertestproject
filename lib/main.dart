




import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testproject/constants/routes.dart';
import 'package:flutter_testproject/firebase_options.dart';
import 'package:flutter_testproject/views/login_view.dart';
import 'package:flutter_testproject/views/notes_view.dart';
import 'package:flutter_testproject/views/register_view.dart';
import 'package:flutter_testproject/views/verify_email_view.dart';
import 'dart:developer' as devtools show log;




void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'fluttter demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
    loginRoute: (context) => const LoginView(), 
   registerRoute: (context) => const RegisterView(),
   verifyemail : (context) => const VerifyEmailView(),
   notesRoute :(context) => const NotesView(),
    },
  ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
            future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                 ),  
        builder: (context, snapshot){
          final user = FirebaseAuth.instance.currentUser;
          if(user!=null){
            if(user.emailVerified){
              devtools.log('Email verified');
            
            }else {
              return const LoginView();
            }
          }
          
         return const NotesView();
          
          }
           
            
    );
  }
}


