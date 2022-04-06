import 'dart:convert';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
class Home extends StatelessWidget{
  const Home({Key?key}): super(key:key);
  static final nameRoute = '/Home';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as LoginData;
    return Scaffold(
      appBar: AppBar( title: Text('Hello '+args.user),),
      body: MyHome(),
    );
  }
}
class MyHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyHome();
  }
}
class _MyHome extends State<MyHome>{
  late Future<Album> album;
  @override
  void initState() {
    super.initState();
    album = fetchAlbum();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder<Album>(
        future: album,
        builder: (context,abc){
          if(abc.hasData){
            return Center(
                child: Padding(
                    padding: EdgeInsets.all(20) ,
                    child: DataTable(
                      columns: [

                        DataColumn(label: Text('userId')),
                        DataColumn(label: Text('id')),
                        DataColumn(label: Text('title')),
                        DataColumn(label: Text('content')),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text(abc.data!.id.toString())),
                          DataCell(Text(abc.data!.userId.toString())),
                          DataCell(Text(abc.data!.title)),
                          DataCell(Text(abc.data!.body)),
                        ])
                      ],
                    ),
                )
            );
          }else if(abc.hasError){
            return Text('${abc.hasError}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

class Album{
  final int userId;
  final int id;
  final String title;
  final String body;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
});
  factory Album.fromJson(Map<String, dynamic> json){
    return  Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
Future<Album> fetchAlbum() async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/2'));
      if(response.statusCode == 200){
        return Album.fromJson(jsonDecode(response.body));
      }else{
        throw Exception('failed to load album');
      }
}