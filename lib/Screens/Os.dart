import 'package:StudGo/Screens/Os_Static.dart';
import 'package:StudGo/Screens/projects.dart';
import 'package:StudGo/Screens/quiz.dart';
import 'package:flutter/material.dart';

class OpenSource extends StatefulWidget {
  @override
  _OpenSourceState createState() => _OpenSourceState();
}

class _OpenSourceState extends State<OpenSource> {
  List<Map<String, Object>> pages;
  int selectedPageIndex = 0;

  @override
  void initState() {
    pages = [
      {
        'page': OpenSourceStatic(),
        'title': 'OpenSource',
      },
      {
        'page': Quiz(),
        'title': 'Quiz',
      },
      {
        'page': Projects(),
        'title': 'Projects',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.category,
            ),
            title: Text(
              'OpenSource',
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.assignment,
            ),
            title: Text(
              'Quiz',
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.assessment,
            ),
            title: Text(
              'Projects',
            ),
          ),
        ],
      ),
    );
  }
}
