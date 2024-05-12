// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:news_app/news_card.dart';
import 'package:news_app/news_model.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(useMaterial3: true),
        home: const DefaultTabController(length: 7, child: NewsScreen()));
  }
}

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("FlutterFeed"),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(child: Text("Business")),
              Tab(child: Text("Entertainment")),
              Tab(child: Text("Sports")),
              Tab(child: Text("General")),
              Tab(child: Text("Health")),
              Tab(child: Text("Science")),
              Tab(child: Text("Technology")),
            ],
          ),
        ),
        body: TabBarView(children: [
          NewsList(category: "business"),
          NewsList(category: "entertainment"),
          NewsList(category: "sports"),
          NewsList(category: "general"),
          NewsList(category: "health"),
          NewsList(category: "science"),
          NewsList(category: "technology"),
        ]));
  }
}

class NewsList extends StatefulWidget {
  final String category;
  final String? apiKey = dotenv.env['NEWS_API_KEY'];
  NewsList({super.key, required this.category});

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final List<NewsModel> _data = [];
  bool _isLoading = false;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    if (widget.apiKey != null) {
      _getData();
    }
  }

  Future<void> _getData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?category=${widget.category}&apiKey=${widget.apiKey}&page=$_page&pageSize=10&country=in'));
      final responseArticles = jsonDecode(response.body)['articles'] as List;

      if (response.statusCode == 200) {
        setState(() {
          _data.addAll(responseArticles
              .map<NewsModel>((item) => NewsModel(
                  title: item['title'] as String,
                  imageUrl: item['urlToImage'] == null
                      ? null
                      : item['urlToImage'] as String,
                  articleUrl: item['url']))
              .toList());
          _isLoading = false;
          _page++;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }

  void _loadMoreData() {
    if (widget.apiKey != null) {
      _getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: widget.apiKey == null
              ? _errorDialog()
              : ListView.builder(
                  itemCount: _data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _data.length) {
                      return _buildLoadMoreButton();
                    } else {
                      return ListTile(
                          title: NewsCard(
                        title: _data[index].title,
                        imageUrl: _data[index].imageUrl,
                        articleUrl: _data[index].articleUrl,
                      ));
                    }
                  },
                ),
        ),
        if (_isLoading) const CircularProgressIndicator(),
      ],
    );
  }

  Widget _errorDialog() {
    return AlertDialog(
      title: const Text('Error'),
      content: const Text('Failed to load data'),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
            SystemNavigator.pop();
          },
        ),
      ],
    );
  }

  Widget _buildLoadMoreButton() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: _isLoading
            ? null
            : ElevatedButton(
                onPressed: _loadMoreData, child: const Text('Load More')));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
