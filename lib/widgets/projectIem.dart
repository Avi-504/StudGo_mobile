import 'package:StudGo/Screens/home.dart';
import 'package:StudGo/Screens/projects.dart';
import 'package:StudGo/Screens/up_downvote.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectItem extends StatefulWidget {
  final String author;
  final String projectID;
  final String userEmail;
  final String content;
  final Map upvotes;
  final Map downvotes;
  final String photoUrl;
  final String tags;
  final String title;
  final String timeAgo;
  final String link;
  final int upvoteCounter;
  final int downvoteCounter;

  ProjectItem({
    this.author,
    this.content,
    this.downvoteCounter,
    this.downvotes,
    this.link,
    this.photoUrl,
    this.projectID,
    this.tags,
    this.timeAgo,
    this.title,
    this.upvoteCounter,
    this.upvotes,
    this.userEmail,
  });
  @override
  _ProjectItemState createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
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

  int getLikesCount(likes) {
    if (likes == null) {
      return 0;
    }
    int count = 0;
    likes.values.forEach((value) {
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
      projectref.document(widget.projectID).updateData({
        'upvotes': widget.upvotes,
      });
    } else if (!_isUpvoted) {
      setState(() {
        upvoteCount += 1;
        widget.upvotes[currentUser.email] = true;
        widget.downvotes[currentUser.email] = false;
      });
      projectref.document(widget.projectID).updateData({
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
      projectref.document(widget.projectID).updateData({
        'downvotes': widget.downvotes,
      });
    } else if (!_isDownVoted) {
      setState(() {
        downvoteCount += 1;
        widget.downvotes[currentUser.email] = true;
        widget.upvotes[currentUser.email] = false;
      });
      projectref.document(widget.projectID).updateData({
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

  void openBrowser() async {
    final url = widget.link;
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Teleporting you to project site',
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
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Looks like the project url has moved or url is incorrect',
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
      throw 'Could not launch $url';
    }
  }

  void deleteProject(
      {String title = 'Are you Sure?',
      String content = 'Do you want to remove this Project?'}) async {
    var projectOwner = widget.userEmail == currentUser.email;
    if (!projectOwner) {
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
      await projectref.document(widget.projectID).delete();
    }
  }

  Widget projectHeader() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(widget.photoUrl),
        backgroundColor: Colors.transparent,
      ),
      title: GestureDetector(
        onTap: () => () {},
        child: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      trailing: Text(
        'Added ${widget.timeAgo}',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget projectBody() {
    return GestureDetector(
      onLongPress: deleteProject,
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
                  child: Text(
                    '${widget.content}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget projectFooter() {
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
                                packageID: widget.projectID,
                                pageName: 'UpVotes',
                                ref: projectref,
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
                                packageID: widget.projectID,
                                pageName: 'DownVotes',
                                ref: projectref,
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
            onTap: openBrowser,
            child: Text(
              widget.link,
              style: TextStyle(
                color: Colors.blue,
              ),
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
        projectHeader(),
        projectBody(),
        projectFooter(),
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
