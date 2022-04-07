import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostInternet extends StatefulWidget {
  const PostInternet({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PostInternet();
  }
}

class _PostInternet extends State<PostInternet> {
  final TextEditingController _controller = TextEditingController();
  Future<Poster>? _futurePoster;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data '),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futurePoster == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Title'),
          maxLength: 20,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futurePoster = createPoster(_controller.text);
            });
          },
          child: const Text('tạo data'),
        ),
      ],
    );
  }

  FutureBuilder<Poster> buildFutureBuilder() {
    return FutureBuilder<Poster>(
      future: _futurePoster,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Text(snapshot.data!.id.toString()),
              Text(snapshot.data!.title),

            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
Future<Poster> createPoster(String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8  ',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    return Poster.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create Poster.');
  }
}

class Poster {
  final int id;
  final String title;

  const Poster({required this.id, required this.title});

  factory Poster.fromJson(Map<String, dynamic> json) {
    return Poster(
      id: json['id'],
      title: json['title'],
    );
  }
}