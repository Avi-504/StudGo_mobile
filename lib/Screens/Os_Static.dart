import 'package:flutter/material.dart';

class OpenSourceStatic extends StatefulWidget {
  @override
  _OpenSourceStaticState createState() => _OpenSourceStaticState();
}

class _OpenSourceStaticState extends State<OpenSourceStatic> {
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
              fontSize: 31,
              fontFamily: 'MavenPro',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Open Source Development',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/os4.jpg'), fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'A software for which the original source code is made freely available and may be redistributed and modified according to the requirement of the user. Open source software is that by which the source code or the base code is usually available for modification or enhancement by anyone for reusability and accessibility. Open source code is the part of software that mostly users don\'t ever see. Anyone can manipulate and change a piece of software so that the program or application can work. Programmers who have access to a computer program source code can improve a program by adding features to it or fixing parts that don\'t always work correctly.',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'What is Open Souce Software?',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w400,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/os1.jpg'), fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Open source software is software with source code that anyone can inspect, modify, and enhance. "Source code" is the part of software that most computer users don\'t ever see; it\'s the code computer programmers can manipulate to change how a piece of software—a "program" or "application"—works. Programmers who have access to a computer program\'s source code can improve that program by adding features to it or fixing parts that don\'t always work correctly.',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Why do people prefer using open source software?',
              softWrap: true,
              style: TextStyle(
                color: Colors.green,
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/os2.jpg'), fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '	Control : Many people prefer open source software because they have more control over that kind of software. They can examine the code to make sure it\'s not doing anything they don\'t want it to do, and they can change parts of it they don\'t like. Users who aren\'t programmers also benefit from open source software, because they can use this software for any purpose they wish—not merely the way someone else thinks they should.',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '	Training : Other people like open source software because it helps them become better programmers. Because open source code is publicly accessible, students can easily study it as they learn to make better software. Students can also share their work with others, inviting comment and critique, as they develop their skills. When people discover mistakes in programs\' source code, they can share those mistakes with others to help them avoid making those same mistakes themselves.\n\n\nSecurity : Some people prefer open source software because they consider it more secure and stable than proprietary software. Because anyone can view and modify open source software, someone might spot and correct errors or omissions that a program\'s original authors might have missed. And because so many programmers can work on a piece of open source software without asking for permission from original authors, they can fix, update, and upgrade open source software more quickly than they can proprietary software.\n\n\nStability : Many users prefer open source software to proprietary software for important, long-term projects. Because programmers publicly distribute the source code for open source software, users relying on that software for critical tasks can be sure their tools won\'t disappear or fall into disrepair if their original creators stop working on them. Additionally, open source software tends to both incorporate and operate according to open standards.\n\n\nCommunity : Open source software often inspires a community of users and developers to form around it. That\'s not unique to open source; many popular applications are the subject of meetups and user groups. But in the case of open source, the community isn\'t just a fanbase that buys in (emotionally or financially) to an elite user group; it\'s the people who produce, test, use, promote, and ultimately affect the software they love.',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/os3.png'), fit: BoxFit.fill),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
