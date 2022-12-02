import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'post.dart';

const apiUrl = "https://wovon.me/api";
const apiToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJjbGI2dnI3aHcwMDYwMHRwaTJ1YWQ4Mzd6IiwicGVybWlzc2lvbkxldmVsIjoiMiIsImlhdCI6MTY3MDAwODE4Nn0.py1UA6NX7dXMbishEdncc1YoWh9ITWjK1KzpyvRTsM0";
const maxPages = 100;

final pageCache = <int, List<Wovpost>>{};

Future<Response> _apiGet(String url) async {
  return await http.get(Uri.parse('$apiUrl$url'),
      headers: {"Authorization": "bearer $apiToken"});
}

Future<Response> _apiPost(String url) async {
  return await http.post(Uri.parse('$apiUrl$url'),
      headers: {"Authorization": "bearer $apiToken"});
}

Future<List<Wovpost>> getPostsPage(int page) async {
  if (pageCache.containsKey(page)) {
    return pageCache[page]!;
  }

  final response = await _apiGet("/get_all_wovposts?page=$page");

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

Future<bool> postWovreport(String reportType, int wovpostId) async {
  final response = await _apiPost(
      "/post_wovreport?wovpostId=$wovpostId&reportName=$reportType");

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

void clearCache() {
  pageCache.clear();
}
