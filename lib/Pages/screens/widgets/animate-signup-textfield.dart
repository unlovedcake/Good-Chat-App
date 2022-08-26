import 'package:auto_animated/auto_animated.dart';

import 'package:flutter/material.dart';
import 'package:good_chat_app/Models/user-model.dart';
import 'package:good_chat_app/Pages/screens/widgets/rectangular_button.dart';
import 'package:good_chat_app/Pages/screens/widgets/rectangular_input_field.dart';
import 'package:good_chat_app/Pages/screens/widgets/utils.dart';
import 'package:good_chat_app/Provider/auth-provider.dart';
import 'package:provider/provider.dart';

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

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
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
              controller: firstNameController,
              textInputType: TextInputType.text,
              hintText: 'First Name',
              icon: Icons.person,
              obscureText: false,
              onChanged: (val) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return ("User name is required");
                }
              },
            ),
            RectangularInputField(
              controller: lastNameController,
              textInputType: TextInputType.text,
              hintText: 'Last Name',
              icon: Icons.person,
              obscureText: false,
              onChanged: (val) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Last name is required");
                }
              },
            ),
            RectangularInputField(
              controller: emailController,
              textInputType: TextInputType.emailAddress,
              hintText: 'Email',
              icon: Icons.email_rounded,
              obscureText: false,
              onChanged: (val) {},
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
              onChanged: (val) {},
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
            UserModel userModel = UserModel()
              ..firstName = firstNameController.text
              ..lastName = lastNameController.text
              ..email = emailController.text
              ..userType = "User"
              ..chattingWith = {
                'chattingWith' : "",
                'lastMessage' : "",
                'dateLastMessage' : DateTime.now(),

              }
              ..imageUrl =
                  "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=2000";
            if (_formKey.currentState!.validate()) {

              context.read<AuthProvider>().signUp(passwordController.text, userModel, context);
            }
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
        showItemInterval: Duration(milliseconds: 200),
        showItemDuration: Duration(milliseconds: 750),
        // showItemInterval: Duration(milliseconds: 150),
        // showItemDuration: Duration(milliseconds: 250),
        visibleFraction: 0.001,
        itemCount: itemsCount,
        itemBuilder: animationItemBuilder((index) => icon[index]));
  }
}
