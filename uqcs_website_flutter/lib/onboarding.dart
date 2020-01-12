import 'package:flutter/material.dart';
import 'package:uqcs_website_flutter/colors.dart';
import 'package:uqcs_website_flutter/onboarding/onboarding_review_page.dart';
import 'package:uqcs_website_flutter/onboarding/onboarding_single_button_input_page.dart';

import 'onboarding/onboarding_text_input_page.dart';

class OnboardingScreen extends StatefulWidget {
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

enum UserDataType {
  FULL_NAME,
  EMAIL,
  GENDER,
  IS_STUDENT,
  STUDENT_NUMBER,
  IS_DOMESTIC,
  DEGREE,
  IS_UNDERGRAD,
  YEAR,
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final emailRegex =
      RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
  int _numPages = 5;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  Function createVariableCallback(UserDataType type) {
    return (value) {
      setState(() {
        switch (type) {
          case UserDataType.FULL_NAME:
            _fullName = value;
            break;
          case UserDataType.EMAIL:
            _email = value;
            break;
          case UserDataType.GENDER:
            _gender = value;
            break;
          case UserDataType.IS_STUDENT:
            _isStudent = value == "Yes";
            break;
          case UserDataType.STUDENT_NUMBER:
            _studentNumber = value;
            break;
          case UserDataType.IS_DOMESTIC:
            _isDomestic = value == "Domestic";
            break;
          case UserDataType.DEGREE:
            _degree = value;
            break;
          case UserDataType.IS_UNDERGRAD:
            _isUndergrad = value == "Undergraduate";
            break;
          case UserDataType.YEAR:
            _year = value;
            break;
        }
        print("Got value: $value");
      });
    };
  }

  String _fullName;
  String _email;
  String _gender;
  bool _isStudent;
  String _studentNumber;
  bool _isDomestic;
  String _degree;
  bool _isUndergrad;
  String _year;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Future<bool> _onWillPop() async {
    if (_currentPage == 0) {
      return true;
    } else {
      if (_currentPage == 4) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
      _pageController.previousPage(
          duration: Duration(milliseconds: 500), curve: Curves.ease);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          color: backgroundColor,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      //If it's a page which goes back onto a button page.
                      if (_currentPage == 4) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                      _pageController.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: uqcsBlue,
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        OnboardingTextInputPage(
                          initalText: _fullName,
                          completionCallback:
                              createVariableCallback(UserDataType.FULL_NAME),
                          promptText: "What is your full name?",
                          hintText: "John Smith",
                          onNextButtonPressed: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          textInputType: TextInputType.text,
                          maxLength: 50,
                          textValidation: RegExp(r".*"),
                        ),
                        OnboardingTextInputPage(
                          initalText: _email,
                          completionCallback:
                              createVariableCallback(UserDataType.EMAIL),
                          promptText: "What is your email address?",
                          hintText: "s4433119@student.uq.edu.au",
                          onNextButtonPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          textInputType: TextInputType.emailAddress,
                          maxLength: 50,
                          textValidation: emailRegex,
                        ),
                        OnboardingSingleChoiceInputPage(
                          completionCallback:
                              createVariableCallback(UserDataType.GENDER),
                          initialValue: _gender,
                          promptText: "What is your gender?",
                          buttonChoices: [
                            "Male",
                            "Female",
                            "Other",
                          ],
                          onNextButtonPressed: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                        ),
                        OnboardingSingleChoiceInputPage(
                          initialValue: _isStudent == null
                              ? null
                              : _isStudent ? "Yes" : "No",
                          completionCallback:
                              createVariableCallback(UserDataType.IS_STUDENT),
                          promptText: "Are you studying at UQ?",
                          extraText: "This helps us get extra funding from UQ.",
                          onNextButtonPressed: () {
                            if (_isStudent == true) {
                              setState(() {
                                _numPages = 10;
                              });
                            }
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          buttonChoices: <String>["Yes", "No"],
                        ),
                        OnboardingTextInputPage(
                          initalText: _studentNumber,
                          promptText: "What is your student number?",
                          hintText: "44331199",
                          onNextButtonPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          textInputType: TextInputType.number,
                          maxLength: 8,
                          textValidation: RegExp(r"[0-9]{8}"),
                          completionCallback: createVariableCallback(
                              UserDataType.STUDENT_NUMBER),
                        ),
                        OnboardingTextInputPage(
                          initalText: _degree,
                          promptText: "What Degree are you Studying?",
                          hintText: "Engineering (Software)",
                          onNextButtonPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          textInputType: TextInputType.text,
                          maxLength: 50,
                          textValidation: RegExp(r".*"),
                          completionCallback:
                              createVariableCallback(UserDataType.DEGREE),
                        ),
                        OnboardingSingleChoiceInputPage(
                          initialValue: _isDomestic == null
                              ? null
                              : _isDomestic ? "Domestic" : "International",
                          completionCallback:
                              createVariableCallback(UserDataType.IS_DOMESTIC),
                          promptText:
                              "Are you a Domestic or International student?",
                          onNextButtonPressed: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          buttonChoices: <String>["Domestic", "International"],
                        ),
                        OnboardingSingleChoiceInputPage(
                          initialValue: _isUndergrad == null
                              ? null
                              : _isUndergrad ? "Undergraduate" : "Postgraduate",
                          completionCallback:
                              createVariableCallback(UserDataType.IS_UNDERGRAD),
                          promptText: "Are you an Undergrad or Postgrad?",
                          onNextButtonPressed: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          buttonChoices: <String>[
                            "Undergraduate",
                            "Postgraduate"
                          ],
                        ),
                        OnboardingSingleChoiceInputPage(
                          initialValue: _year == null ? null : _year,
                          completionCallback:
                              createVariableCallback(UserDataType.YEAR),
                          promptText: "What year of study are you in?",
                          onNextButtonPressed: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          buttonChoices: <String>[
                            "First Year",
                            "Second Year",
                            "Third Year",
                            "Fourth Year",
                            "Fifth Year+"
                          ],
                        ),
                        ReviewPage(
                          fullName: _fullName,
                          email: _email,
                          gender: _gender,
                          isStudent: _isStudent,
                          studentNumber: _studentNumber,
                          isDomestic: _isDomestic,
                          isUndergrad: _isUndergrad,
                          degree: _degree,
                          yearOfStudy: _year,
                        )
                      ],
                    ),
                  ),
//                Expanded(
//                  child: Padding(
//                      padding: EdgeInsets.only(top: 20), child: FirstPage()),
//                ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? uqcsBlue : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
