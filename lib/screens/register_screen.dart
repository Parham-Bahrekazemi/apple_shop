import 'package:animate_do/animate_do.dart';
import 'package:apple_shop/bloc/authentication/authentication_bloc.dart';
import 'package:apple_shop/bloc/authentication/authentication_event.dart';
import 'package:apple_shop/bloc/authentication/authentication_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/screens/dashboard_screen.dart';
import 'package:apple_shop/screens/login_screen.dart';

import 'package:apple_shop/utils/custom_loading.dart';
import 'package:apple_shop/widgets/dialog_error_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _passwordConfirmController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // BlocListener
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 10),

                  Center(
                    child: FadeInUp(
                      from: 0,
                      child: SizedBox(
                        height: 220,
                        // child: Image.asset('assets/images/login_page.png'),
                        child: Lottie.asset(
                          'assets/animations/login2.json',
                          controller: _controller,
                          onLoaded: (composition) {
                            // Configure the AnimationController with the duration of the
                            // Lottie file and start the animation.
                            _controller
                              ..duration = composition.duration
                              ..repeat();
                          },
                        ),
                      ),
                    ),
                  ),

                  FadeInUp(
                    from: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'نام کاربری :',
                            style: TextStyle(
                              fontFamily: 'dana',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'نام کاربری الزامی است';
                              }
                              return null;
                            },
                            controller: _usernameController,
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(fontFamily: 'SB'),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: CustomColor.gray.withOpacity(0.2),
                              labelStyle: const TextStyle(
                                fontFamily: 'dana',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //
                  FadeInUp(
                    from: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 24.0, bottom: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'رمز عبور :',
                            style: TextStyle(
                              fontFamily: 'dana',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'رمز عبور الزامی است';
                              }
                              if (value.length < 8) {
                                return 'رمز عبور باید بیشتر از 8 کارکتر باشد';
                              }
                              if (_passwordController.text !=
                                  _passwordConfirmController.text) {
                                return 'رمز عبور باید یکسان باشد';
                              }
                              return null;
                            },
                            obscureText: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            controller: _passwordController,
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(fontFamily: 'SB'),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: CustomColor.gray.withOpacity(0.2),
                              labelStyle: const TextStyle(
                                fontFamily: 'SM',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //
                  FadeInUp(
                    from: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 24.0, bottom: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'تکرار رمز عبور :',
                            style: TextStyle(
                              fontFamily: 'dana',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'تکرار رمز عبور الزامی است';
                              }

                              return null;
                            },
                            obscureText: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            controller: _passwordConfirmController,
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(fontFamily: 'SB'),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: CustomColor.gray.withOpacity(0.2),
                              labelStyle: const TextStyle(
                                fontFamily: 'SM',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  BlocConsumer<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {
                      if (state is AuthenticationResponseState) {
                        state.response.fold(
                          (l) => errorDialog(context, l),
                          (r) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const DashboardScreen(),
                            ),
                          ),
                        );
                      }
                    },
                    builder: (BuildContext context, AuthenticationState state) {
                      if (state is AuthenticationInitState) {
                        return FadeInUp(
                          from: 200,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                                fontFamily: 'SB',
                                fontSize: 20,
                              ),
                              backgroundColor: CustomColor.blue,
                              minimumSize: const Size(200, 48),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(
                                  AuthenticationRegisterEvent(
                                    _usernameController.text,
                                    _passwordController.text,
                                    _passwordConfirmController.text,
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'ثبت نام',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                      if (state is AuthenticationLoadingState) {
                        return const SizedBox(
                          height: 60,
                          width: 60,
                          child: Center(
                            child: CustomLoadingWidget(),
                          ),
                        );
                      }

                      if (state is AuthenticationResponseState) {
                        return state.response.fold(
                          (l) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                                fontFamily: 'SB',
                                fontSize: 20,
                              ),
                              backgroundColor: CustomColor.blue,
                              minimumSize: const Size(200, 48),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(
                                  AuthenticationRegisterEvent(
                                    _usernameController.text,
                                    _passwordController.text,
                                    _passwordConfirmController.text,
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'ثبت نام',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          (r) {
                            return const Center(child: Text(''));
                          },
                        );
                      }

                      return const Text('error');
                    },
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    from: 250,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'اگر حساب کاربری دارید وارد شوید',
                        style: TextStyle(
                          fontFamily: 'dana',
                          fontSize: 16,
                          color: CustomColor.blue,
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
}
