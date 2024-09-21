  import 'package:flutter/material.dart';
  class CustomSwitch extends StatefulWidget {
    @override
    _ReminderSwitchState createState() => _ReminderSwitchState();
  }

  class _ReminderSwitchState extends State<CustomSwitch> {
    bool _isSwitched = false;

    get buttonColor => Color(0xffFF4956);

    @override
    Widget build(BuildContext context) {
      return Switch(
        activeColor: Colors.white,
        activeTrackColor: Color(0xFFA7713F),
        value: _isSwitched,
        onChanged: (value) {
          setState(() {
            _isSwitched = value;
            if (_isSwitched) {
              // _showReminderDialog(context);
            }
          });
        },
      );
    }
  }