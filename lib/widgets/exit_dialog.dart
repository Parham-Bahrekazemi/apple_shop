import 'package:animate_do/animate_do.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/screens/login_screen.dart';
import 'package:apple_shop/utils/auth_manager.dart';
import 'package:flutter/material.dart';

exitDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => FadeInRight(
      duration: const Duration(milliseconds: 1000),
      child: Center(
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Column(
              children: [
                const Text(
                  'مطمن هستید که میخواهید خروج کنید؟',
                  style: TextStyle(
                    fontFamily: 'SB',
                    fontSize: 16,
                    // color: CustomColor.red,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColor.green,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              // side: const BorderSide(
                              //   width: 3,
                              //   color: CustomColor.blue,
                              // ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'خیر',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'dana',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColor.red,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              // side: const BorderSide(
                              //   width: 3,
                              //   color: CustomColor.blue,
                              // ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onPressed: () {
                            AuthManager.logOut();

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'بله',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'dana',
                              color: Colors.white,
                            ),
                          ),
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
    ),
  );
}
