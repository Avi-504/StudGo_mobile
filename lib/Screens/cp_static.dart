import 'package:flutter/material.dart';

class CpStatic extends StatelessWidget {
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
              'Competitive Programming',
              style: TextStyle(
                color: Colors.white,
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
                    image: AssetImage('images/cp1.png'), fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Programming is fun, programming is an exercise for your brain, programming is a mental sport and when this sport is held over the internet involving sport programmer as a contestant then it is called Competitive Programming.',
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
              'Programming is a challenging role and once you enter this field you will encounter new challenges and you may have to solve some problems which no one has solved before or their solution doesn’t exist anywhere. At that time you are expected to come up with a solution in the least possible time using your problem-solving and logical ability. So the one and clear goal behind these competitive programming is “To prepare a programmer such that his/her logical ability increases and he/she is able to write code for the challenging situation.”',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
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
                    image: AssetImage('images/cp2.png'), fit: BoxFit.cover),
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
                    image: AssetImage('images/cp3.png'), fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Another reason is that a lot of big companies like Google, Facebook. Microsoft, Amazon hires through competitive programming so if you want to get into these companies then you really need to get your hands dirty in competitive programming. ',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
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
                    image: AssetImage('images/cp4.png'), fit: BoxFit.fill),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Keep in mind that you need to be proficient with the following',
              style: TextStyle(
                color: Colors.white,
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
            child: Text(
              '•	Any programming language syntax (Choose any but highly recommended C/C++/Java).',
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
              '•	Time and space complexity algorithms analysis.',
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
              '	•	Ability to think about a Brute Force Solution.',
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
              '	•	Good practice of all Data Structures like Array, List, Stack, Queue, Tree, Graph, Trie etc.',
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
                    image: AssetImage('images/cp5.png'), fit: BoxFit.fill),
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
                    image: AssetImage('images/cp6.jpg'), fit: BoxFit.fill),
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
                    image: AssetImage('images/cp7.png'), fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'How to prepare yourself for Competitive Programming?',
              style: TextStyle(
                color: Colors.white,
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
            child: Text(
              '•	Choose a Programming Language',
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
              '•	Understand the Concept of Time and Space Complexity',
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
              '	•	Learn the Fundamentals of Data Structures and Algorithms',
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
              '	•	Take the Challenge and Solve Coding Problems',
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
              '	•	Practice and Do it Regularly',
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
                    image: AssetImage('images/cp8.png'), fit: BoxFit.fill),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Why it is important:',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '	1.	Improves Logic: Programming logic improves by practice. You are smart from very beginning. With competitive programming you continuously train yourself with algorithmic problems that test the better out of your current logic skills. By practicing more and more your get better and improves your programming logic',
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
              '	2.	Makes you more focused and faster: Thinking about a problem and finding its solution make you more focused. With an improved logic, you will be able to think faster, solve problems faster, decide faster and put your thinking and solutions into code faster without going to and fro thinking which approach to use for your code.',
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
              '	3.	Helps you solve complicated problems: In programming contests after easy tasks you will solve complex tasks which are not for ordinary programmers. By doing CP you will learn how to solve these out of ordinary tasks. This will help prepare you for a job because you can adopt and solve various kind of problems in various type of situations.',
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
              '	4.	 Teaches you how to work in teams: Working in a team is very important skill in every field while in software development it is more important because most jobs will require you at some point to work in a team. CP helps you learn how to effectively work together, as you must work with others on your team to complete the same task. In this situation you will learn how to assess your team member’s strength and weakness and effectively divide responsibilities between each other.Additionally, in every company, each team have a leader. If you are in management role within a team, then knowing how to organize and motivate your team members is a key.',
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
              '	5.	Make you desirable candidate for major companies: Participating in CP contests make you a desirable candidate for big companies. In CP organizer websites and companies, these big companies always have a look and they pick the candidates with high potential ',
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
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
                    image: AssetImage('images/cp9.png'), fit: BoxFit.fill),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
