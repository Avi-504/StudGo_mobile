import 'package:flutter/material.dart';

class Answer extends StatefulWidget {
  final answer;
  final correct;

  Answer({this.answer, this.correct});
  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  var isSelectedCorrect = 'un';
  void selectAnswer() {
    if (widget.correct) {
      setState(() {
        isSelectedCorrect = 'true';
      });
    } else
      setState(() {
        isSelectedCorrect = 'false';
      });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectAnswer,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelectedCorrect == ('true') || isSelectedCorrect == ('false')
              ? isSelectedCorrect == ('true') ? Colors.green : Colors.red
              : Colors.white24,
        ),
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Text(
          widget.answer,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
