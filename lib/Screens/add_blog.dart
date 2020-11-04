import 'package:StudGo/Screens/Blogs.dart';
import 'package:flutter/material.dart';
import 'package:StudGo/Screens/home.dart';

class AddBlog extends StatefulWidget {
  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  void submit() async {
    if (!key.currentState.validate()) {
      // Invalid!
      return;
    }
    key.currentState.save();
    final doc = await blogref.add({
      'content': contentController,
      'title': titleController,
      'blogWriter': currentUser.email,
      'author':currentUser.displayName,
      'photo':currentUser.photoUrl,
      'blogID': '',
      'createdAt': DateTime.now(),
      'likes': {},
      'tags': tagController,
    });
    await blogref.document(doc.documentID).updateData({
      'blogID': doc.documentID,
    });
    print(doc.documentID);
    Navigator.of(context).pop();
  }

  GlobalKey<FormState> key = GlobalKey<FormState>();
  String titleController;
  var contentController = '';
  var tagController='';
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
                      if (value.length < 39) {
                        return 'Too Short keep it atleast 40 words';
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
                    maxLines: 10,
                    decoration: InputDecoration(
                      labelText: 'Add Blog Content',
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
                    onFieldSubmitted: (value) {
                      submit();
                    },
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
                  child: Text('Add Blog'),
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
