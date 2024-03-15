import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import 'package:gap/gap.dart';

import '../../../../../constants/text_string.dart';

class UpdateRecordScreen extends StatefulWidget {
  final String customerKey;
  final String measurementKey;
  final Map<String, dynamic> measurement;

  const UpdateRecordScreen({
    required this.customerKey,
    required this.measurementKey,
    required this.measurement,
  });

  @override
  _UpdateRecordScreenState createState() => _UpdateRecordScreenState();
}

class _UpdateRecordScreenState extends State<UpdateRecordScreen> {
  final RegExp numberRegex = RegExp(r'^[0-9]+$');
  TextEditingController customerNameController = TextEditingController();
  TextEditingController _chestController = TextEditingController();
  TextEditingController _waistController = TextEditingController();
  TextEditingController _shoulderController = TextEditingController();
  TextEditingController _hipController = TextEditingController();
  TextEditingController _inseamController = TextEditingController();
  TextEditingController _neckController = TextEditingController();
  TextEditingController _sleeveController = TextEditingController();
  TextEditingController _frontController = TextEditingController();
  TextEditingController _thighController = TextEditingController();
  TextEditingController _kneeController = TextEditingController();
  TextEditingController _pantslController = TextEditingController();
  TextEditingController _lengthController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _other1Controller = TextEditingController();
  TextEditingController _other2Controller = TextEditingController();
  TextEditingController _other3Controller = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  late DatabaseReference measurementRef;

  @override
  void initState() {
    measurementRef = FirebaseDatabase.instance
        .reference()
        .child('customer')
        .child(widget.customerKey)
        .child('measurements')
        .child(widget.measurementKey);
    super.initState();
    loadMeasurement();
  }

  void loadMeasurement() {
    if (widget.measurement != null) {
      String name = widget.measurement['Name'] as String? ?? '';
      String chest = widget.measurement['customerChest'] as String? ?? '';
      String note = widget.measurement['customerNote'] as String? ?? '';
      String waist = widget.measurement['customerWaist'] as String? ?? '';
      String shoulder = widget.measurement['customerShoulder'] as String? ?? '';
      String hip = widget.measurement['customerHip'] as String? ?? '';
      String inseam = widget.measurement['customerInseam'] as String? ?? '';
      String neck = widget.measurement['customerNeck'] as String? ?? '';
      String sleeve = widget.measurement['customerSleeve'] as String? ?? '';
      String front = widget.measurement['customerFront'] as String? ?? '';
      String thigh = widget.measurement['customerThigh'] as String? ?? '';
      String knee = widget.measurement['customerKnee'] as String? ?? '';
      String pants = widget.measurement['customerPants'] as String? ?? '';
      String length = widget.measurement['customerLength'] as String? ?? '';
      String other1 = widget.measurement['customerOther1'] as String? ?? '';
      String other2 = widget.measurement['customerOther2'] as String? ?? '';
      String other3 = widget.measurement['customerOther3'] as String? ?? '';
      String clothAmount = widget.measurement['clothAmount'] as String? ?? '';

      setState(() {
        customerNameController.text = name;
        _chestController.text = chest;
        _noteController.text = note;
        _waistController.text = waist;
        _shoulderController.text = shoulder;
        _hipController.text = hip;
        _inseamController.text = inseam;
        _neckController.text = neck;
        _sleeveController.text = sleeve;
        _frontController.text = front;
        _thighController.text = thigh;
        _kneeController.text = knee;
        _pantslController.text = pants;
        _lengthController.text = length;
        _other1Controller.text = other1;
        _other2Controller.text = other2;
        _other3Controller.text = other3;
        _amountController.text = clothAmount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Measurement"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 15),


          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                maxLength: 12,
                controller: customerNameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.name,
                  labelStyle: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: 16),

                ),
              ),
              Gap(15),
              TextFormField(

                controller: _amountController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(numberRegex),
                ],
                keyboardType: TextInputType.phone,
                maxLength: 9,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.requiredField;
                  }
                  if (!numberRegex.hasMatch(value)) {
                    return AppLocalizations.of(context)!.formValidator;
                  }
                  return null;
                },
                decoration: InputDecoration(

                  labelText: AppLocalizations.of(context)!.cloth,
                  labelStyle: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: 16),

                ),

              ),
              Container(height: 2,color: Colors.blue,),
              Gap(20),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _waistController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(numberRegex),
                        ],
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.shoulder,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(numberRegex),
                        ],
                        maxLength: 4,
                        controller: _hipController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.chest,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(numberRegex),
                        ],
                        controller: _shoulderController,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.skirt,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(numberRegex),
                        ],
                        controller: _inseamController,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.sleeve,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(numberRegex),
                        ],
                        controller: _chestController,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.length,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(numberRegex),
                        ],
                        controller: _neckController,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.collar,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(numberRegex),
                        ],
                        maxLength: 4,
                        controller: _sleeveController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.button,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(numberRegex),
                        ],
                        controller: _frontController,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.hip,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(numberRegex),
                        ],
                        controller: _thighController,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.inseam,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(numberRegex),
                        ],
                        maxLength: 4,
                        controller: _kneeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.knee,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(numberRegex),
                        ],
                        controller: _pantslController,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.thigh,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child:TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(numberRegex),
                        ],
                        controller: _lengthController,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.waist,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [Expanded(
                    flex: 1,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            numberRegex), // Only allows input that matches the regular expression
                      ],
                      maxLength: 4,
                      controller: _other1Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.other1,
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            numberRegex), // Only allows input that matches the regular expression
                      ],
                      controller: _other2Controller,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.other2,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            numberRegex), // Only allows input that matches the regular expression
                      ],
                      controller: _other3Controller,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.other3,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),],),
              ],
            ),
              Gap(20),
              SizedBox(
                width: double.infinity,
                child:ElevatedButton(
                  onPressed: () {
                    if (widget.measurement != null) {
                      Map<String, dynamic> updatedMeasurement = {
                        'Name': customerNameController.text,
                        "customerChest": _chestController.text,
                        "customerWaist": _waistController.text,
                        "customerShoulder": _shoulderController.text,
                        "customerHip": _hipController.text,
                        "customerInseam": _inseamController.text,
                        "customerNeck": _neckController.text,
                        "customerSleeve": _sleeveController.text,
                        "customerFront": _frontController.text,
                        "customerThigh": _thighController.text,
                        "customerKnee": _kneeController.text,
                        "customerPants": _pantslController.text,
                        "customerLength": _lengthController.text,
                        "customerNote": _noteController.text,
                        "customerOther1": _other1Controller.text,
                        "customerOther2": _other2Controller.text,
                        "customerOther3": _other3Controller.text,
                        "clothAmount": _amountController.text,
                      };

                      measurementRef.update(updatedMeasurement).then((value) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Update Successful'),
                              content: Text('Measurement updated successfully.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                    Navigator.of(context).pop(); // Close the update screen
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }).catchError((error) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Failed to update measurement: $error'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      });
                    } else {
                      print("Invalid measurement data");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  child: Text(
                    'Update',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
