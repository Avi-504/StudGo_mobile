import 'package:StudGo/Screens/addSubjecttoday.dart';
import 'package:flutter/material.dart';

class DayItem extends StatefulWidget {
  final subjects;
  final day;
  final scheduleId;

  DayItem({
    this.day,
    this.subjects,
    this.scheduleId,
  });
  @override
  _DayItemState createState() => _DayItemState();
}

class _DayItemState extends State<DayItem> {
  List<dynamic> subjects = [];
  List<Widget> eachSubject = [];
  var add;
  @override
  void initState() {
    // subjects = widget.subjects as List<Map<String, Object>>;
    // getSubjects(subjects);
    super.initState();
  }

  void addSubjecttoday(
      {String title = 'Are you Sure?',
      String content = 'Do you want to add a Subject to this Day?'}) async {
    add = await showDialog(
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
    if (add == (null)) {
      return;
    } else if (add == false) {
      return;
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SubjectToDay(
            day: widget.day,
            scheduleId: widget.scheduleId,
            subjects: subjects,
          ),
        ),
      );
    }
  }

  List<Widget> getSubjects(List<dynamic> subjects) {
    // if (subjects.isEmpty) {
    //   return [Container()];
    // }
    subjects.forEach((element) {
      final subject = element['subject'];
      final priority = element['priority'];
      final topics = element['topics'];
      eachSubject.add(
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      ' Day ${widget.day.toString()}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Subject :',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$subject',
                        softWrap: true,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Container(
                      child: Text(''),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Priority :',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: priority == true
                          ? Text(
                              'High',
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(
                              'Low',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Container(
                      child: Text(''),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Topics :',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        topics,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Container(
                      child: Text(''),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
    });
    return eachSubject;
  }

  @override
  Widget build(BuildContext context) {
    subjects = widget.subjects;
    getSubjects(subjects);
    eachSubject.insert(
        0,
        SizedBox(
          height: 40,
        ));
    return subjects.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: addSubjecttoday,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'No Subjects Added for Day ${widget.day}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: addSubjecttoday,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: eachSubject,
                ),
              ),
            ),
          );
  }
}
