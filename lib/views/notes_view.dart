




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testproject/constants/routes.dart';


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
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute, 
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