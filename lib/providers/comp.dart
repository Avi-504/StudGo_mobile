import 'package:StudGo/models/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Comp with ChangeNotifier {
  var yearMonth = DateTime.now().toString();
  List event = [];
  List<Event> eventdata = [];

  List get events {
    return [...eventdata];
  }

  void reset() {
    eventdata = [];
  }

  void getEvent(String resid) async {
    var td = yearMonth.substring(0, 7);
    var url =
        'https://clist.by/api/v1/contest/?username=StudGO&api_key=6435c0c6e2a47cf37f64a4cf096a920b8c096bf5&resource__id=$resid&order_by=start&format=json&start__gte=$td-01T00%3A00%3A00';
    final doc = await http.get(url);
    var eventbody = json.decode(doc.body) as Map;
    event = eventbody['objects'];
    event.forEach((element) {
      var ele = element as Map;
      eventdata.add(Event(
        duration: ele['duration'],
        start: ele['start'],
        end: ele['end'],
        event: ele['event'],
        url: ele['href'],
      ));
    });

    notifyListeners();
  }
}
