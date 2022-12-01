import 'package:http/http.dart' as http;
import 'dart:convert';
import 'post.dart';

const apiUrl = "http://wovon.westus3.cloudapp.azure.com";
const maxPages = 100;

final pageCache = <int, List<Wovpost>>{};

Future<List<Wovpost>> getPostsPage(int page) async {
  if (pageCache.containsKey(page)) {
    return pageCache[page]!;
  }

  final response =
      await http.get(Uri.parse('$apiUrl/get_all_wovposts?page=$page'));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final List<dynamic> postsJson = json['content'];
    final postsPage = postsJson.map((p) => Wovpost.fromJson(p)).toList();

    pageCache[page] = postsPage;
    if (json["isLast"] == true) pageCache[page + 1] = List.empty();

    return postsPage;
  }

  throw Exception("Failed to load posts");
}

/// Returns all posts, calling the API 5 requests at a time (or getting them from cache)
Future<List<Wovpost>> getAllPosts() async {
  const parallelRequests = 5;
  for (var i = 0; i < maxPages; i += parallelRequests) {
    var responses = await Future.wait(
        List.generate(parallelRequests, (index) => getPostsPage(i + index)));

    for (var j = 0; j < parallelRequests; j++) {
      if (responses[j].isEmpty) {
        return pageCache.values.expand((e) => e).toList();
      }

      pageCache[i + j] = responses[j];
    }
  }

  return pageCache.values.expand((e) => e).toList();
}
