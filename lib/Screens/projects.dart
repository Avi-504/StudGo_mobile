import 'package:StudGo/Screens/add_project.dart';
import 'package:StudGo/widgets/projectIem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

final projectref = Firestore.instance.collection('projects');

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
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
              fontSize: 31,
              fontFamily: 'MavenPro',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: projectref.orderBy('timestamp', descending: true).snapshots(),
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
                          'No Projects \n Looks like everyone is in JURRASIC era  \n  \n \n Add Your Projects now',
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
                    String author = (snapshot.data.documents[index]['author']);
                    String projectID =
                        (snapshot.data.documents[index]['projectID']);
                    String userEmail =
                        (snapshot.data.documents[index]['userEmail']);
                    String content =
                        (snapshot.data.documents[index]['content']);
                    Map upvotes = (snapshot.data.documents[index]['upvotes']);
                    Map downvotes =
                        (snapshot.data.documents[index]['downvotes']);
                    int upvoteCounter =
                        (snapshot.data.documents[index]['upvoteCounter']);
                    int downvoteCounter =
                        (snapshot.data.documents[index]['downvoteCounter']);
                    String photoUrl =
                        (snapshot.data.documents[index]['photoUrl']);
                    String tags = (snapshot.data.documents[index]['tags']);
                    String title = (snapshot.data.documents[index]['title']);
                    String link = (snapshot.data.documents[index]['link']);
                    var timestamp =
                        (snapshot.data.documents[index]['timestamp']);
                    String timeAgo = timeago.format(timestamp.toDate());
                    return ProjectItem(
                      photoUrl: photoUrl,
                      downvoteCounter: downvoteCounter,
                      downvotes: downvotes,
                      upvoteCounter: upvoteCounter,
                      upvotes: upvotes,
                      userEmail: userEmail,
                      tags: tags,
                      timeAgo: timeAgo,
                      title: title,
                      author: author,
                      content: content,
                      link: link,
                      projectID: projectID,
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => AddProject(), fullscreenDialog: false),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
