import 'package:flutter/material.dart';

import 'constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                    child: const TextField(
                      keyboardType: TextInputType.name,
                      // controller: _mobileNumberController,
                      cursorColor: Colors.red,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
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
                    child: const TextField(
                      keyboardType: TextInputType.name,
                      // controller: _passwordController,
                      cursorColor: Colors.red,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
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
                  onPressed: () async {},
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
