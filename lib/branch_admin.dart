import 'package:flutter/material.dart';
// dart convert
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

class BranchAdmin extends StatefulWidget {
  const BranchAdmin({super.key});

  @override
  State<BranchAdmin> createState() => _BranchAdminState();
}

class _BranchAdminState extends State<BranchAdmin> {
  // ignore: non_constant_identifier_names
  dynamic branch_response;
  Future getBranches() async {
    final response = await http.get(
      Uri.parse(
        "http://192.168.1.5:3000/ecommerce/api/branch",
      ),
    );
    if (response.statusCode == 200) {
      final convertedData = jsonDecode(response.body);
      branch_response = convertedData;
      logger.i(convertedData);
      return convertedData;
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // getBranches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: getBranches(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return GridView.builder(
                  itemCount: snapshot.data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemBuilder: (BuildContext context, int i) {
                    return SizedBox(
                      height: 100,
                      width: 100,
                      child: Card(
                        child: Text(
                          snapshot.data["branches"][i]["name"],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
