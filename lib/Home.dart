import 'dart:convert';
import 'dart:async';
import 'models/Poster.dart';
import 'Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  late Future<List<Poster>> _futurePoster;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _futurePoster = fetchPosters(http.Client());
  }
  @override
  void initState() {
    super.initState();
    _futurePoster = fetchPosters(http.Client());
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder<List<Poster>>(
        future: _futurePoster,
        builder: (context,abc){
          if(abc.hasData){
            return Center(
                child: Padding(
                  padding: EdgeInsets.all(20) ,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('userIds')),
                      DataColumn(label: Text('ids')),
                      DataColumn(label: Text('titles')),
                      DataColumn(label: Text('contents')),
                    ],
                    rows: List<DataRow>.generate(
                      abc.data!.length,
                          (index) => DataRow(
                          cells: <DataCell>[
                            DataCell(Text(abc.data![index].userId.toString())),
                            DataCell(Text(abc.data![index].id.toString())),
                            DataCell(Text(abc.data![index].title)),
                            DataCell(Text(abc.data![index].body)),
                          ]
                      ),
                    )  ,
                  ),
                )
            ) ;
          }else if(abc.hasError){
            return Text('${abc.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

