import 'package:StudGo/Screens/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

final commentRef = Firestore.instance.collection('comments');

class Comments extends StatefulWidget {
  final blogID;
  Comments({
    this.blogID,
  });
  @override
  CommentsState createState() => CommentsState(
        blogID: this.blogID,
      );
}

class CommentsState extends State<Comments> {
  TextEditingController commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final blogID;
  var isValid = false;
  CommentsState({
    this.blogID,
  });

  dynamic get giveBlogid {
    return blogID;
  }

  Widget buildComments() {
    return StreamBuilder(
      stream: commentRef
          .document(blogID)
          .collection('comments')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            return Comment(
              timestamp: snapshot.data.documents[index]['timestamp'],
              blogId: blogID,
              displayName: snapshot.data.documents[index]['displayName'],
              comment: snapshot.data.documents[index]['comment'],
              commentID: snapshot.data.documents[index]['commentID'],
              photoUrl: snapshot.data.documents[index]['photoUrl'],
            );
          },
        );
      },
    );
  }

  void addComment() async {
    setState(() {
      isValid = _formKey.currentState.validate();
    });
    if (isValid) {
      FocusScope.of(context).unfocus();
      final doc = await commentRef.document(blogID).collection('comments').add({
        'displayName': currentUser.displayName,
        'comment': commentController.text,
        'timestamp': DateTime.now(),
        'photoUrl': currentUser.photoUrl,
        'userEmail': currentUser.email,
        'commentID': ''
      });
      await commentRef
          .document(blogID)
          .collection('comments')
          .document(doc.documentID)
          .updateData({
        'commentID': doc.documentID,
      });
      commentController.clear();
    }
    commentController.clear();
    FocusScope.of(context).unfocus();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Comments'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: buildComments()),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            child: Form(
              key: _formKey,
              child: ListTile(
                title: TextFormField(
                  validator: (value) {
                    if (value.trim().length == 0 || value.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  controller: commentController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    labelText: 'Write a Comment...',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    suffixIcon: OutlineButton(
                      onPressed: addComment,
                      borderSide: BorderSide.none,
                      child: Text(
                        'Post',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final displayName;
  final photoUrl;
  final comment;
  final timestamp;
  final commentID;
  final blogId;
  Comment({
    this.photoUrl,
    this.comment,
    this.timestamp,
    this.displayName,
    this.commentID,
    this.blogId,
  });
  void delComm(
      {String title = 'Are you Sure?',
      String content = 'Do you want to delete this comment?',
      dynamic displayName,
      BuildContext ctx}) async {
    var commentOwner = displayName == currentUser.displayName;
    if (!commentOwner) {
      return;
    }
    var delete = await showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text('Yes'),
          ),
          FlatButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('No'),
          ),
        ],
      ),
    );
    if (delete == (null)) {
      return;
    } else if (delete == false) {
      return;
    } else {
      print(blogId);
      print(commentID);
      await commentRef
          .document(blogId)
          .collection('comments')
          .document(commentID)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onLongPress: () => delComm(
            displayName: displayName,
            ctx: context,
          ),
          child: ListTile(
            title: Text(
              comment,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: CachedNetworkImageProvider(photoUrl),
            ),
            trailing: Text(
              timeago.format(
                timestamp.toDate(),
              ),
              style: TextStyle(
                color: Colors.grey,
              ),
              softWrap: true,
            ),
            subtitle: Text(
              displayName,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
