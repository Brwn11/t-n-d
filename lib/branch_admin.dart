import 'package:flutter/material.dart';
// dart convert
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'get_storage.dart';

class BranchAdmin extends StatefulWidget {
  const BranchAdmin({super.key});

  @override
  State<BranchAdmin> createState() => _BranchAdminState();
}

class _BranchAdminState extends State<BranchAdmin> {
  // ignore: non_constant_identifier_names
  dynamic branch_response;
  dynamic id;

  Future getBranchDetails() async {
    final response = await http.get(
      Uri.parse(
        "http://192.168.1.5:3000/ecommerce/api/branch/$id",
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
    // getBranchDetails();
    super.initState();
    id = box.read("user_id");
    logger.e(id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: getBranchDetails(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                // logger.e("No data recieved ${snapshot.data}");
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      // color: Colors.black,
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: Row(
                        children: [
                          Text(
                            snapshot.data["branches"][0]["branch_name"],
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.person,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      // color: Colors.black,
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: Row(
                        children: [
                          const Text(
                            "Tables",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          // sizedbox width 10
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: () {
                              // showDialog(
                              //   barrierDismissible: false,
                              //   context: context,
                              //   builder: (_) => newBranchInputDialog(context),
                              // );
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 230,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data["branches"][0]["tables"].length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 200,
                            height: 200,
                            child: Card(
                              child: ListTile(
                                title: Text(
                                  snapshot.data["branches"][0]["tables"][index]
                                      ["table_name"],
                                ),
                                subtitle: Text(
                                  snapshot.data["branches"][0]["tables"][index]
                                      ["table_name"],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // const Divider()
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
