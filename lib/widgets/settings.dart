import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  final Function onBackPressed;
  const Settings({Key key, @required this.onBackPressed}) : assert(onBackPressed!=null),super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Settings',
            style: TextStyle(
              fontSize: 60,
              color: Colors.white,
            ),
          ),
          SwitchListTile(
            title: Text(
              'SFX',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),),
            value: true,
            onChanged: (bool value) {

            },
          ),
          SwitchListTile(
            title: Text(
              'BGM',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),),
            value: true,
            onChanged: (bool value) {

            },
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: 30,
              color: Colors.white,
            ),
            onPressed: onBackPressed,
          ),
        ],
      ),
    );
  }
}