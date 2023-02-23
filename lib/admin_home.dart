import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// import 'branch_admin.dart';
import 'constants.dart';


class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

TextEditingController _branchNameController = TextEditingController();
TextEditingController _branchEmailController = TextEditingController();
TextEditingController _branchAdminNameController = TextEditingController();
TextEditingController _branchAdminEmailController = TextEditingController();
TextEditingController _branchAdminPhoneController = TextEditingController();
TextEditingController _branchAdminPasswordController = TextEditingController();

Future createNewBranch({
  required branchName,
  required branchEmail,
  required branchAdminName,
  required branchAdminEmail,
  required branchAdminPhone,
  required branchAdminPassword,
}) async {
  final response = await http.post(
    Uri.parse(
      "http://192.168.1.53000/ecommerce/api/branch/",
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, dynamic>{
        "branch_name": branchName,
        "branch_email": branchEmail,
        "branch_admin_name": branchAdminName,
        "branch_admin_email": branchAdminEmail,
        "branch_admin_phone": branchAdminPhone,
        "branch_admin_password": branchAdminPassword,
        // "created_by": box.read("user_id"),
        "created_by": "63d0266857009af621fdff0e",
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

class _AdminHomePageState extends State<AdminHomePage> {
  dynamic branchResponse;
  dynamic id;

  Future getBranches() async {
    final response = await http.get(
      Uri.parse(
        // "http://192.168.1.5:3000/ecommerce/api/branch/$id",
        "http://192.168.1.5:3000/ecommerce/api/branch_admin/63d0266857009af621fdff0e",
      ),
    );
    if (response.statusCode == 200) {
      final convertedData = jsonDecode(response.body);
      branchResponse = convertedData;
      logger.i(convertedData);
      return convertedData;
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    id = GetStorage().read("user_id");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Home Page"),
      ),
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
                  sizedBox10(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: snapshot.data["branches"].length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 200,
                          height: 200,
                          child: Card(
                            child: ListTile(
                              title: Text(
                                snapshot.data["branches"][index]["branch_name"],
                              ),
                              subtitle: Text(
                                snapshot.data["branches"][index]
                                    ["branch_email"],
                              ),
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
    );
  }
}

double textFieldSizedBoxHeight = 40;
double textFieldSizedBoxWidth = 190;
Size elevatedButtonSize = const Size(150, 40);

newBranchInputDialog(context) {
  // Future createNewBranch({
  //   required branch_name,
  //   required branch_email,
  //   required branch_admin_name,
  //   required branch_admin_email,
  //   required branch_admin_phone,
  //   required branch_admin_password,
  // }) async {
  //   final response = await http.post(
  //     Uri.parse(
  //       "http://192.168.1.5:3000/ecommerce/api/branch/",
  //     ),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(
  //       <String, dynamic>{
  //         "branch_name": branch_name,
  //         "branch_email": branch_email,
  //         "branch_admin_name": branch_admin_name,
  //         "branch_admin_email": branch_admin_email,
  //         "branch_admin_phone": branch_admin_password,
  //         "branch_admin_password": branch_admin_password,
  //         "created_by": box.read("user_id"),
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     final convertedData = jsonDecode(response.body);
  //     return convertedData;
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  return AlertDialog(
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
          horizontal: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    sizedBox30(),
                    SizedBox(
                      height: 40,
                      width: textFieldSizedBoxWidth,
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        shadowColor: Colors.black,
                        child: TextField(
                          keyboardType: TextInputType.name,
                          controller: _branchNameController,
                          cursorColor: Colors.red,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            hintText: "Branch Name",
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
                      height: textFieldSizedBoxHeight,
                      width: textFieldSizedBoxWidth,
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        shadowColor: Colors.black,
                        child: TextField(
                          keyboardType: TextInputType.name,
                          controller: _branchEmailController,
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
                    // sizedBox10(),
                    // SizedBox(
                    //   height: textFieldSizedBoxHeight,
                    //   width: textFieldSizedBoxWidth,
                    //   child: Material(
                    //     elevation: 10,
                    //     borderRadius: BorderRadius.circular(
                    //       10,
                    //     ),
                    //     shadowColor: Colors.black,
                    //     child: TextField(
                    //       keyboardType: TextInputType.name,
                    //       controller: _phoneController,
                    //       cursorColor: Colors.red,
                    //       textAlignVertical: TextAlignVertical.center,
                    //       decoration: const InputDecoration(
                    //         prefixIcon: Icon(
                    //           Icons.person,
                    //           color: Colors.grey,
                    //         ),
                    //         hintText: "Mobile Number",
                    //         hintStyle: TextStyle(
                    //           fontSize: 15,
                    //           color: Colors.grey,
                    //         ),
                    //         border: InputBorder.none,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // sizedBox10(),
                    // SizedBox(
                    //   height: textFieldSizedBoxHeight,
                    //   width: textFieldSizedBoxWidth,
                    //   child: Material(
                    //     elevation: 10,
                    //     borderRadius: BorderRadius.circular(
                    //       10,
                    //     ),
                    //     shadowColor: Colors.black,
                    //     child: TextField(
                    //       keyboardType: TextInputType.name,
                    //       controller: _passwordController,
                    //       cursorColor: Colors.red,
                    //       textAlignVertical: TextAlignVertical.center,
                    //       decoration: const InputDecoration(
                    //         prefixIcon: Icon(
                    //           Icons.person,
                    //           color: Colors.grey,
                    //         ),
                    //         hintText: "Password",
                    //         hintStyle: TextStyle(
                    //           fontSize: 15,
                    //           color: Colors.grey,
                    //         ),
                    //         border: InputBorder.none,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // sizedBox20(),
                  ],
                ),
                Column(
                  children: [
                    sizedBox30(),
                    SizedBox(
                      height: textFieldSizedBoxHeight,
                      width: textFieldSizedBoxWidth,
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        shadowColor: Colors.black,
                        child: TextField(
                          keyboardType: TextInputType.name,
                          controller: _branchAdminNameController,
                          cursorColor: Colors.red,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            hintText: "BAdmin Name",
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
                      height: textFieldSizedBoxHeight,
                      width: textFieldSizedBoxWidth,
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        shadowColor: Colors.black,
                        child: TextField(
                          keyboardType: TextInputType.name,
                          controller: _branchAdminEmailController,
                          cursorColor: Colors.red,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            hintText: "BAdmin Email",
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
                      height: textFieldSizedBoxHeight,
                      width: textFieldSizedBoxWidth,
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        shadowColor: Colors.black,
                        child: TextField(
                          keyboardType: TextInputType.name,
                          controller: _branchAdminPhoneController,
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
                      height: textFieldSizedBoxHeight,
                      width: textFieldSizedBoxWidth,
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        shadowColor: Colors.black,
                        child: TextField(
                          keyboardType: TextInputType.name,
                          controller: _branchAdminPasswordController,
                          cursorColor: Colors.red,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            hintText: "BAdmin Password",
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
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    minimumSize: elevatedButtonSize,
                    maximumSize: elevatedButtonSize,
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
                const SizedBox(
                  width: 20,
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
                    minimumSize: elevatedButtonSize,
                    maximumSize: elevatedButtonSize,
                    elevation: 10,
                    backgroundColor: newDesignColor,
                  ),
                  onPressed: () async {
                    // Navigator.pop(context);
                    var res = await createNewBranch(
                      branchName: _branchNameController.text,
                      branchEmail: _branchEmailController.text.trim(),
                      branchAdminName: _branchAdminNameController.text,
                      branchAdminEmail: _branchAdminEmailController.text.trim(),
                      branchAdminPhone: _branchAdminPhoneController.text.trim(),
                      branchAdminPassword: _branchAdminPasswordController.text,
                    );
                    if (res["status"] == true) {
                      Navigator.pop(context);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const Branches(),
                      //   ),
                      // );
                      logger.e(res);
                    } else {
                      logger.e(res);
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
}
