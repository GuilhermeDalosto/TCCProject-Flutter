import 'package:flutter/material.dart';
import 'ButtonCustomComponent.dart';
import 'AuthUtils.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key, this.title, this.onSignIn}) : super(key: key);  

  final String title;
  final AuthProtocol auth = new Auth();
  final VoidCallback onSignIn;

  @override
  _LoginViewState createState() => new _LoginViewState();
}

enum FormType { login, register }

class _LoginViewState extends State<LoginView> {
  static final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;
  String _authHint = '';

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        String userId = _formType == FormType.login
            ? await widget.auth.signIn(_email, _password)
            : await widget.auth.createUser(_email, _password);
        setState(() {
          _authHint = 'Logado como\n\nUser id: $userId';
        });
        print("Login feito com sucesso");
        // widget.onSignIn();
      } catch (e) {
        setState(() {
          _authHint = 'Erro de Login\n\n${e.toString()}';
        });
        print(e);
      }
    } else {
      setState(() {
        _authHint = '';
      });
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
      _authHint = '';
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
      _authHint = '';
    });
  }

  List<Widget> usernameAndPassword() {
    return [
      padded(
          child: new TextFormField(
        key: new Key('email'),
        decoration: new InputDecoration(labelText: 'Email'),
        autocorrect: false,
        validator: (val) => val.isEmpty ? 'Email não pode estar vazio' : null,
        onSaved: (val) => _email = val,
      )),
      padded(
          child: new TextFormField(
        key: new Key('password'),
        decoration: new InputDecoration(labelText: 'Senha'),
        obscureText: true,
        autocorrect: false,
        validator: (val) => val.isEmpty ? 'Senha não pode estar vazia' : null,
        onSaved: (val) => _password = val,
      )),
    ];
  }

  List<Widget> submitWidgets() {
    switch (_formType) {
      case FormType.login:
        return [          
          new SizedBox(height: 20),
          new ButtonCustomComponent(                          
              key: new Key('login'),
              text: 'Login',              
              height: 44.0,              
              onPressed: validateAndSubmit),              
          new FlatButton(
              key: new Key('need-account'),
              child: new Text("Precisa de uma conta? Registrar"),
              onPressed: moveToRegister),
        ];
      case FormType.register:
        return [          
          new TextFormField(
            key: new Key('password'),
            decoration: new InputDecoration(labelText: 'Confirmação de senha'),
            obscureText: true,
            autocorrect: false,
            validator: (val) =>
                val.isEmpty ? 'Confirmação de senha não pode estar vazia' : null,
            onSaved: (val) => _password = val,            
          ),
          new SizedBox(height: 30),
          new ButtonCustomComponent(
              key: new Key('register'),
              text: 'Criar uma conta',
              height: 44.0,
              onPressed: validateAndSubmit),
          new FlatButton(
              key: new Key('need-login'),
              child: new Text("Ja tem uma conta? Logue-se"),
              onPressed: moveToLogin),
        ];
    }
    return null;
  }

  Widget hintText() {
    return new Container(
        //height: 80.0,
        padding: const EdgeInsets.all(32.0),
        child: new Text(_authHint,
                key: new Key('hint'),
                style: new TextStyle(fontSize: 18.0, color: Colors.grey),
                textAlign: TextAlign.center) ??
            "");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title ?? "APS Project"),
        ),
        backgroundColor: Colors.grey[300],
        body: new SingleChildScrollView(
            child: new Container(
                padding: const EdgeInsets.all(30.0),
                child: new Column(children: [
                  new Card(
                      child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                        new Container(
                            padding: const EdgeInsets.all(16.0),
                            child: new Form(
                                key: formKey,
                                child: new Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children:
                                      usernameAndPassword() + submitWidgets(),
                                ))),
                      ])),
                  hintText()
                ]))));
  }

  Widget padded({Widget child}) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }
}
