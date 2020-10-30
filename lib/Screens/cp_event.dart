import 'package:StudGo/providers/comp.dart';
import 'package:StudGo/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CpEvent extends StatefulWidget {
  @override
  _CpEventState createState() => _CpEventState();

  var resourceid;

  CpEvent(this.resourceid);
}

class _CpEventState extends State<CpEvent> {
  var resid;
  @override
  void initState() {
    resid = widget.resourceid.toString();
    Provider.of<Comp>(context, listen: false).getEvent(resid);
    super.initState();
  }

  Future<bool> backHandler() {
    Provider.of<Comp>(context, listen: false).reset();
    Navigator.of(context).pop(true);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final newsData = Provider.of<Comp>(context);
    final list = newsData.events;
    return WillPopScope(
      onWillPop: backHandler,
      child: Scaffold(
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
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) => EventItem(
                  eventItem: list[index],
                ),
              ),
      ),
    );
  }
}
