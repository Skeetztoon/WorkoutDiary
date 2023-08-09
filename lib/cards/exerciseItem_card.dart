import 'package:flutter/material.dart';

class ExerciseItem extends StatelessWidget {
  final String textChild;

  ExerciseItem({required this.textChild});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        tileColor: const Color(0xFF3b3b3b),
        textColor: Colors.white,
        iconColor: Colors.white,
        // contentPadding: EdgeInsets.symmetric(horizontal: 20),
        // leading: FlutterLogo(size: 56.0),
        title: Text(
          textChild,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
        IconButton(
        icon: Icon(
          Icons.edit_rounded,
          size: 20.0,
        ),
        onPressed: () {
          //   _onDeleteItemPressed(index);
        },
      ),])
      ),
    );
  }
}
