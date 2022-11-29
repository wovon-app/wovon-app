import 'package:http/http.dart' as http;
import 'dart:convert';
import 'post.dart';

const apiUrl = "http://wovon.westus3.cloudapp.azure.com";

Future<List<Wovpost>> getAllPosts() async {
  final response = await http.get(Uri.parse('$apiUrl/get_all_wovposts?page=1'));

  if (response.statusCode == 200) {
    final List<dynamic> posts = jsonDecode(response.body)['content'];
    return posts.map((post) => Wovpost.fromJson(post)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}
