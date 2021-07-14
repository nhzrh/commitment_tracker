import 'package:commitment_tracker/components/drop_down_field.dart';
import 'package:commitment_tracker/components/text_form_field.dart';
import 'package:commitment_tracker/helper/dart/utils.dart';
import 'package:commitment_tracker/models/commitments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DetailScreen extends StatefulWidget {
  final Commitment commitment;
  final Function add;
  const DetailScreen({Key key, this.commitment, this.add}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _formKey = GlobalKey<FormState>();
  Commitment _commitment;

  Color currentColor;
  Color pickedColor;

  void changePickedColor(Color color) => setState(() => pickedColor = color);
  void changeColor() {
    setState(() {
      currentColor = pickedColor;
      _commitment.color = currentColor;
    });
  }

  @override
  void initState() {
    _commitment = widget.commitment ?? Commitment();
    currentColor = _commitment.color ?? Colors.white;
    pickedColor = currentColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commitment Details'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                if (_formKey.currentState != null && _formKey.currentState.validate()) {
                  _formKey.currentState?.save();
                  widget.add(_commitment);
                  Navigator.pop(context);
                }
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  MyTextFormField(
                    info: 'Commitment Value',
                    initialValue: _commitment.value.toString(),
                    hintText: '0.0',
                    isRequired: true,
                    isNumeric: true,
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      setState(() {
                        _commitment.value = double.parse(value ?? '0.0');
                      });
                    },
                    validator: (value) {
                      if (value != null && value.isEmpty)
                        return 'Cannot be blank';
                      else
                        return null;
                    },
                  ),
                  MyTextFormField(
                    info: 'Name',
                    initialValue: _commitment.name,
                    hintText: 'e.g. Disney Plus',
                    isRequired: true,
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      setState(() {
                        _commitment.name = value;
                      });
                    },
                    validator: (value) {
                      if (value != null && value.isEmpty)
                        return 'Cannot be blank';
                      else
                        return null;
                    },
                  ),
                  MyTextFormField(
                    info: 'Description',
                    initialValue: _commitment.description,
                    hintText: 'e.g. Premium Plan',
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      setState(() {
                        _commitment.description = value;
                      });
                    },
                  ),
                  MyDropDownField(
                    info: 'Billing Period',
                    initialValue: _commitment.billingPeriod ?? billPeriod[BillingPeriod.monthly],
                    dropDownItems: BillingPeriod.values
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(billPeriod[e]),
                            value: billPeriod[e],
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _commitment.billingPeriod = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            'Color',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            onPressed: () {
                              print('onClick');
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Select a color'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          BlockPicker(
                                            pickerColor: currentColor,
                                            onColorChanged: changePickedColor,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(onPressed: () {}, child: Text('Custom')),
                                              TextButton(
                                                onPressed: () {
                                                  changeColor();
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Select'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              'Choose your Color',
                              style: TextStyle(color: Utils.textColorForBackground(currentColor)),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: currentColor,
                              alignment: Alignment.centerLeft,
                              minimumSize: Size(double.infinity, 50.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), // <-- Radius
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
