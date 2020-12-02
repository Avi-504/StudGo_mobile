import 'package:StudGo/Screens/QNA.dart';
import 'package:StudGo/Screens/ansQues.dart';
import 'package:StudGo/Screens/home.dart';
import 'package:StudGo/Screens/up_downvote.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class QuesQNA extends StatefulWidget {
  final String author;
  final String quesID;
  final String userEmail;
  final Map upvotes;
  final Map downvotes;
  final String photoUrl;
  final String tags;
  final String timeAgo;
  final String question;
  final int upvoteCounter;
  final int downvoteCounter;

  QuesQNA({
    this.author,
    this.downvoteCounter,
    this.downvotes,
    this.photoUrl,
    this.quesID,
    this.question,
    this.tags,
    this.timeAgo,
    this.upvoteCounter,
    this.upvotes,
    this.userEmail,
  });
  @override
  _QuesQNAState createState() => _QuesQNAState();
}

class _QuesQNAState extends State<QuesQNA> {
  var delete = false;
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
      quesref.document(widget.quesID).updateData({
        'upvotes': widget.upvotes,
      });
    } else if (!_isUpvoted) {
      setState(() {
        upvoteCount += 1;
        widget.upvotes[currentUser.email] = true;
        widget.downvotes[currentUser.email] = false;
      });
      quesref.document(widget.quesID).updateData({
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
      quesref.document(widget.quesID).updateData({
        'downvotes': widget.downvotes,
      });
    } else if (!_isDownVoted) {
      setState(() {
        downvoteCount += 1;
        widget.downvotes[currentUser.email] = true;
        widget.upvotes[currentUser.email] = false;
      });
      quesref.document(widget.quesID).updateData({
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

  void deleteQuestion(
      {String title = 'Are you Sure?',
      String content = 'Do you want to remove this Question?'}) async {
    var quesOwner = widget.userEmail == currentUser.email;
    if (!quesOwner) {
      return;
    }
    delete = await showDialog(
      context: context,
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
      await quesref.document(widget.quesID).delete();
    }
  }

  Widget quesHeader() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(widget.photoUrl),
        backgroundColor: Colors.transparent,
      ),
      title: GestureDetector(
        onTap: () => () {},
        child: Text(
          '${widget.author} Asked the following',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      trailing: Text(
        'Asked ${widget.timeAgo}',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget quesBody() {
    return GestureDetector(
      onLongPress: deleteQuestion,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 15,
                          child: Text(
                            'Q',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '${widget.question}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget quesfooter() {
    upvoteCount = getVote(widget.upvotes);
    downvoteCount = getVote(widget.downvotes);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 17,
            ),
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
            SizedBox(
              width: 60,
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
        Row(
          children: [
            GestureDetector(
              onTap: upvoteCount == 0
                  ? null
                  : () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpDownVote(
                                packageID: widget.quesID,
                                pageName: 'UpVotes',
                                ref: quesref,
                              )));
                    },
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
              onTap: downvoteCount == 0
                  ? null
                  : () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpDownVote(
                                packageID: widget.quesID,
                                pageName: 'DownVotes',
                                ref: quesref,
                              )));
                    },
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
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 20,
                top: 2,
              ),
              child: Text(
                widget.author,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            Expanded(
              child: Text(
                widget.tags,
                softWrap: true,
                style: TextStyle(
                  color: Colors.pink,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {},
            child: FlatButton(
              color: Colors.blue,
              child: Text(
                'Answers',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AnsQNA(
                  quesID: widget.quesID,
                ),
              )),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        quesHeader(),
        quesBody(),
        quesfooter(),
        Divider(
          color: Colors.grey,
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
