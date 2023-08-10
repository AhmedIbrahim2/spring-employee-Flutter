import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'newdetailescreen.dart';

final apiKey =
    '9816b97109b0493fbcc9618d4e902bcc'; // Replace with your NewsAPI API key
final endpointUrl =
    'https://newsapi.org/v2/top-headlines?category=health&language=en&apiKey=$apiKey';

class NewsArticle {
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String content;
  final DateTime publishedAt;

  NewsArticle({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
    required this.content,
    required this.publishedAt,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      url: json['url'] ?? '',
      content: json['content'] ?? '',
      publishedAt:
          DateTime.tryParse(json['publishedAt'] ?? '') ?? DateTime.now(),
    );
  }

  static List<NewsArticle> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => NewsArticle.fromJson(json))
        .where((article) =>
            article.title.isNotEmpty && article.description.isNotEmpty)
        .toList();
  }
}

Future<List<NewsArticle>> fetchMedicalNews() async {
  final response = await http.get(Uri.parse(endpointUrl));
  if (response.statusCode == 200) {
    final jsonBody = json.decode(response.body);
    final jsonArticles = jsonBody['articles'];
    final articles = NewsArticle.fromJsonList(jsonArticles);
    return articles;
  } else {
    throw Exception('Failed to load articles');
  }
}

class MedicalNewsScreen extends StatefulWidget {
  @override
  _MedicalNewsScreenState createState() => _MedicalNewsScreenState();
}

class _MedicalNewsScreenState extends State<MedicalNewsScreen> {
  late Future<List<NewsArticle>> _articlesFuture;

  @override
  void initState() {
    super.initState();
    _articlesFuture = fetchMedicalNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical News'),
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: _articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (BuildContext context, int index) {
                final article = articles[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NewsDetailScreen(article: article),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: article.urlToImage,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            article.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            article.description,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Published: ${article.publishedAt}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load articles'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class ArticleDetailScreen extends StatelessWidget {
  final NewsArticle article;

  ArticleDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(article.title),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          if (article.urlToImage != null)
            Image.network(
              article.urlToImage,
              fit: BoxFit.fitWidth,
              height: 200,
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              article.title,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              article.description,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(onPressed: () {
                launch(article.url);
              }))
        ])));
  }
}
