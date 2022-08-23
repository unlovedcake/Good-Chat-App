import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../widgets/animate-signup-textfield.dart';
import '../../widgets/rectangular_button.dart';
import '../../widgets/rectangular_input_field.dart';

class Credentials extends StatelessWidget {
   Credentials({Key? key}) : super(key: key);

   TextEditingController userNameController = TextEditingController();
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
          //  RectangularInputField(
          //   controller: userNameController,
          //   textInputType: TextInputType.text,
          //   hintText: 'Username',
          //   icon: Icons.person,
          //   obscureText: false,
          // ),
          // SizedBox(
          //   height: appPadding / 2,
          // ),
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
          Container (height: size.height, child: const AnimateSignUpFields()),
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
