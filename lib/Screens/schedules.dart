import 'package:StudGo/Screens/add_schedule.dart';
import 'package:StudGo/Screens/home.dart';
import 'package:StudGo/widgets/schedule.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final schedref = Firestore.instance
    .collection('schedules')
    .document(currentUser.email)
    .collection('schedule')
    .snapshots();

class Schedules extends StatefulWidget {
  @override
  _SchedulesState createState() => _SchedulesState();
}

class _SchedulesState extends State<Schedules> {
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
      body: StreamBuilder(
          stream: schedref,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return snapshot.data.documents.length == 0
                ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage('images/drawing.png'),
                            height: MediaQuery.of(context).size.height * 0.5,
                          ),
                          Text(
                            'No Schedules \n  \n Add Your Schedules now',
                            textAlign: TextAlign.center,
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
                : ListView.builder(
                    reverse: false,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      int dayCount =
                          (snapshot.data.documents[index]['dayCount']);
                      String scheduleID =
                          (snapshot.data.documents[index]['scheduleID']);
                      String title = (snapshot.data.documents[index]['title']);
                      return ScheduleItem(
                        dayCount: dayCount,
                        title: title,
                        scheduleID: scheduleID,
                      );
                    },
                  );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => AddSchedule(), fullscreenDialog: false),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
