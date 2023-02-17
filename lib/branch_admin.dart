import 'package:flutter/material.dart';
// dart convert
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'get_storage.dart';

TextEditingController _nameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _phoneController = TextEditingController();

Future createNewBranch({
  required name,
  required phone,
  required email,
  required password,
}) async {
  final response = await http.post(
    Uri.parse(
      "http://192.168.1.5:3000/ecommerce/api/branch/",
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, dynamic>{
        "name": name,
        "email": email,
        "created_by": box.read("user_id"),
      },
    ),
  );
  if (response.statusCode == 200) {
    final convertedData = jsonDecode(response.body);
    return convertedData;
  } else {
    throw Exception('Failed to load album');
  }
}

class BranchAdmin extends StatefulWidget {
  const BranchAdmin({super.key});

  @override
  State<BranchAdmin> createState() => _BranchAdminState();
}

class _BranchAdminState extends State<BranchAdmin> {
  // ignore: non_constant_identifier_names
  dynamic branch_response;
  dynamic id;

  Future getBranches() async {
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
    // getBranches();
    super.initState();
    id = box.read("user_id");
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
                return Column(
                  children: [
                    SizedBox(
                      // color: Colors.black,
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: Row(
                        children: [
                          const Text(
                            "Branches",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (_) => newBranchInputDialog(context),
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 30,
                            ),
                          ),
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
                    Expanded(
                      child: GridView.builder(
                        itemCount: snapshot.data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                        ),
                        itemBuilder: (BuildContext context, int i) {
                          return SizedBox(
                            height: 60,
                            width: 60,
                            child: Card(
                              elevation: 10,
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data["branches"][i]["branch_name"],
                                  ),
                                  Text(
                                    snapshot.data["branches"][i]["branch_email"],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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

newBranchInputDialog(context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      backgroundColor: newDesignBackgroundShade,
      content: SizedBox(
        height: MediaQuery.of(context).size.height - 450,
        width: MediaQuery.of(context).size.width - 700,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 100,
          ),
          child: Column(
            children: [
              sizedBox30(),
              SizedBox(
                height: 40,
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  shadowColor: Colors.black,
                  child: TextField(
                    keyboardType: TextInputType.name,
                    controller: _nameController,
                    cursorColor: Colors.red,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      hintText: "Name",
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              sizedBox10(),
              SizedBox(
                height: 40,
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  shadowColor: Colors.black,
                  child: TextField(
                    keyboardType: TextInputType.name,
                    controller: _emailController,
                    cursorColor: Colors.red,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              sizedBox10(),
              SizedBox(
                height: 40,
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  shadowColor: Colors.black,
                  child: TextField(
                    keyboardType: TextInputType.name,
                    controller: _phoneController,
                    cursorColor: Colors.red,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      hintText: "Mobile Number",
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              sizedBox10(),
              SizedBox(
                height: 40,
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  shadowColor: Colors.black,
                  child: TextField(
                    keyboardType: TextInputType.name,
                    controller: _passwordController,
                    cursorColor: Colors.red,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              sizedBox20(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      minimumSize: const Size(150, 40),
                      maximumSize: const Size(150, 40),
                      elevation: 10,
                      backgroundColor: newDesignColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      minimumSize: const Size(150, 40),
                      maximumSize: const Size(150, 40),
                      elevation: 10,
                      backgroundColor: newDesignColor,
                    ),
                    onPressed: () async {
                      // Navigator.pop(context);
                      var res = await createNewBranch(
                        name: _nameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        password: _passwordController.text,
                      );
                      if (res["status"] == true) {
                        // Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const Branches(),
                        //   ),
                        // );
                        logger.e(res);
                      } else {
                        // Navigator.pop(context);
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text(
                        //       res,
                        //     ),
                        //   ),
                        // );
                      }
                    },
                    child: const Text(
                      "Create new Branch",
                      style: TextStyle(
                        fontFamily: "Poppins_Medium",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
