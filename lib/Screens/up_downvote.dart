import 'package:StudGo/Screens/home.dart';
import 'package:StudGo/models/users.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpDownVote extends StatefulWidget {
  final packageID;
  final pageName;
  final ref;

  UpDownVote({
    this.packageID,
    this.pageName,
    this.ref,
  });
  @override
  _UpDownVoteState createState() => _UpDownVoteState();
}

class _UpDownVoteState extends State<UpDownVote> {
  final List<User> users = [];
  var isLoading = true;
  var isInit = true;
  var ref;
  @override
  void initState() {
    getuserVotes();
    widget.ref.document(widget.packageID).get();

    super.initState();
  }

  void getuserVotes() async {
    DocumentSnapshot ref = await widget.ref.document(widget.packageID).get();
    setusers(context, ref);
  }

  void setusers(BuildContext context, DocumentSnapshot snapshot) {
    if (isInit) {
      Map votes;
      if (widget.pageName == 'UpVotes')
        votes = snapshot.data['upvotes'];
      else
        votes = snapshot.data['downvotes'];
      votes.forEach((key, value) async {
        if (value) {
          DocumentSnapshot user = await userRef.document(key).get();
          final eachUser = User.fromDocument(user);
          setState(() {
            isLoading = false;
          });
          users.add(eachUser);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.pageName,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[900],
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          CachedNetworkImageProvider(users[index].photoUrl),
                    ),
                    title: Text(
                      users[index].displayName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      users[index].email,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    trailing: widget.pageName == 'UpVotes'
                        ? Icon(
                            Icons.arrow_upward,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.arrow_downward,
                            color: Colors.red,
                          ),
                  );
                }));
  }
}
