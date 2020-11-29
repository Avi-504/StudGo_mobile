import 'package:StudGo/providers/news.dart';
import 'package:StudGo/widgets/news_Item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  var isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<News>(context, listen: false).getNewsId();
    }
    isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final newsData = Provider.of<News>(context);
    final list = newsData.news;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'StudGO',
          style: TextStyle(
              color: Colors.green[600],
              fontSize: 30,
              fontFamily: 'MavenPro',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: list.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: 30,
              cacheExtent: 1000000000,
              itemBuilder: (context, index) => NewsItem(list[index]),
            ),
    );
  }
}
