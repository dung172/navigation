import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class Poster{
  final int userId;
  final int id;
  final String title;
  final String body;

  const Poster({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });
  factory Poster.fromJson(Map<String, dynamic> json){
    return  Poster(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body']as String,
    );
  }
}
// Future<Poster> fetchPoster() async{
//   final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/2'));
//   if(response.statusCode == 200){
//     return Poster.fromJson(jsonDecode(response.body));
//   }else{
//     throw Exception('failed to load Poster');
//   }
// }

List<Poster> parsePoster(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Poster>((json) => Poster.fromJson(json)).toList();
}

Future<List<Poster>> fetchPosters(http.Client client) async{
  final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  if(response.statusCode == 200){
    return compute(parsePoster, response.body);
  }
  else{
    throw Exception('failed to connect');
  }
}

// //delete
// Future<Poster> deletePoster(String id) async{
//   final http.Response response = await http.delete(
//     Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
//   );
//   if(response.statusCode == 200){
//     print('đã xóa $id');
//     return Poster.fromJson(jsonDecode(response.body));
//   }else{
//     throw Exception('Failed to delete poster');
//   }
// }
Future deletePoster(String id) async{
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
  );
  if(response.statusCode == 200){
    print('đã xóa $id');
    return Poster.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to delete poster');
  }
}