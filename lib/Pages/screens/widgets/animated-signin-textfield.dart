import 'package:auto_animated/auto_animated.dart';

import 'package:flutter/material.dart';
import 'package:good_chat_app/Pages/screens/widgets/rectangular_button.dart';
import 'package:good_chat_app/Pages/screens/widgets/rectangular_input_field.dart';
import 'package:good_chat_app/Pages/screens/widgets/utils.dart';

import '../../constants/constants.dart';

import '../sign_in/components/head_text.dart';
import '../sign_up/components/social.dart';


class AnimateSignInFields extends StatefulWidget {
  const AnimateSignInFields({Key? key}) : super(key: key);

  @override
  _AnimateSignInFieldsState createState() => _AnimateSignInFieldsState();
}

class _AnimateSignInFieldsState extends State<AnimateSignInFields> {
  int itemsCount = 0;
  List<Widget> icon = [];


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
              controller: emailController,
              textInputType: TextInputType.emailAddress,
              hintText: 'Email',
              icon: Icons.email_rounded,
              obscureText: false,
              validator: (value){
                if (value!.isEmpty) {
                  return ("Email is required");
                }
              },
            ),
            RectangularInputField(
              controller: passwordController,
              textInputType: TextInputType.text,
              hintText: 'Password',
              icon: Icons.lock,
              obscureText: true,
              validator: (value){
                if (value!.isEmpty) {
                  return ("Pasword is required");
                }
              },
            ),

          ],
        ),
      ),



      SizedBox(height: 60,),
      RectangularButton(text: 'Sign In', press: (){
        if (_formKey.currentState!.validate()) {}
      }),
      SizedBox(
        height: appPadding / 2,
      ),
      Center(
        child: Text(
          'Forget Password?',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 17,
          ),
        ),
      ),
      SizedBox(height: 80,),
      Social(),

    ];

    itemsCount = icon.length;

    Future.delayed(Duration(milliseconds: 1000) * 5, () {
      if (!mounted) {
        return;
      }
      setState(() {
        if (icon.length > itemsCount) {
          itemsCount += 7;
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
