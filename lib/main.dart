




import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testproject/firebase_options.dart';
import 'package:flutter_testproject/views/login_view.dart';
import 'package:flutter_testproject/views/register_view.dart';
import 'package:flutter_testproject/views/verify_email_view.dart';





void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'fluttter demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
    '/login/' : (context) => const LoginView(), 
   '/register/' : (context) => const RegisterView(),
   '/email/' : (context) => const VerifyEmailView(),
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
              print('Email verified');
            
            }else {
              return const LoginView();
            }
          }
          
         return const NotesView();
          
          }
           
            
    );
  }
}

enum MenuAction{logout}
class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value)  {
               
                case MenuAction.logout:
                 final shouldLogout = await showLogOutDialog(context);
                 await FirebaseAuth.instance.signOut();
                 if(shouldLogout) {
                   
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login/', 
                      (route) => false);
                    
                   
          
                 }
                 break;
              }
              
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: MenuAction.logout,
                  child: Text("Log Out"),
                )
              ];
            },
          ),   
  ],
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context){
  return showDialog<bool>(
     context: context,
     builder:  (context){
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to Log out'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            }, 
          child: const Text('Cancel')
          ),
          TextButton( 
            onPressed: () {
               Navigator.of(context).pop(true);
            }, 
            child: const Text('Log out'),
            ),
        ],
      );
     },
  ).then((value) => value ?? false);
}