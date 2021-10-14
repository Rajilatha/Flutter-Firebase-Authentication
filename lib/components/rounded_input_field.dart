import 'package:covid/components/text_field_container.dart';
import 'package:covid/constants.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  // final IconData icon;
  final ValueChanged<String> onChanged;
  final Function(String) onSubmit;
// final FocusNode focusNode;
final TextInputAction textInputAction; 

  const RoundedInputField({ Key? key, required this.hintText,  required this.onChanged, required this.onSubmit,  required this.textInputAction, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     // ignore: unused_local_variable
    //  bool _isPasswordField = isPasswordField;
    return TextFieldContainer(
      child: TextField(
        // obscureText: _isPasswordField,
        // focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmit,
         textInputAction: textInputAction,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          // icon: Icon(
          //   icon,
          //   color: kPrimaryColor,
          // ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}