import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String info;
  final String initialValue;
  final String hintText;
  final String Function(String) validator;
  final Function(String) onSaved;
  final Function onChange;
  final Widget suffixIcon;
  final bool isPassword;
  final bool isEmail;
  final bool isPhone;
  final bool isNumeric;
  final bool isRequired;
  final bool isMultiLine;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onFieldSubmitted;
  final TextInputAction textInputAction;

  const MyTextFormField({
    Key key,
    this.controller,
    @required this.info,
    this.initialValue,
    this.hintText,
    this.validator,
    this.onSaved,
    this.onChange,
    this.suffixIcon,
    this.isPassword = false,
    this.isEmail = false,
    this.isPhone = false,
    this.isNumeric = false,
    this.isRequired = false,
    this.isMultiLine = false,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(info,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(width: 4),
                Text(
                  isRequired ? "*" : "",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: controller,
              initialValue: initialValue != null && controller == null ? initialValue : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.all(15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                fillColor: Colors.blueGrey.shade800,
                suffixIcon: suffixIcon,
              ),
              obscureText: isPassword,
              validator: validator,
              onSaved: onSaved,
              onChanged: onChange,
              keyboardType: isMultiLine
                  ? TextInputType.multiline
                  : isPhone
                      ? TextInputType.phone
                      : isNumeric
                          ? TextInputType.number
                          : isEmail
                              ? TextInputType.emailAddress
                              : TextInputType.text,
              maxLines: isMultiLine && !isPassword ? null : 1,
              minLines: isMultiLine ? 3 : null,
              textInputAction: textInputAction,
              onEditingComplete: onEditingComplete,
              onFieldSubmitted: onFieldSubmitted,
            ),
          ],
        ),
      ),
    );
  }
}
