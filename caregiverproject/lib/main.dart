import 'package:caregiverproject/LoginView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{
  @override 
    Widget build(BuildContext context){
      return new MaterialApp(
        title: 'Cuidadores',
        theme: new ThemeData(
          primarySwatch: Colors.green,          
        ),
        home: new LoginView()        
      );
      
    }
}