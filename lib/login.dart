import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'get_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Future loginApi({
    required email,
    required password,
  }) async {
    final response = await http.post(
      Uri.parse(
        "http://192.168.1.5:3000/ecommerce/api/auth/",
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          "email": "brown@gmail.com",
          "password": "1234",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 2 - 200,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                sizedBox20(),
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
                        hintText: 'Mobile Number / Login Id',
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
                          Icons.mail,
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
                sizedBox10(),
                Row(
                  children: [
                    // Checkbox(
                    //   value: value,
                    //   onChanged: (value) {
                    //     setState(
                    //       () {
                    //         this.value = value!;
                    //       },
                    //     );
                    //   },
                    // ),
                    const Text(
                      "Remember Me",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
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
                    minimumSize: Size(
                      MediaQuery.of(context).size.width - 20,
                      40,
                    ),
                    elevation: 10,
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () async {
                    var response = await loginApi(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
                    logger.i(response);
                    if (response["status"] = true) {
                      box.write("position", response["position"]);
                      box.write("user_name", response["user"]["name"]);
                      box.write("user_email", response["user"]["email"]);
                      box.write("user_id", response["user"]["_id"]);

                      if (response["position"] == "AD") {
                        Get.offNamed("/admin_home");
                      } else if (response["position"] == "BA") {
                        Get.offNamed("/branch_admin");
                      } else if (response["position"] == "RA") {
                      } else {
                        logger.i("error");
                      }
                    } else {
                      logger.i("error");
                    }
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.golf_course,
                        color: Colors.red,
                      ),
                    ),
                    const Text(
                      "Sign in with Google",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account ?",
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        " Sign Up",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//   @override
//   dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
// }
