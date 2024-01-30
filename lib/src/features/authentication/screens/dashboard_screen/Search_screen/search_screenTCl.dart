import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  DatabaseReference customersRef =
  FirebaseDatabase.instance.ref().child('customer');

  List<Map<dynamic, dynamic>> customerList = [];

  void filterCustomers(String searchTerm) {
    setState(() {
      if (searchTerm.isEmpty) {
        customerList.clear();
      } else {
        customerList = customerList.where((customer) {
          String customerName = customer['customerName'] ?? '';
          String customerID = customer['customerID'] ?? '';
          String customerPhone = customer['customerPhone'] ?? '';
          return customerName.toLowerCase().contains(searchTerm.toLowerCase()) ||
              customerPhone.toLowerCase().contains(searchTerm.toLowerCase()) ||
              customerID.toLowerCase().contains(searchTerm.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }
  @override
  void dispose() {
    searchController.dispose(); // Dispose the TextEditingController
    super.dispose();
  }

  void fetchCustomers() async {
    try {
      DatabaseEvent event = await customersRef.once();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> values = event.snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, item) {
          setState(() {
            customerList.add(item);
          });
        });
      }
    } catch (error) {
      print("Error fetching customers: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: filterCustomers,
                decoration: InputDecoration(
                  labelText: "SEARCH",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: customerList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(customerList[index]['customerName']),
                    trailing: Text(customerList[index]['customerPhone']),
                    leading: Text(customerList[index]['customerID']),
                    subtitle: Text(customerList[index]['customerOrder']),



                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}