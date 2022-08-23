import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:good_chat_app/Pages/home.dart';
import 'package:good_chat_app/Pages/screens/sign_in/sigin_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../Router/navigate-route.dart';
import '../../Theme/color-theme.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  User? user;
  String verificationID = "";


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        // decoration:  BoxDecoration(
        //   color: MyTheme.bg,
        //   image: DecorationImage(
        //     image: AssetImage("image/map.png"),
        //     fit: BoxFit.cover,
        //   ),
        // ),

        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              IntlPhoneField(
                cursorColor: MyTheme.logoColor,
                decoration:  InputDecoration(
                  fillColor: Colors.white,
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide:  BorderSide(color: MyTheme.logoColor, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'PH',
                onChanged: (phone) {

                  phoneController.text = phone.completeNumber;
                  print(phone.completeNumber);
                },
              ),

              Visibility(
                visible: otpVisibility,
                child: TextField(
                  controller: otpController,
                  decoration: const InputDecoration(
                    hintText: 'OTP',
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(''),
                    ),
                  ),
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              ElevatedButton(onPressed: (){
                if (otpVisibility) {
                  verifyOTP();
                } else {
                  loginWithPhone();
                }
                print(phoneController.text);
              }, child: const Text("Login",style: TextStyle(fontSize: 18),)),
              const SizedBox(
                height: 10,
              ),

              ElevatedButton(onPressed: (){
                NavigateRoute.gotoPage(context, SignInScreen());
              }, child: const Text("Register",style: TextStyle(fontSize: 18),)),

              TextButton(onPressed: (){}, child: const Text("Forgot Password?",style: TextStyle(color: Colors.black),)),

              MaterialButton(
                color: Colors.indigo[900],
                onPressed: () {
                  NavigateRoute.gotoPage(context, Home());
                },
                child: Text(
                  otpVisibility ? "Verify" : "Go To Home",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      // phoneNumber: "+63" + phoneController.text,
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then(
          (value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
      },
    ).whenComplete(
          () {
        if (user != null) {
          Fluttertoast.showToast(
            msg: "You are logged in successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: "your login is failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
    );
  }
}