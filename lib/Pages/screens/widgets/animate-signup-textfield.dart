import 'package:auto_animated/auto_animated.dart';

import 'package:flutter/material.dart';
import 'package:good_chat_app/Pages/screens/widgets/rectangular_button.dart';
import 'package:good_chat_app/Pages/screens/widgets/rectangular_input_field.dart';
import 'package:good_chat_app/Pages/screens/widgets/utils.dart';

import '../../constants/constants.dart';

import '../sign_up/components/head_text.dart';
import '../sign_in/components/social.dart';

class AnimateSignUpFields extends StatefulWidget {
  const AnimateSignUpFields({Key? key}) : super(key: key);

  @override
  _AnimateSignUpFieldsState createState() => _AnimateSignUpFieldsState();
}

class _AnimateSignUpFieldsState extends State<AnimateSignUpFields> {
  int itemsCount = 0;
  List<Widget> icon = [];

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    icon = [
      HeadText(),
      Form(
        key: _formKey,
        child: Column(
          children: [
            RectangularInputField(
              controller: userNameController,
              textInputType: TextInputType.text,
              hintText: 'Username',
              icon: Icons.person,
              obscureText: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return ("User name is required");
                }
              },
            ),
            RectangularInputField(
              controller: emailController,
              textInputType: TextInputType.emailAddress,
              hintText: 'Email',
              icon: Icons.email_rounded,
              obscureText: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Email  is required");
                }
              },
            ),
            RectangularInputField(
              controller: passwordController,
              textInputType: TextInputType.text,
              hintText: 'Password',
              icon: Icons.lock,
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Password  is required");
                }
              },
            ),
          ],
        ),
      ),
      SizedBox(
        height: appPadding / 2,
      ),
      RectangularButton(
          text: 'Sign Up',
          press: () {
            if (_formKey.currentState!.validate()) {}
          }),
      SizedBox(
        height: 60,
      ),
      Social(),
    ];

    itemsCount = icon.length;

    Future.delayed(Duration(milliseconds: 1000) * 5, () {
      if (!mounted) {
        return;
      }
      setState(() {
        if (icon.length > itemsCount) {
          itemsCount += 6;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return LiveList(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(16),
        showItemInterval: Duration(milliseconds: 150),
        showItemDuration: Duration(milliseconds: 250),
        visibleFraction: 0.001,
        itemCount: itemsCount,
        itemBuilder: animationItemBuilder((index) => icon[index]));
  }
}
