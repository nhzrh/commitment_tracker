import 'package:commitment_tracker/common/components/drop_down_field.dart';
import 'package:commitment_tracker/common/components/text_form_field.dart';
import 'package:commitment_tracker/common/utils/utils.dart';
import 'package:commitment_tracker/models/commitments.dart';
import 'package:commitment_tracker/services/boxes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:validators/validators.dart' as validator;

class DetailScreen extends StatefulWidget {
  final Commitment commitment;
  const DetailScreen({Key key, this.commitment}) : super(key: key);

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
      _commitment.color = currentColor.value;
    });
  }

  @override
  void initState() {
    _commitment = widget.commitment ?? Commitment();
    currentColor = _commitment.color.toColor ?? Colors.white;
    pickedColor = currentColor;
    super.initState();
  }

  void addCommitment(Commitment data) {
    if (widget.commitment == null) {
      final box = Boxes.getCommitments();
      data.createdAt = DateTime.now();
      box.add(data);
    } else
      data.save();
  }

  void blockPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isCustom = false;
        return AlertDialog(
          title: Text('Select a color'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    isCustom
                        ? ColorPicker(
                            pickerColor: currentColor,
                            onColorChanged: changePickedColor,
                            colorPickerWidth: 300.0,
                            pickerAreaHeightPercent: 0.7,
                            enableAlpha: true,
                            displayThumbColor: true,
                            showLabel: true,
                            paletteType: PaletteType.hsv,
                            pickerAreaBorderRadius: const BorderRadius.only(
                              topLeft: const Radius.circular(2.0),
                              topRight: const Radius.circular(2.0),
                            ),
                          )
                        : BlockPicker(
                            pickerColor: currentColor,
                            onColorChanged: changePickedColor,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() => isCustom = !isCustom);
                            },
                            child: Text(isCustom ? 'Back' : 'Custom')),
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
              );
            },
          ),
        );
      },
    );
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
                  addCommitment(_commitment);
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Column(
                children: [
                  MyTextFormField(
                    info: 'Commitment Value',
                    initialValue: _commitment.value != null ? _commitment.value.toString() : null,
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
                      if (value != null && value.isEmpty) {
                        return 'Cannot be blank';
                      } else if (value != null && value.isNotEmpty && !validator.isFloat(value)) {
                        return "Please enter a valid value";
                      }
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
                  Visibility(
                    visible: false,
                    child: MyDropDownField(
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
                            onPressed: () => blockPicker(),
                            child: Text(
                              'Choose your Color',
                              style: TextStyle(color: currentColor.textColorForBackground),
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
                  ),
                  MyTextFormField(
                    info: 'Notes',
                    initialValue: _commitment.notes,
                    hintText: 'e.g. Share with friends and family',
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      setState(() {
                        _commitment.notes = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
