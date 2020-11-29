import 'package:StudGo/models/event.dart';
import 'package:flutter/material.dart';
import 'package:StudGo/Screens/home.dart';
import 'package:StudGo/Screens/to-do.dart';
import 'package:url_launcher/url_launcher.dart';

class EventItem extends StatefulWidget {
  final Event eventItem;
  EventItem({this.eventItem});
  @override
  _EventItemState createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  void actionsOnTap() async {
    var response = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          widget.eventItem.event,
        ),
        content:
            Text('Would ypu like to go to contest site or add it as a task ?'),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(ctx).pop('contest'),
            child: Text('Go to Contest Site'),
          ),
          FlatButton(
            onPressed: () => Navigator.of(ctx).pop('task'),
            child: Text('Add as a Task'),
          ),
        ],
      ),
    );
    if (response == (null)) {
      return;
    } else if (response == 'contest') {
      openBrowser();
    } else {
      final doc =
          await taskRef.document(currentUser.email).collection('task').add({
        'content': 'Competetive Coding Contest',
        'title': widget.eventItem.event,
        'done': false,
        'taskID': '',
      });
      await taskRef
          .document(currentUser.email)
          .collection('task')
          .document(doc.documentID)
          .updateData({
        'taskID': doc.documentID,
      });
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Added as a Task!',
          ),
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
      setState(() {
        print("SETTING STATE");
      });
    }
  }

  void openBrowser() async {
    final url = widget.eventItem.url;
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Hold Tight launching you to the contest!!',
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
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: actionsOnTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    height: MediaQuery.of(context).size.height * 0.2,
                    alignment: Alignment.center,
                    child: Text(
                      widget.eventItem.event,
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.watch_later,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(widget.eventItem.start.substring(0, 10)),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Text(widget.eventItem.start.substring(11)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.flag,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(widget.eventItem.end.substring(0, 10)),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Text(widget.eventItem.end.substring(11)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.schedule,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text((widget.eventItem.duration / 3600)
                          .toStringAsFixed(1)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
