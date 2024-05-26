import 'package:animate_do/animate_do.dart';
import 'package:apple_shop/bloc/authentication/authentication_bloc.dart';
import 'package:apple_shop/bloc/authentication/authentication_event.dart';
import 'package:apple_shop/bloc/authentication/authentication_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/screens/dashboard_screen.dart';
import 'package:apple_shop/screens/register_screen.dart';
import 'package:apple_shop/utils/custom_loading.dart';
import 'package:apple_shop/widgets/dialog_error_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // BlocListener
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(),
      child: ViewContainer(
        usernameController: _usernameController,
        passwordController: _passwordController,
      ),
    );
  }
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class ViewContainer extends StatefulWidget {
  const ViewContainer({
    super.key,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  })  : _usernameController = usernameController,
        _passwordController = passwordController;

  final TextEditingController _usernameController;
  final TextEditingController _passwordController;

  @override
  State<ViewContainer> createState() => _ViewContainerState();
}

class _ViewContainerState extends State<ViewContainer>
    with TickerProviderStateMixin {
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 60),

                  Center(
                    child: FadeInUp(
                      from: 0,
                      child: SizedBox(
                        height: 200,
                        child: Lottie.asset(
                          'assets/animations/login.json',
                          controller: _controller,
                          onLoaded: (composition) {
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
                            controller: widget._usernameController,
                            textAlign: TextAlign.left,
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
                              return null;
                            },
                            obscureText: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            controller: widget._passwordController,
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
                          from: 150,
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
                                  AuthenticationLoginEvent(
                                    widget._usernameController.text,
                                    widget._passwordController.text,
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'ورود به حساب کاربری',
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
                                  AuthenticationLoginEvent(
                                      widget._usernameController.text,
                                      widget._passwordController.text),
                                );
                              }
                            },
                            child: const Text(
                              'ورود به حساب کاربری',
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
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                    from: 200,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                BlocProvider<AuthenticationBloc>(
                              create: (context) {
                                return AuthenticationBloc();
                              },
                              child: RegisterScreen(),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'اگر حساب کاربری ندارید ثبت نام کنید ',
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
