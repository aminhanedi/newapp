import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import '../../../../../constants/text_string.dart';

class AddMeasurementScreen extends StatefulWidget {
  final String customerKey;

  const AddMeasurementScreen({required this.customerKey});

  @override
  _AddMeasurementScreenState createState() => _AddMeasurementScreenState();
}

class _AddMeasurementScreenState extends State<AddMeasurementScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
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


  final RegExp numberRegex = RegExp(r'^[0-9]+$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Add Measurement"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gap(20),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _nameController,
                            maxLength: 20,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.requiredField;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person,color: Colors.blue,size:30,),
                              labelText: AppLocalizations.of(context)!.customerName,
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
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(

                          controller: _amountController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(numberRegex),
                          ],
                          keyboardType: TextInputType.phone,
                          maxLength: 4,
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
                            prefixIcon: Icon(Icons.monetization_on,color: Colors.blue,size:25,),

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
                      ]),
                ),
                Gap(15),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  color: Colors.white38,
                  width: double.infinity,
                  child: TextFormField(
                  maxLines: 3,
                    controller: _noteController,
                    decoration: InputDecoration(
                        label: Text(
                          AppLocalizations.of(context)!.note,
                          style:
                          TextStyle(fontSize: 18, color: Colors.blueAccent),
                        ),
                        prefixIcon: Icon(Icons.note_alt,
                            size: 50,
                            shadows: [
                              Shadow(color: Colors.green),
                              Shadow(offset: Offset(2, 5))
                            ],
                            color: Colors.yellow),
                        border: OutlineInputBorder()),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:20,left: 10,right: 10,bottom: 20),
                  padding: EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  //--------------------------------------save btn---------------------------------------//
                  child: ElevatedButton(
                    onPressed: () {
                if (_formKey.currentState!.validate()) {
                saveMeasurementData();
                }
                },// Call _submitForm when the button is pressed
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side:
                        BorderSide(color: Colors.white), // Add white border
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.save,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  void saveMeasurementData() async {
    if (_formKey.currentState!.validate()) {
      double shoulder = double.parse(_shoulderController.text);
      double chest = double.parse(_chestController.text);
      double waist = double.parse(_waistController.text);
      double hip = double.parse(_hipController.text);

      DatabaseReference measurementRef = FirebaseDatabase.instance
          .ref()
          .child("customer")
          .child(widget.customerKey)
          .child("measurements")
          .push();

      try {
        await measurementRef.set({
          "timestamp": ServerValue.timestamp,
          "customerChest": chest.toString(),
          "customerWaist": waist.toString(),
          "customerShoulder": shoulder.toString(),
          "customerHip": hip.toString(),
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
          "Name": _nameController.text,
        });

        Navigator.pop(context);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text( AppLocalizations.of(context)!.successfullyAlert,),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } catch (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Failed to save measurement data."),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
}