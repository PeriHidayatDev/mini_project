import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rempah_apps/api/detail_news_api.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List _posts = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _posts.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                color: const Color.fromARGB(255, 158, 154, 154),
                height: 200,
                width: 120,
                child: _posts[index]['urlToImage'] != null
                    ? Image.network(
                        _posts[index]['urlToImage'],
                        width: 200,
                        fit: BoxFit.cover,
                      )
                    : const Center(),
              ),
              title: Text(
                '${_posts[index]['title']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                '${_posts[index]['description']}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreenNews(
                      url: _posts[index]['url'],
                      title: _posts[index]['title'],
                      content: _posts[index]['content'],
                      publishedAt: _posts[index]['publishedAt'],
                      author: _posts[index]['author'],
                      urlToImage: _posts[index]['urlToImage'],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }

  Future _getData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=920a73013f7042b4a01e64182c3000ef'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _posts = data['articles'];
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
