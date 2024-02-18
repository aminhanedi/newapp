import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';


class MeasurementScreen extends StatelessWidget {
  final Map<String, dynamic>? measurementData;

  MeasurementScreen({required this.measurementData});

  @override
  Widget build(BuildContext context) {
    if (measurementData == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("MEASUREMENT"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    Map<String, dynamic> customers = measurementData!['customers'] ?? {};
    Map<String, dynamic> measurement = measurementData!['measurement'] ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text("MEASUREMENT"),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.amberAccent,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: Colors.amberAccent,
                  thickness: 1.0,
                  height: 20.0,
                ),
                Wrap(
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(
                        '${AppLocalizations.of(context)!.shoulder} ${measurement["customerChest"] ?? ""}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: Text(
                        '${AppLocalizations.of(context)!.chest} ${measurement["customerFront"] ?? ""}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: Text(
                        '${AppLocalizations.of(context)!.skirt} ${measurement["customerNeck"] ?? ""}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(5),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.amberAccent,
                      width: 1,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      '${AppLocalizations.of(context)!.note} ${measurement["customerNote"] ?? ""}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}