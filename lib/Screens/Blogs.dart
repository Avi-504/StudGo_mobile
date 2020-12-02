import 'package:StudGo/Screens/add_blog.dart';
import 'package:StudGo/widgets/blogItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

final blogref = Firestore.instance.collection('blogs');

class Blogs extends StatefulWidget {
  @override
  _BlogsState createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  @override
  Widget build(BuildContext context) {
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
      body: StreamBuilder(
          stream: blogref.orderBy('createdAt', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return snapshot.data.documents.length == 0
                ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage('images/drawing.png'),
                            height: MediaQuery.of(context).size.height * 0.5,
                          ),
                          Text(
                            'No Blogs \n Looks like everyone is in JURRASIC era  \n  \n \n Add Your Blogs now',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.green[600],
                              fontSize: 24,
                              fontFamily: 'MavenPro',
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    reverse: false,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      String author =
                          (snapshot.data.documents[index]['author']);
                      String blogID =
                          (snapshot.data.documents[index]['blogID']);
                      String blogWriter =
                          (snapshot.data.documents[index]['blogWriter']);
                      String content =
                          (snapshot.data.documents[index]['content']);
                      Map likes = (snapshot.data.documents[index]['likes']);
                      String photo = (snapshot.data.documents[index]['photo']);
                      String tags = (snapshot.data.documents[index]['tags']);
                      String title = (snapshot.data.documents[index]['title']);
                      var timestamp =
                          (snapshot.data.documents[index]['createdAt']);
                      String timeAgo = timeago.format(timestamp.toDate());
                      return BlogItem(
                        author: author,
                        blogID: blogID,
                        blogWriter: blogWriter,
                        content: content,
                        likes: likes,
                        photo: photo,
                        tags: tags,
                        title: title,
                        timeAgo: timeAgo,
                      );
                    },
                  );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => AddBlog(), fullscreenDialog: false),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
