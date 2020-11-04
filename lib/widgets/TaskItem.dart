import 'package:StudGo/Screens/home.dart';
import 'package:StudGo/Screens/to-do.dart';

import 'package:flutter/material.dart';

class TaskItem extends StatefulWidget {
  final String title;
  final String content;
  final String docId;
  final bool done;
  TaskItem({this.content, this.title, this.docId, this.done});
  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  var delete = false;
  var isDone;
  var isLoading = true;
  var refresh;
  @override
  void initState() {
    fetchState();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    refresh = false;
    super.didChangeDependencies();
  }

  void fetchState() {
    isDone = widget.done;
    print(widget.done);
    setState(() {
      isLoading = false;
    });
  }

  void updateStatus() async {
    try {
      await taskRef
          .document(currentUser.email)
          .collection('task')
          .document(widget.docId)
          .updateData({'done': !isDone});
      setState(() {
        isDone = !isDone;
      });
      if (isDone) {
        deleteTask(
            content: 'Delete this Completed Task?',
            title: 'Delete Completed Task?');
      }
    } catch (err) {
      setState(() {
        isDone = isDone;
      });
    }
    setState(() {
      refresh = true;
    });
  }

  void deleteTask(
      {String title = 'Are you Sure?',
      String content = 'Do you want to delete this task?'}) async {
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
      await taskRef
          .document(currentUser.email)
          .collection('task')
          .document(widget.docId)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container()
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onLongPress: deleteTask,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                    color: isDone
                        ? Colors.green.withOpacity(0.88)
                        : Colors.grey[800],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        GestureDetector(
                          child: isDone
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 36,
                                )
                              : Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green[600],
                                  size: 36,
                                ),
                          onTap: updateStatus,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.005,
                              ),
                              Expanded(
                                child: Text(
                                  widget.title,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: isDone
                                        ? Colors.white
                                        : Colors.green[600],
                                    fontSize: 22,
                                    decoration: isDone
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  widget.content,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    color: isDone ? Colors.white : Colors.grey,
                                    fontSize: 17,
                                    decoration: isDone
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
  }
}
