import 'package:flutter/material.dart';

class MyDropDownField extends StatelessWidget {
  final String info;
  final String initialValue;
  final String hintText;
  final String Function(String) validator;
  final Function(String) onChanged;
  final bool isPassword;
  final bool isEmail;
  final bool isPhone;
  final bool isNumeric;
  final bool isRequired;
  final bool isMultiLine;
  final List<DropdownMenuItem> dropDownItems;

  const MyDropDownField({
    Key key,
    @required this.info,
    this.initialValue,
    this.hintText,
    this.validator,
    this.onChanged,
    this.isPassword = false,
    this.isEmail = false,
    this.isPhone = false,
    this.isNumeric = false,
    this.isRequired = false,
    this.isMultiLine = false,
    @required this.dropDownItems,
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
                Text(info, style: TextStyle(fontSize: 12)),
                SizedBox(width: 4),
                Text(
                  isRequired ? "*" : "",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              value: initialValue,
              items: dropDownItems,
              onChanged: (value) => onChanged(value),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
