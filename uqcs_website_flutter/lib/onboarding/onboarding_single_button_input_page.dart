import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uqcs_website_flutter/styles.dart';
import 'package:uqcs_website_flutter/wide_button.dart';

import '../colors.dart';

class OnboardingSingleChoiceInputPage extends StatefulWidget {
  final String promptText;
  final List<String> buttonChoices;
  final Function onNextButtonPressed;
  final String extraText;
  final Function completionCallback;
  final String initialValue;

  OnboardingSingleChoiceInputPage(
      {@required this.promptText,
      @required this.buttonChoices,
      @required this.onNextButtonPressed,
      this.extraText,
      @required this.completionCallback,
      this.initialValue});

  @override
  _OnboardingSingleChoiceInputPageState createState() =>
      _OnboardingSingleChoiceInputPageState();
}

class _OnboardingSingleChoiceInputPageState
    extends State<OnboardingSingleChoiceInputPage> {
  String _selectedItem;
  bool _nextButtonEnabled = false;
  List<Widget> currentButtons = [];

  @override
  void initState() {
    _nextButtonEnabled = widget.initialValue != null;
    _selectedItem = widget.initialValue ?? null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.promptText,
            style: kTitleStyle,
          ),
          Text(
            widget.extraText ?? "",
            style: kExtraTextStyle,
          ),
          SizedBox(
            height: 40.0,
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _buildButtons(widget.buttonChoices),
            ),
          ),
          Expanded(child: SizedBox()),
          WideButton(
              text: 'Next',
              onPressed: !_nextButtonEnabled
                  ? null
                  : () {
                      widget.completionCallback(_selectedItem);
                      widget.onNextButtonPressed();
                    }),
        ],
      ),
    );
  }

  List<Widget> _buildButtons(List<String> options) {
    List<Widget> buttonList = [];
    for (String option in options) {
      buttonList.add(
        Expanded(
          child: ButtonTheme(
            minWidth: double.infinity,
            child: RaisedButton(
              child: Text(
                option,
                style: kSingleSelectButtonTextStyle,
              ),
              onPressed: () {
                setState(() {
                  _nextButtonEnabled = true;
                  _selectedItem = option;
                });
              },
              color: _selectedItem == option ? uqcsBlue : Colors.blue[100],
            ),
          ),
        ),
      );
    }
    return buttonList;
  }
}
