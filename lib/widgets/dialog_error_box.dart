import 'package:animate_do/animate_do.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:flutter/material.dart';

errorDialog(BuildContext context, String error) {
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
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Text(
                  '! خطا',
                  style: TextStyle(
                    fontFamily: 'SB',
                    fontSize: 24,
                    color: CustomColor.red,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      error,
                      style: const TextStyle(
                        fontFamily: 'dana',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.justify,
                      maxLines: 3,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.blue,
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
                        'باشه',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'dana',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
