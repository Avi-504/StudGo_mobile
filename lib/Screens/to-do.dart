import 'package:StudGo/Screens/home.dart';
import 'package:StudGo/providers/task.dart';
import 'package:StudGo/widgets/TaskItem.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

final taskRef = Firestore.instance.collection('tasks');

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  String titleController;
  var contentController = '';
  var isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Task>(context).getTasks();
    }
    isInit = false;

    super.didChangeDependencies();
  }

  void submit() async {
    if (!key.currentState.validate()) {
      // Invalid!
      return;
    }
    key.currentState.save();
    final doc =
        await taskRef.document(currentUser.email).collection('task').add({
      'content': contentController,
      'title': titleController,
      'done': false,
    });
    // print(doc.documentID);
    Navigator.of(context).pop();
    Provider.of<Task>(context, listen: false).addTask(
        title: titleController,
        content: contentController,
        docId: doc.documentID);
    contentController = '';
    Provider.of<Task>(context, listen: false).getTasks();
    setState(() {
      print("SETTING STATE");
    });
  }

  void bottomModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(125),
                ),
                child: Form(
                  key: key,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
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
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          validator: (value) {
                            if (value.length > 40) {
                              return 'Too Long keep it short and crisp!';
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
                          decoration: InputDecoration(
                            labelText: 'Add Task',
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
                        height: 20,
                      ),
                      FlatButton(
                        onPressed: submit,
                        child: Text('Add'),
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
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<Task>(context);
    final list = taskData.task;
    final doneCount = taskData.getDoneCount();
    final percent = list.isEmpty
        ? 0
        : ((doneCount / list.length) * 100).truncate().toString();
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
      body: list.isEmpty
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'images/no_content.svg',
                      height: MediaQuery.of(context).size.height * 0.7,
                    ),
                    Text(
                      'No Tasks',
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
          : Stack(children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: ListView.builder(
                    itemBuilder: (context, index) => TaskItem(
                          content: list[index].content,
                          title: list[index].title,
                          docId: list[index].docId,
                          done: list[index].done,
                        ),
                    itemCount: list.length),
              ),
              list.isEmpty
                  ? Container()
                  : Positioned(
                      top: 0.0,
                      right: 10,
                      child: Container(
                        height: 105,
                        width: 105,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              offset: Offset(0, 1),
                              blurRadius: 9.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: RichText(
                                text: TextSpan(
                              children: [
                                TextSpan(
                                  text: percent,
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                TextSpan(
                                  text: ' %',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ],
                            )),
                          ),
                        ),
                      ),
                    ),
            ]),
      floatingActionButton: FloatingActionButton(
        onPressed: bottomModalSheet,
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
