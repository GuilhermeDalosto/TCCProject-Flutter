import 'package:flutter/material.dart';


class ButtonCustomComponent extends StatefulWidget {
  ButtonCustomComponent({this.key, this.text, this.height, this.onPressed}) : super(key: key);
  Key key;
  String text;
  double height;
  VoidCallback onPressed;

  @override
  _ButtonCustomComponentState createState() => _ButtonCustomComponentState();
}

class _ButtonCustomComponentState extends State<ButtonCustomComponent> {
  @override
  Widget build(BuildContext context) {
    return new ConstrainedBox(            
      constraints: BoxConstraints.expand(height: widget.height),      
      child: new RaisedButton(                  
          child: new Text(widget.text ?? "", style: new TextStyle(color: Colors.white, fontSize: 20.0)),
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.height / 2))),
          color: Colors.orange,
          textColor: Colors.white,
          onPressed: widget.onPressed),
    );
  }
}