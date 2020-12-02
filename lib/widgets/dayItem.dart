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
  @override
  void initState() {
    // subjects = widget.subjects as List<Map<String, Object>>;
    // getSubjects(subjects);
    super.initState();
  }

  List<Widget> getSubjects(List<dynamic> subjects) {
    subjects.forEach((element) {
      final subject = element['subject'];
      final priority = element['priority'];
      final topics = element['topics'];
      eachSubject.add(GestureDetector(
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SubjectToDay(
              day: widget.day,
              scheduleId: widget.scheduleId,
              subjects: subjects,
            ),
          ),
        ),
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.25,
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
                        style: TextStyle(color: Colors.white),
                      ),
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
                        style: TextStyle(color: Colors.white),
                      ),
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
      ));
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: eachSubject,
        ),
      ),
    );
  }
}
