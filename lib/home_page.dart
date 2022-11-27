import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart' show BoxDecoration, BoxShadow;
import 'package:touch_n_dine/constants.dart';
import "package:logger/logger.dart";
import "package:http/http.dart" as http;

Logger logger = Logger();
String _coffeeUrl = "http://10.0.2.2:3000/ecommerce/api/coffee/";
String _itemsUrl = "http://10.0.2.2:3000/ecommerce/api/items/";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic coffeeResponse;
  dynamic itemsResponse;
  bool checkboxValue = false;
  int selectedCategoryIndex = 0;
  int selectedItemIndex = 1;
  Future getItemsApi() async {
    final response = await http.get(
      Uri.parse(_itemsUrl),
    );
    if (response.statusCode == 200) {
      logger.i(response.body);
      var convertedDataJson = jsonDecode(response.body);
      logger.i(convertedDataJson);
      itemsResponse = convertedDataJson;
      return convertedDataJson;
    }
  }

  Future getCoffeeApi() async {
    final response = await http.get(
      Uri.parse(_coffeeUrl),
    );
    if (response.statusCode == 200) {
      logger.i(response.body);
      var convertedDataJson = jsonDecode(response.body);
      logger.i(convertedDataJson);
      coffeeResponse = convertedDataJson;
      return convertedDataJson;
    }
  }

  getApis() async {
    var res = await getCoffeeApi();
    await getItemsApi();
    return res;
  }

  @override
  void initState() {
    super.initState();
    // getCoffee();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: getApis(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              logger.e("Snapshot Has No Data");
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const CupertinoActivityIndicator(),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedBox20(),
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.black,
                      border: Border.all(
                        color: Colors.black,
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
                              color: Colors.black,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: itemsResponse.length,
                                itemBuilder: (context, i) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedItemIndex =
                                            itemsResponse[i]["index"];
                                      });
                                      logger.i(selectedItemIndex);
                                    },
                                    child: Card(
                                      color: selectedItemIndex ==
                                              itemsResponse[i]["index"]
                                          ? Colors.red
                                          : Colors.green,
                                      elevation: selectedItemIndex ==
                                              itemsResponse[i]["index"]
                                          ? 20
                                          : 10,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: selectedItemIndex ==
                                                  itemsResponse[i]["index"]
                                              ? 16.0
                                              : 6.0,
                                          // vertical: selectedItemIndex ==
                                          //         itemsResponse[i]["index"]
                                          //     ? 16.0
                                          //     : 6.0,
                                        ),
                                        child: Image.asset(
                                          "assets/images/coffee.png",
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     setState(() {
                              //       selectedCategoryIndex = 0;
                              //     });
                              //     logger.i(selectedCategoryIndex);
                              //   },
                              //   child: Card(
                              //     elevation:
                              //         selectedCategoryIndex == 0 ? 20 : 10,
                              //     child: Padding(
                              //       padding: EdgeInsets.all(
                              //           selectedCategoryIndex == 0
                              //               ? 16.0
                              //               : 6.0),
                              //       child: Image.asset(
                              //         "assets/images/coffee.png",
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // GestureDetector(
                              //   onTap: () {
                              //     setState(() {
                              //       selectedCategoryIndex = 1;
                              //     });
                              //     logger.i(selectedCategoryIndex);
                              //   },
                              //   child: Card(
                              //     elevation:
                              //         selectedCategoryIndex == 0 ? 20 : 10,
                              //     child: Padding(
                              //       padding: EdgeInsets.all(
                              //         selectedCategoryIndex == 1 ? 16 : 6,
                              //       ),
                              //       child: Image.asset(
                              //         "assets/images/bread.png",
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // Card(
                              //   elevation: 10,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(6.0),
                              //     child: Image.asset(
                              //       "assets/images/cupcake.png",
                              //     ),
                              //   ),
                              // ),
                              // Card(
                              //   elevation: 10,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(6.0),
                              //     child: Image.asset(
                              //       "assets/images/french_fries.png",
                              //     ),
                              //   ),
                              // ),
                              // Card(
                              //   elevation: 10,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(6.0),
                              //     child: Image.asset(
                              //       "assets/images/ice_cream.png",
                              //     ),
                              //   ),
                              // ),
                              // Card(
                              //   elevation: 10,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(6.0),
                              //     child: Image.asset(
                              //       "assets/images/raspberry.png",
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      // color: Colors.yellow,
                                      ),
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      sizedBox20(),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        width: 500,
                                        height: 50,
                                        child: const Center(
                                          child: Text(
                                            "APPETIZER",
                                          ),
                                        ),
                                      ),
                                      sizedBox20(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedItemIndex == 1;
                                              });
                                            },
                                            child: Container(
                                              width: 170,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  opacity: 0.9,
                                                  image: AssetImage(
                                                    selectedCategoryIndex == 0
                                                        ? "assets/images/coffee_1.jpg"
                                                        : "assets/images/bread_1.jpg",
                                                  ),
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    bottom: 30,
                                                    left: 10,
                                                    child: Text(
                                                      selectedCategoryIndex == 0
                                                          ? coffeeResponse[0]
                                                              ["name"]
                                                          : "Bread",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 19,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 15,
                                                    left: 10,
                                                    child: Text(
                                                      selectedCategoryIndex == 0
                                                          ? 'Rs :${coffeeResponse[0]["price"]}'
                                                          : "Rs : 80",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ),
                                                  //           Positioned(
                                                  //             bottom: 5,
                                                  //             right: 10,
                                                  //             child: GestureDetector(
                                                  //               onTap: () {},
                                                  //               child: Container(
                                                  //                 width: 90,
                                                  //                 height: 20,
                                                  //                 // margin: const EdgeInsets.all(
                                                  //                 //   5,
                                                  //                 // ),
                                                  //                 decoration: BoxDecoration(
                                                  //                   color: Colors.red,
                                                  //                   borderRadius:
                                                  //                       BorderRadius.circular(
                                                  //                     10,
                                                  //                   ),
                                                  //                 ),
                                                  //                 child: const Center(
                                                  //                   child: Text(
                                                  //                     "Add To Cart",
                                                  //                   ),
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //           )
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //     Container(
                                                  //       width: 170,
                                                  //       height: 150,
                                                  //       decoration: BoxDecoration(
                                                  //         color: Colors.white,
                                                  //         borderRadius: BorderRadius.circular(
                                                  //           10,
                                                  //         ),
                                                  //         image: const DecorationImage(
                                                  //           fit: BoxFit.cover,
                                                  //           opacity: 0.9,
                                                  //           image: AssetImage(
                                                  //             "assets/images/food.jpg",
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //       child: Stack(
                                                  //         children: [
                                                  //           const Positioned(
                                                  //             bottom: 30,
                                                  //             left: 10,
                                                  //             child: Text(
                                                  //               "Pasta",
                                                  //               style: TextStyle(
                                                  //                 color: Colors.white,
                                                  //                 fontWeight: FontWeight.bold,
                                                  //                 fontSize: 19,
                                                  //               ),
                                                  //             ),
                                                  //           ),
                                                  //           const Positioned(
                                                  //             bottom: 15,
                                                  //             left: 10,
                                                  //             child: Text(
                                                  //               "Rs : 120",
                                                  //               style: TextStyle(
                                                  //                 color: Colors.white,
                                                  //                 fontWeight: FontWeight.bold,
                                                  //                 fontSize: 13,
                                                  //               ),
                                                  //             ),
                                                  //           ),
                                                  //           Positioned(
                                                  //             bottom: 5,
                                                  //             right: 10,
                                                  //             child: GestureDetector(
                                                  //               onTap: () {},
                                                  //               child: Container(
                                                  //                 width: 90,
                                                  //                 height: 20,
                                                  //                 // margin: const EdgeInsets.all(
                                                  //                 //   5,
                                                  //                 // ),
                                                  //                 decoration: BoxDecoration(
                                                  //                   color: Colors.red,
                                                  //                   borderRadius:
                                                  //                       BorderRadius.circular(
                                                  //                     10,
                                                  //                   ),
                                                  //                 ),
                                                  //                 child: const Center(
                                                  //                   child: Text(
                                                  //                     "Add To Cart",
                                                  //                   ),
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //           )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      sizedBox20(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: 170,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                              image: const DecorationImage(
                                                fit: BoxFit.cover,
                                                opacity: 0.9,
                                                image: AssetImage(
                                                  "assets/images/food.jpg",
                                                ),
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                const Positioned(
                                                  bottom: 30,
                                                  left: 10,
                                                  child: Text(
                                                    "Pasta",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 19,
                                                    ),
                                                  ),
                                                ),
                                                const Positioned(
                                                  bottom: 15,
                                                  left: 10,
                                                  child: Text(
                                                    "Rs : 120",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 5,
                                                  right: 10,
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      width: 90,
                                                      height: 20,
                                                      // margin: const EdgeInsets.all(
                                                      //   5,
                                                      // ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10,
                                                        ),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          "Add To Cart",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 170,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                              image: const DecorationImage(
                                                fit: BoxFit.cover,
                                                opacity: 0.9,
                                                image: AssetImage(
                                                  "assets/images/food.jpg",
                                                ),
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                const Positioned(
                                                  bottom: 30,
                                                  left: 10,
                                                  child: Text(
                                                    "Pasta",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 19,
                                                    ),
                                                  ),
                                                ),
                                                const Positioned(
                                                  bottom: 15,
                                                  left: 10,
                                                  child: Text(
                                                    "Rs : 120",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 5,
                                                  right: 10,
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      width: 90,
                                                      height: 20,
                                                      // margin: const EdgeInsets.all(
                                                      //   5,
                                                      // ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10,
                                                        ),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          "Add To Cart",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      // sizedBox20(),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceEvenly,
                                      //   children: [
                                      //     Container(
                                      //       width: 170,
                                      //       height: 150,
                                      //       decoration: BoxDecoration(
                                      //         color: Colors.white,
                                      //         borderRadius: BorderRadius.circular(
                                      //           10,
                                      //         ),
                                      //         image: const DecorationImage(
                                      //           fit: BoxFit.cover,
                                      //           opacity: 0.9,
                                      //           image: AssetImage(
                                      //             "assets/images/food.jpg",
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       child: Stack(
                                      //         children: [
                                      //           const Positioned(
                                      //             bottom: 30,
                                      //             left: 10,
                                      //             child: Text(
                                      //               "Pasta",
                                      //               style: TextStyle(
                                      //                 color: Colors.white,
                                      //                 fontWeight: FontWeight.bold,
                                      //                 fontSize: 19,
                                      //               ),
                                      //             ),
                                      //           ),
                                      //           const Positioned(
                                      //             bottom: 15,
                                      //             left: 10,
                                      //             child: Text(
                                      //               "Rs : 120",
                                      //               style: TextStyle(
                                      //                 color: Colors.white,
                                      //                 fontWeight: FontWeight.bold,
                                      //                 fontSize: 13,
                                      //               ),
                                      //             ),
                                      //           ),
                                      //           Positioned(
                                      //             bottom: 5,
                                      //             right: 10,
                                      //             child: GestureDetector(
                                      //               onTap: () {},
                                      //               child: Container(
                                      //                 width: 90,
                                      //                 height: 20,
                                      //                 // margin: const EdgeInsets.all(
                                      //                 //   5,
                                      //                 // ),
                                      //                 decoration: BoxDecoration(
                                      //                   color: Colors.red,
                                      //                   borderRadius:
                                      //                       BorderRadius.circular(
                                      //                     10,
                                      //                   ),
                                      //                 ),
                                      //                 child: const Center(
                                      //                   child: Text(
                                      //                     "Add To Cart",
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           )
                                      //         ],
                                      //       ),
                                      //     ),
                                      //     Container(
                                      //       width: 170,
                                      //       height: 150,
                                      //       decoration: BoxDecoration(
                                      //         color: Colors.white,
                                      //         borderRadius: BorderRadius.circular(
                                      //           10,
                                      //         ),
                                      //         image: const DecorationImage(
                                      //           fit: BoxFit.cover,
                                      //           opacity: 0.9,
                                      //           image: AssetImage(
                                      //             "assets/images/food.jpg",
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       child: Stack(
                                      //         children: [
                                      //           const Positioned(
                                      //             bottom: 30,
                                      //             left: 10,
                                      //             child: Text(
                                      //               "Pasta",
                                      //               style: TextStyle(
                                      //                 color: Colors.white,
                                      //                 fontWeight: FontWeight.bold,
                                      //                 fontSize: 19,
                                      //               ),
                                      //             ),
                                      //           ),
                                      //           const Positioned(
                                      //             bottom: 15,
                                      //             left: 10,
                                      //             child: Text(
                                      //               "Rs : 120",
                                      //               style: TextStyle(
                                      //                 color: Colors.white,
                                      //                 fontWeight: FontWeight.bold,
                                      //                 fontSize: 13,
                                      //               ),
                                      //             ),
                                      //           ),
                                      //           Positioned(
                                      //             bottom: 5,
                                      //             right: 10,
                                      //             child: GestureDetector(
                                      //               onTap: () {},
                                      //               child: Container(
                                      //                 width: 90,
                                      //                 height: 20,
                                      //                 // margin: const EdgeInsets.all(
                                      //                 //   5,
                                      //                 // ),
                                      //                 decoration: BoxDecoration(
                                      //                   color: Colors.red,
                                      //                   borderRadius:
                                      //                       BorderRadius.circular(
                                      //                     10,
                                      //                   ),
                                      //                 ),
                                      //                 child: const Center(
                                      //                   child: Text(
                                      //                     "Add To Cart",
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           )
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      120,
                                  height: double.infinity,
                                  decoration: const BoxDecoration(
                                      // color: Colors.black,
                                      ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 50,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        sizedBox20(),
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              0,
                                            ),
                                          ),
                                          child: Image.asset(
                                            selectedCategoryIndex == 0
                                                ? "assets/images/coffee_1.jpg"
                                                : "assets/images/bread_1.jpg",
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                120,
                                            height: 300,
                                          ),
                                        ),
                                        sizedBox20(),
                                        const Text(
                                          "CHICKEN WINGS",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                        sizedBox20(),
                                        const Text(
                                          "Welcome Back to my channel Sarath S Neon Tech If you Like my Videos Feel free to subscribe as it is absolutely free",
                                          style: TextStyle(
                                            color: Colors.black,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                        sizedBox20(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text(
                                                    "Small",
                                                  ),
                                                ),
                                                const Text(
                                                  "RS. 120",
                                                ),
                                                Checkbox(
                                                  value: false,
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      checkboxValue = false;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text(
                                                    "Small",
                                                  ),
                                                ),
                                                const Text(
                                                  "RS. 150",
                                                ),
                                                Checkbox(
                                                  value: false,
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      checkboxValue = false;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text(
                                                    "Small",
                                                  ),
                                                ),
                                                const Text(
                                                  "RS. 200",
                                                ),
                                                Checkbox(
                                                  value: false,
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      checkboxValue = false;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        sizedBox20(),
                                        const Text(
                                          "Add Option",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: false,
                                              onChanged: (bool? newValue) {
                                                setState(
                                                  () {
                                                    checkboxValue = false;
                                                  },
                                                );
                                              },
                                            ),
                                            const Text(
                                              "Cheese",
                                            ),
                                            Checkbox(
                                              value: false,
                                              onChanged: (bool? newValue) {
                                                setState(
                                                  () {
                                                    checkboxValue = false;
                                                  },
                                                );
                                              },
                                            ),
                                            const Text(
                                              "Sauce",
                                            ),
                                            Checkbox(
                                              value: false,
                                              onChanged: (bool? newValue) {
                                                setState(
                                                  () {
                                                    checkboxValue = false;
                                                  },
                                                );
                                              },
                                            ),
                                            const Text(
                                              "Onion",
                                            ),
                                            Checkbox(
                                              value: false,
                                              onChanged: (bool? newValue) {
                                                setState(
                                                  () {
                                                    checkboxValue = false;
                                                  },
                                                );
                                              },
                                            ),
                                            const Text(
                                              "Chicken",
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: const [
                                            Text(
                                              "TOTAL RS.120",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        sizedBox20(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                      10,
                                                    ),
                                                    bottomLeft: Radius.circular(
                                                      10,
                                                    ),
                                                  ),
                                                ),
                                                minimumSize: const Size(
                                                  150,
                                                  50,
                                                ),
                                                maximumSize: const Size(
                                                  150,
                                                  50,
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: const Text(
                                                "ORDER NOW",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight: Radius.circular(
                                                      10,
                                                    ),
                                                    bottomRight:
                                                        Radius.circular(
                                                      10,
                                                    ),
                                                  ),
                                                ),
                                                backgroundColor: Colors.red,
                                                minimumSize: const Size(
                                                  160,
                                                  50,
                                                ),
                                                maximumSize: const Size(
                                                  160,
                                                  50,
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: const Text(
                                                "ADD TO CART",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
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
