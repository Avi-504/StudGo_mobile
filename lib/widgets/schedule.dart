import 'package:StudGo/Screens/days.dart';
import 'package:StudGo/Screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScheduleItem extends StatefulWidget {
  final title;
  final dayCount;
  final scheduleID;

  ScheduleItem({
    this.title,
    this.dayCount,
    this.scheduleID,
  });
  @override
  _ScheduleItemState createState() => _ScheduleItemState();
}

class _ScheduleItemState extends State<ScheduleItem> {
  var delete;
  void deleteSchedule(
      {String title = 'Are you Sure?',
      String content = 'Do you want to delete this Schedule?'}) async {
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
      await Firestore.instance
          .collection('schedules')
          .document(currentUser.email)
          .collection('schedule')
          .document(widget.scheduleID)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Days(
            scheduleID: widget.scheduleID,
          ),
        )),
        onLongPress: deleteSchedule,
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.cyan[900],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.alarm,
                    color: Colors.amberAccent,
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${widget.dayCount.toString()} Days',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
