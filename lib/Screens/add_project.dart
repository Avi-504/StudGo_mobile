import 'package:StudGo/Screens/home.dart';
import 'package:StudGo/Screens/projects.dart';
import 'package:flutter/material.dart';

class AddProject extends StatefulWidget {
  @override
  _AddProjectState createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  void submit() async {
    if (!key.currentState.validate()) {
      // Invalid!
      return;
    }
    key.currentState.save();
    final doc = await projectref.add({
      'content': contentController,
      'displayName': currentUser.displayName,
      'title': titleController,
      'userEmail': currentUser.email,
      'author': currentUser.displayName,
      'photoUrl': currentUser.photoUrl,
      'projectID': '',
      'timestamp': DateTime.now(),
      'tags': tagController,
      'link': linkController,
      'upvotes': {},
      'downvotes': {},
      'upvoteCounter': 0,
      'downvoteCounter': 0,
    });
    await projectref.document(doc.documentID).updateData({
      'projectID': doc.documentID,
    });
    print(doc.documentID);
    Navigator.of(context).pop();
  }

  GlobalKey<FormState> key = GlobalKey<FormState>();
  String titleController;
  var contentController = '';
  var tagController = '';
  String linkController;
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.98,
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Title Cannot be Blank';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        titleController = newValue;
                      },
                      decoration: InputDecoration(
                        labelText: 'Title',
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
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  width: MediaQuery.of(context).size.width * 0.98,
                  child: TextFormField(
                    validator: (value) {
                      if (value.length < 19) {
                        return 'Too Short keep it atleast 20 words';
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
                      labelText: 'Tell us something about your project',
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  width: MediaQuery.of(context).size.width * 0.98,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Add a Link';
                      }
                      if (!value.contains('www')) {
                        return 'Please provide a valid link';
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
                      linkController = newValue;
                    },
                    decoration: InputDecoration(
                      labelText: 'Repository Link',
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
                  child: Text('Add Project'),
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
