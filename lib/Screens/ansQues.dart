import 'package:StudGo/Screens/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

final answerref = Firestore.instance.collection('answers');

class AnsQNA extends StatefulWidget {
  final quesID;
  AnsQNA({
    this.quesID,
  });
  @override
  _AnsQNAState createState() => _AnsQNAState(
        quesID: this.quesID,
      );
}

class _AnsQNAState extends State<AnsQNA> {
  TextEditingController commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final quesID;
  var isValid = false;
  _AnsQNAState({
    this.quesID,
  });

  dynamic get givequesID {
    return quesID;
  }

  Widget buildAnswers() {
    return StreamBuilder(
      stream: answerref
          .document(quesID)
          .collection('answers')
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
            return Answers(
              timestamp: snapshot.data.documents[index]['timestamp'],
              quesID: quesID,
              author: snapshot.data.documents[index]['author'],
              answer: snapshot.data.documents[index]['answer'],
              answerID: snapshot.data.documents[index]['answerID'],
              photoUrl: snapshot.data.documents[index]['photoUrl'],
              upvotes: snapshot.data.documents[index]['upvotes'],
              downvotes: snapshot.data.documents[index]['downvotes'],
            );
          },
        );
      },
    );
  }

  void addAnswer() async {
    setState(() {
      isValid = _formKey.currentState.validate();
    });
    if (isValid) {
      FocusScope.of(context).unfocus();
      final doc = await answerref.document(quesID).collection('answers').add({
        'author': currentUser.displayName,
        'answer': commentController.text,
        'timestamp': DateTime.now(),
        'photoUrl': currentUser.photoUrl,
        'userEmail': currentUser.email,
        'answerID': '',
        'upvotes': {},
        'downvotes': {},
        'upvoteCounter': 0,
        'downvoteCounter': 0,
      });
      await answerref
          .document(quesID)
          .collection('answers')
          .document(doc.documentID)
          .updateData({
        'answerID': doc.documentID,
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
        title: Text('Answers'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: buildAnswers()),
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
                    labelText: 'Write an Answer...',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    suffixIcon: OutlineButton(
                      onPressed: addAnswer,
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

class Answers extends StatefulWidget {
  final author;
  final photoUrl;
  final answer;
  final timestamp;
  final answerID;
  final quesID;
  final upvotes;
  final downvotes;
  Answers({
    this.photoUrl,
    this.answer,
    this.timestamp,
    this.author,
    this.answerID,
    this.quesID,
    this.downvotes,
    this.upvotes,
  });

  @override
  _AnswersState createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  void delComm(
      {String title = 'Are you Sure?',
      String content = 'Do you want to delete this Answer?',
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
      await answerref
          .document(widget.quesID)
          .collection('answers')
          .document(widget.answerID)
          .delete();
    }
  }

  var upvoteCount;

  var downvoteCount;

  int getVote(votes) {
    if (votes == null) {
      return 0;
    }
    int count = 0;
    votes.values.forEach((value) {
      if (value) {
        count += 1;
      }
    });
    return count;
  }

  void handleUpvote() {
    var _isUpvoted = widget.upvotes[currentUser.email] == true;
    if (_isUpvoted) {
      setState(() {
        upvoteCount -= 1;
        widget.upvotes[currentUser.email] = false;
      });
      answerref
          .document(widget.quesID)
          .collection('answers')
          .document(widget.answerID)
          .updateData({
        'upvotes': widget.upvotes,
      });
    } else if (!_isUpvoted) {
      setState(() {
        upvoteCount += 1;
        widget.upvotes[currentUser.email] = true;
        widget.downvotes[currentUser.email] = false;
      });
      answerref
          .document(widget.quesID)
          .collection('answers')
          .document(widget.answerID)
          .updateData({
        'upvotes': widget.upvotes,
        'downvotes': widget.downvotes,
      });
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'UpVoted   ⬆️',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
    }
  }

  void handleDownvote() {
    var _isDownVoted = widget.downvotes[currentUser.email] == true;
    if (_isDownVoted) {
      setState(() {
        downvoteCount -= 1;
        widget.downvotes[currentUser.email] = false;
      });
      answerref
          .document(widget.quesID)
          .collection('answers')
          .document(widget.answerID)
          .updateData({
        'downvotes': widget.downvotes,
      });
    } else if (!_isDownVoted) {
      setState(() {
        downvoteCount += 1;
        widget.downvotes[currentUser.email] = true;
        widget.upvotes[currentUser.email] = false;
      });
      answerref
          .document(widget.quesID)
          .collection('answers')
          .document(widget.answerID)
          .updateData({
        'downvotes': widget.downvotes,
        'upvotes': widget.upvotes,
      });
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'DownVoted  ⬇️',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    upvoteCount = getVote(widget.upvotes);
    downvoteCount = getVote(widget.downvotes);
    return Column(
      children: [
        GestureDetector(
          onLongPress: () => delComm(
            displayName: widget.author,
            ctx: context,
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  widget.answer,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: CachedNetworkImageProvider(widget.photoUrl),
                ),
                trailing: Text(
                  timeago.format(
                    widget.timestamp.toDate(),
                  ),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  softWrap: true,
                ),
                subtitle: Text(
                  widget.author,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 20),
                      child: GestureDetector(
                          onTap: handleUpvote,
                          child: Icon(
                            Icons.arrow_upward,
                            size: 28,
                            color: Colors.green,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 20),
                      child: GestureDetector(
                          onTap: handleDownvote,
                          child: Icon(
                            Icons.arrow_downward,
                            size: 28,
                            color: Colors.red,
                          )),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        '$upvoteCount UpVotes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        '$downvoteCount DownVotes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
