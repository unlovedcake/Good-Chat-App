import 'package:flutter/material.dart';
import 'package:good_chat_app/Pages/screens/sign_up/sigup_screen.dart';

import '../../../constants/constants.dart';
import '../../sign_in/sigin_screen.dart';
import '../../widgets/account_check.dart';
import '../../widgets/rounded_button.dart';

class Social extends StatelessWidget {
  const Social({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'OR',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: appPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RoundedButton(imageSrc: 'assets/images/google.png', press: () {}),
              RoundedButton(
                  imageSrc: 'assets/images/facebook.png', press: () {}),
              RoundedButton(
                  imageSrc: 'assets/images/twitter.png', press: () {}),
            ],
          ),
        ),
        SizedBox(
          height: appPadding,
        ),
        AccountCheck(
          login: false,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignUpScreen();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
