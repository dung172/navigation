import 'package:flutter/material.dart';

void main(){
  runApp(Layout());
}
class Layout extends StatelessWidget{
  const Layout({Key?key}) : super (key:key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layout',
      home: Scaffold(
        appBar: AppBar(title: Text('layout')),
        body: Container(

          transform: Matrix4.rotationZ(0.1),
          color: Colors.yellow,
          width: 1000,
          height: 200,
          margin: EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: 1/2,
            child: Container(
              width: 1000,
              height: 200,
              child: Stack(
                alignment: const Alignment(0.6, 0.6),
                children: [
                  Container(color: Colors.blue,width: 500, height: 100,),
                  Container(color: Colors.red,width: 300, height: 50,),
                  Container(color: Colors.purple,width: 100, height: 10,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}