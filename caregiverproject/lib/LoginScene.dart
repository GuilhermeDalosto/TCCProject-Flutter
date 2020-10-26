import 'package:flutter/material.dart';

class LoginScene extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new _LoginSceneState();
}

class _LoginSceneState extends State<LoginScene>{


  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  void validateAndSave(){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();
      print("Campos válidos");
    } else{
      print("Campos inválidos");
    }

  }

  @override 
    Widget build(BuildContext context){
      return new Scaffold(
        appBar: new AppBar(title: new Text('Autenticação de usuário'),
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Email'), 
                validator: (value) => value.isEmpty ? "Email não pode estar vazio" : null,
                onSaved: (value) => _email = value
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) => value.isEmpty ? "Email não pode estar vazia" : null,
                onSaved: (value) => _password = value
              ),
            new RaisedButton(
              child: new Text('Login',style: new TextStyle(fontSize: 20.0)),
              onPressed: validateAndSave,
            )
            ],
          )
        )
      )
      );
    }
}