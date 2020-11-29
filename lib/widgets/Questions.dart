import 'package:StudGo/widgets/answer.dart';
import 'package:flutter/material.dart';

class Questions extends StatefulWidget {
  final question;
  final options;
  Questions({
    this.question,
    this.options,
  });
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    widget.question,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Answer(
              answer: widget.options[0]['value'],
              correct: widget.options[0]['correct'],
            ),
            Answer(
              answer: widget.options[1]['value'],
              correct: widget.options[1]['correct'],
            ),
            Answer(
              answer: widget.options[2]['value'],
              correct: widget.options[2]['correct'],
            ),
            Answer(
              answer: widget.options[3]['value'],
              correct: widget.options[3]['correct'],
            ),
          ],
        ),
      ),
    );
  }
}
