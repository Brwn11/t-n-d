import 'package:flutter/material.dart';
import 'package:touch_n_dine/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBox20(),
            Container(
              decoration: BoxDecoration(
                // color: Colors.black,
                border: Border.all(
                  color: Colors.red,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/logo.jpeg",
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      border: Border.all(
                        color: Colors.red,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/tower.png",
                        ),
                        Image.asset(
                          "assets/images/tower.png",
                        ),
                        Image.asset(
                          "assets/images/tower.png",
                        ),
                        Image.asset(
                          "assets/images/tower.png",
                        ),
                        Image.asset(
                          "assets/images/tower.png",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
