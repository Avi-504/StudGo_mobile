import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:skeleton_text/skeleton_text.dart';

class NewsItem extends StatefulWidget {
  final newsId;
  NewsItem(this.newsId);

  @override
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  var newsHeading;
  var newsUrl;
  var isLoading = true;

  @override
  void initState() {
    getNews();
    super.initState();
  }

  void getNews() async {
    final news = await http.get(
        'https://hacker-news.firebaseio.com/v0/item/${widget.newsId}.json?print=pretty');
    // print(news.body);
    final newsData = json.decode(news.body) as Map<String, dynamic>;
    newsHeading = newsData['title'];
    newsUrl = newsData['url'];
    setState(() {
      isLoading = false;
    });
  }

  void openBrowser() async {
    final url = newsUrl;
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Jus a moment Baking a Crisp News',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: Duration(
          seconds: 2,
        ),
      ),
    );
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: true,
        enableJavaScript: true,
        webOnlyWindowName: url,
        enableDomStorage: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            height: MediaQuery.of(context).size.height * 0.16,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.grey[800],
                ),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SkeletonAnimation(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SkeletonAnimation(
                              child: Container(
                                height: 15,
                                width: MediaQuery.of(context).size.width * 0.6,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey[400]),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SkeletonAnimation(
                                child: Container(
                                  width: 60,
                                  height: 13,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[400]),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.16,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage('images/degree-fabric-light.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: InkWell(
                onTap: openBrowser,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    newsHeading,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
