import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'WebSocket Demo';
    return const MaterialApp(
      title: title,
      home: MyHomePage(
        title: title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title,}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  final _textcontroller = TextEditingController() ;
  final _chanel = WebSocketChannel.connect(Uri.parse('wss://echo.websocket.events'));
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(child: TextFormField(
              controller: _textcontroller,
              decoration: const InputDecoration(labelText: 'send a data'),
            )
            ),
            StreamBuilder(
                stream: _chanel.stream,
                builder: (context,snapshot){
                  return Text(snapshot.hasData ? '${snapshot.data}':'');
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendmessage,
        tooltip: 'send message',
        child: Icon(Icons.send_outlined),
      ),
    );
  }
  void _sendmessage(){
  if(_textcontroller.text.isNotEmpty){
    _chanel.sink.add(_textcontroller.text);
  }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _chanel.sink.close();
    _textcontroller.dispose();
  }
}