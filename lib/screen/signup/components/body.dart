
import 'package:covid/components/already_have_an_account_acheck.dart';
import 'package:covid/components/rounded_button.dart';
import 'package:covid/components/rounded_input_field.dart';
import 'package:covid/components/rounded_password_field.dart';
import 'package:covid/constants.dart';
import 'package:covid/screen/login/login_screen.dart';
import 'package:covid/screen/signup/components/background.dart';
import 'package:covid/screen/signup/components/or_divider.dart';
import 'package:covid/screen/signup/components/social_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  // ignore: unused_element
  Future<void> _alertDialogBuilder(String error) async{
    return showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title:const Text("Error"),
          // ignore: avoid_unnecessary_containers
          content: Container(
            child: Text(error),
          ),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              child: const Text("Close Dialog"))
          ],
        );
      }
      );
  }

  // ignore: unused_element
  Future<String?> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

   void _submitForm() async {
    // Set the form to loading state
    setState(() {
      _registerFormLoading = true;
    });

    // Run the create account method
    String? _createAccountFeedback = await _createAccount();

    // If the string is not null, we got error while create account.
    if(_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);

      // Set the form to regular state [not loading].
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      // The String was null, user is logged in.
     Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
    }
  }

// ignore: prefer_final_fields, unused_field
late bool _registerFormLoading = false;

  // ignore: prefer_final_fields
  late String _registerEmail= "";

// ignore: prefer_final_fields
late String _registerPassword= "";
 // ignore: unused_field
 late FocusNode _passwordFocusNode;

 // ignore: unused_field
 final _auth = FirebaseAuth.instance;

 @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                _registerEmail = value;
              }, 
              // focusNode: _passwordFocusNode, 
              // isPasswordField: true, 
              onSubmit: (value) {
                    _passwordFocusNode.requestFocus();
                    }, 
              textInputAction: TextInputAction.next,  
              
            ),
            RoundedPasswordField(
              focusNode:_passwordFocusNode, 
              onChanged: (value) {
                  _registerPassword = value;
                  }, onSubmit: (value) { 
                    _submitForm();
                   },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                 _submitForm();
              }, 
              color: kPrimaryLightColor, 
              textColor: Colors.black, 
              isLoading: _registerFormLoading, 
              
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            ),
            const OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}