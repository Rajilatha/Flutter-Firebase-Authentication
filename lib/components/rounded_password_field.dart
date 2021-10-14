import 'package:covid/components/text_field_container.dart';
import 'package:covid/constants.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final Function(String) onSubmit;
final FocusNode focusNode;
// final TextInputAction textInputAction; 
//  final bool isPasswordField;
  const RoundedPasswordField({ Key? key, required this.onChanged, required this.onSubmit, required this.focusNode, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        // obscureText: _isPasswordField,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmit,
        //  textInputAction: textInputAction,
        cursorColor: kPrimaryColor,
        decoration: const InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}