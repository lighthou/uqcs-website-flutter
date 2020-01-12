import 'package:flutter/material.dart';
import 'package:uqcs_website_flutter/styles.dart';

import 'colors.dart';

class WideButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  WideButton({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: ButtonTheme(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5.0),
        ),
        minWidth: double.infinity,
        child: RaisedButton(
            disabledColor: disabledColor,
            color: uqcsBlue,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                text,
                style: kButtonTextStyle,
              ),
            ),
            onPressed: onPressed),
      ),
    );
  }
}
