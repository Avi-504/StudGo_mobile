import 'package:StudGo/Screens/add_schedule.dart';
import 'package:flutter/material.dart';

class SubjectToDay extends StatefulWidget {
  final day;
  final scheduleId;
  final subjects;
  SubjectToDay({this.day, this.scheduleId, this.subjects});
  @override
  _SubjectToDayState createState() => _SubjectToDayState();
}

class _SubjectToDayState extends State<SubjectToDay> {
  List<dynamic> subjects;

  void submit1() async {
    if (!key2.currentState.validate()) {
      // Invalid!
      return;
    }
    key2.currentState.save();
    Map<String, Object> subject = {
      'priority': priority,
      'subject': subjectController,
      'topics': topicsController,
    };

    setState(() {
      subjects.add(subject);
    });

    await schedref
        .document(widget.scheduleId)
        .collection('dayPlan')
        .document('day${widget.day}')
        .updateData({
      'day': widget.day,
      'subjects': subjects,
    });
    setState(() {
      subjectController = '';
      topicsController = '';
      priority = null;
      priorityController = '';
      key2.currentState.reset();
    });
    Navigator.of(context).pop();
  }

  GlobalKey<FormState> key2 = GlobalKey<FormState>();
  var titleController = ' ';
  String subjectController;
  String topicsController;
  String priorityController;
  TextEditingController subtextcont;
  TextEditingController toptextcont;
  TextEditingController protextcont;
  var priority;

  @override
  Widget build(BuildContext context) {
    subjects = widget.subjects;
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
            key: key2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      controller: subtextcont,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Subject Cannot be Blank';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        subjectController = newValue;
                      },
                      decoration: InputDecoration(
                        labelText: 'Subject',
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
                    controller: toptextcont,
                    onFieldSubmitted: (value) {},
                    onSaved: (newValue) {
                      if (newValue.isEmpty) {
                        return;
                      }
                      topicsController = newValue;
                    },
                    maxLines: 10,
                    decoration: InputDecoration(
                      labelText: 'Add topics',
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
                    controller: protextcont,
                    onFieldSubmitted: (value) {
                      submit1();
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Set priority';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      if (newValue.isEmpty) {
                        return;
                      }
                      priorityController = newValue;
                      priority = priorityController.toLowerCase() == 'high';
                    },
                    decoration: InputDecoration(
                      labelText: 'Set priority to low or high',
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
                  onPressed: () => submit1(),
                  child: Text('Add Subject to day'),
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
