import 'package:covid/components/already_have_an_account_acheck.dart';
import 'package:covid/components/rounded_button.dart';
import 'package:covid/components/rounded_input_field.dart';
import 'package:covid/components/rounded_password_field.dart';
import 'package:covid/constants.dart';
import 'package:covid/screen/login/components/background.dart';
import 'package:covid/screen/signup/signup_screen.dart';
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
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            // ignore: avoid_unnecessary_containers
            content: Container(
              child: Text(error),
            ),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                child: const Text("Close Dialog"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }

  // Create a new user account
  // ignore: unused_element
  Future<String?> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
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

 // ignore: unused_element
 void _submitForm() async {
    // Set the form to loading state
    setState(() {
      _loginFormLoading = true;
    });

    // Run the create account method
    String? _loginFeedback = await _loginAccount();

    // If the string is not null, we got error while create account.
    if(_loginFeedback != null) {
      _alertDialogBuilder(_loginFeedback);

      // Set the form to regular state [not loading].
      setState(() {
        _loginFormLoading = false;
      });
    } else {
      // The String was null, user is logged in.
      Navigator.pop(context);
    }
  }

   // ignore: prefer_final_fields, unused_field
   bool _loginFormLoading = false;

  // Form Input Field Values
  // ignore: unused_field
  late String _loginEmail = "";
  // ignore: prefer_final_fields, unused_field
  late String _loginPassword = "";

  // Focus Node for input fields
  // ignore: unused_field
  late FocusNode _passwordFocusNode;

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
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                      _loginEmail = value;
                    },
                    onSubmit: (value) {
                      _passwordFocusNode.requestFocus();
                    },
              textInputAction: TextInputAction.next, 
               
               // ignore: prefer_const_constructors
              //  prefixIcon: Icon(
              //                     Icons.email,
              //                     color: Colors.black,
              //  ),
                // validator: (value ) {  }, 
            ),
            RoundedPasswordField(
              focusNode: _passwordFocusNode, 
                onChanged: (value) { 
                   _loginPassword = value;
                 }, 
                onSubmit: (value) {
                  _submitForm();
                  }, 
                  // validator: (value) {  }, 
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                _submitForm();
              }, 
              color: kPrimaryLightColor, 
              textColor: Colors.black, 
              isLoading: _loginFormLoading,
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUpScreen();
                    },
                  ),
                );
              }, login: true,
            ),
          ],
        ),
      ),
    );
  }
}