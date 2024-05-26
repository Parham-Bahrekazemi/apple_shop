import 'package:apple_shop/constants/colors.dart';

import 'package:apple_shop/widgets/exit_dialog.dart';

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 32, left: 44, right: 44, top: 20),
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/images/icon_apple_blue.png'),
                      const Expanded(
                        child: Text(
                          'حساب کاربری',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'SM',
                            color: CustomColor.gray,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Text(
              'پرهام بحرکاظمی',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'SB',
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              '09012345678',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'SB',
                color: CustomColor.gray,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(150, 46),
              ),
              onPressed: () {
                exitDialog(context);
              },
              child: const Text(
                'خروج',
                style: TextStyle(
                  fontFamily: 'SB',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Directionality(
              textDirection: TextDirection.rtl,
              child: Wrap(
                spacing: 38,
                runSpacing: 20,
                children: <Widget>[
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              'اپل شاپ',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'SB',
                color: CustomColor.gray,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'V-1.0.00',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'SB',
                color: CustomColor.gray,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Instagram.com/flutter_core',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'SB',
                color: CustomColor.gray,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
