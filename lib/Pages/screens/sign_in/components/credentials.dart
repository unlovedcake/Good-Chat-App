

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../widgets/animated-signin-textfield.dart';
import '../../widgets/rectangular_button.dart';
import '../../widgets/rectangular_input_field.dart';

class Credentials extends StatelessWidget {
  Credentials({Key? key}) : super(key: key);


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Padding(
      padding:  EdgeInsets.all(appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container (height: size.height, child: const AnimateSignInFields()),
          // RectangularInputField(
          //   controller: emailController,
          //   textInputType: TextInputType.emailAddress,
          //   hintText: 'Email',
          //   icon: Icons.email_rounded,
          //   obscureText: false,
          // ),
          // SizedBox(
          //   height: appPadding / 2,
          // ),
          // RectangularInputField(
          //   controller: passwordController,
          //   textInputType: TextInputType.text,
          //   hintText: 'Password',
          //   icon: Icons.lock,
          //   obscureText: true,
          // ),
          // SizedBox(
          //   height: appPadding / 2,
          // ),
          // Center(
          //   child: Text(
          //     'Forget Password?',
          //     style: TextStyle(
          //       fontWeight: FontWeight.w400,
          //       fontSize: 17,
          //     ),
          //   ),
          // ),
          // RectangularButton(text: 'Sign In', press: (){})
        ],
      ),
    );
  }
}
