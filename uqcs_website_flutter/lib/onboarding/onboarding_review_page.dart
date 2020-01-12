import 'package:flutter/material.dart';
import 'package:uqcs_website_flutter/styles.dart';
import 'package:uqcs_website_flutter/wide_button.dart';

import '../colors.dart';

class ReviewPage extends StatelessWidget {
  final String fullName;
  final String email;
  final String gender;
  final bool isStudent;
  final String studentNumber;
  final String degree;
  final bool isDomestic;
  final bool isUndergrad;
  final String yearOfStudy;

  ReviewPage(
      {@required this.fullName,
      @required this.email,
      @required this.gender,
      @required this.isStudent,
      this.studentNumber,
      this.degree,
      this.isDomestic,
      this.yearOfStudy,
      this.isUndergrad});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Confirm details",
            style: kTitleStyle,
          ),
          Text(
            'Please confirm below information is correct.',
            style: kExtraTextStyle,
          ),
          createReviewItems(),
          Expanded(child: SizedBox()),
          WideButton(
            text: 'Proceed to Payment',
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget createReviewItems() {
    List<Widget> textReviewItems = [];
    textReviewItems.add(textReviewItem("Full Name", fullName));
    textReviewItems.add(textReviewItem("Email", email));
    textReviewItems.add(textReviewItem("Gender", gender));

    if (isStudent) {
      textReviewItems.add(textReviewItem("Student Number", studentNumber));
      textReviewItems.add(textReviewItem("Degree", degree));
      textReviewItems.add(textReviewItem("Domestic or International",
          isDomestic ? "Domestic" : "International"));
      textReviewItems.add(textReviewItem("Undergrad or Postgrad",
          isUndergrad ? "Undergraduate" : "Postgraduate"));
      textReviewItems.add(textReviewItem("Year of Study", yearOfStudy));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(children: textReviewItems),
    );
  }

  Widget textReviewItem(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            "$title: ",
            style: kExtraTextStyle.copyWith(fontSize: 18, color: uqcsBlue),
          ),
          Text(
            '$value',
            style: kExtraTextStyle.copyWith(fontSize: 18, color: Colors.white),
          )
        ],
      ),
    );
  }
}
