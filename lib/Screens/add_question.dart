import 'package:StudGo/Screens/QNA.dart';
import 'package:StudGo/Screens/home.dart';
import 'package:flutter/material.dart';

class ADDQuestion extends StatefulWidget {
  @override
  _ADDQuestionState createState() => _ADDQuestionState();
}

class _ADDQuestionState extends State<ADDQuestion> {
  void submit() async {
    if (!key.currentState.validate()) {
      // Invalid!
      return;
    }
    key.currentState.save();
    final doc = await quesref.add({
      'question': contentController,
      'userEmail': currentUser.email,
      'author': currentUser.displayName,
      'photoUrl': currentUser.photoUrl,
      'questionID': '',
      'timestamp': DateTime.now(),
      'tags': tagController,
      'upvotes': {},
      'downvotes': {},
      'upvoteCounter': 0,
      'downvoteCounter': 0,
    });
    await quesref.document(doc.documentID).updateData({
      'questionID': doc.documentID,
    });
    print(doc.documentID);
    Navigator.of(context).pop();
  }

  GlobalKey<FormState> key = GlobalKey<FormState>();
  String contentController;
  var tagController = '';
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Form(
            key: key,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  width: MediaQuery.of(context).size.width * 0.98,
                  child: TextFormField(
                    validator: (value) {
                      if (value.length < 1) {
                        return 'Question cannot be blank';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      submit();
                    },
                    onSaved: (newValue) {
                      if (newValue.isEmpty) {
                        return;
                      }
                      contentController = newValue;
                    },
                    maxLines: 6,
                    decoration: InputDecoration(
                      labelText: 'Ask your Question',
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.green[600],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        gapPadding: 10,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  width: MediaQuery.of(context).size.width * 0.98,
                  child: TextFormField(
                    onFieldSubmitted: (value) {},
                    onSaved: (newValue) {
                      if (newValue.isEmpty) {
                        return;
                      }
                      tagController = newValue;
                    },
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Add Tags with #',
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.green[600],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        gapPadding: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 23,
                ),
                FlatButton(
                  onPressed: submit,
                  child: Text('Ask Question'),
                  color: Colors.green[600],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
