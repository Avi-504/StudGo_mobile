import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final Function logout;
  Profile(this.logout);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RaisedButton(
        onPressed: widget.logout,
        child: Text('Logout'),
      ),
    );
  }
}
