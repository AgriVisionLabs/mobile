import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/components/forget_password_data.dart';
import 'package:grd_proj/bloc/user_cubit.dart';
import 'package:grd_proj/bloc/user_state.dart';
import 'package:grd_proj/models/unauthorize_model.dart';

import '../components/color.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();
  TextEditingController otpController5 = TextEditingController();
  TextEditingController otpController6 = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool obscureText = true;
  bool obscureText2 = true;
  final controller = ForgetPasswordData();
  int currentIndex = 0;
  String description = '';
  UnAuthorizeModel? response;
  String? currentOTP;
  bool _isButtonEnabled = false; // Button state
  Timer? _timer;
  // Timer instance
  void _startTimer() {
    // Set the button to be disabled initially
    setState(() {
      _isButtonEnabled = false;
    });

    // Start a timer that will enable the button after 10 minutes
    _timer = Timer(const Duration(minutes: 1), () {
      setState(() {
        _isButtonEnabled = true; // Enable the button after 10 minutes
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is ForgetPasswordSuccess) {
        ScaffoldMessenger.of(context).clearSnackBars();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("success"),
            ),
          );
        });
        _startTimer();
        // ignore: avoid_print
        currentIndex == 0 ? currentIndex++ : print('rigth pos');
      } else if (state is ForgetPasswordFailure) {
        if (state.errMessage == 'Bad Request') {
          description = state.errors[0]['description'];
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(description),
              ),
            );
          });
        } else {
          response = UnAuthorizeModel.fromJson(state.errors);
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
        }
        context
            .read<UserCubit>()
            .forgetPasswordFormKey
            .currentState!
            .validate();
      } else if (state is OTPSuccess) {
        ScaffoldMessenger.of(context).clearSnackBars();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("success"),
            ),
          );
        });
        currentIndex++;
        otpController1.clear();
        otpController2.clear();
        otpController3.clear();
        otpController4.clear();
        otpController5.clear();
        otpController6.clear();
      } else if (state is OTPFailure) {
        if (state.errMessage == 'Bad Request') {
          description = state.errors[0]['description'];
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(description),
              ),
            );
          });
        } else {
          response = UnAuthorizeModel.fromJson(state.errors);
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response!.otp![0]),
              ),
            );
          });
        }
        context.read<UserCubit>().otpFormKey.currentState!.validate();
      } else if (state is ResetPasswordSuccess) {
        ScaffoldMessenger.of(context).clearSnackBars();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("success"),
            ),
          );
        });
        Navigator.pop(context);
      } else if (state is ResetPasswordFailure) {
        if (state.errMessage == 'Bad Request') {
          description = state.errors[0]['description'];
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(description),
              ),
            );
          });
        } else {
          response = UnAuthorizeModel.fromJson(state.errors);
          // print("===========STATE========== ${response!.newPassword![0]}");
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
        }
        context.read<UserCubit>().resetFormKey.currentState!.validate();
      }
    }, builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(22),
                child: Column(children: [
                  head(),
                  currentIndex == 0
                      ? forgetPassword()
                      : currentIndex == 1
                          ? vCode()
                          : resetPassword()
                ]))),
      );
    });
  }

//back and close arrow
  Widget head() {
    if (currentIndex > 0) {
      return Padding(
        padding: const EdgeInsets.only(top: 3.0, right: 300),
        child: IconButton(
            onPressed: () {
              setState(() {
                currentIndex--;
                passwordController.clear();
                confirmPasswordController.clear();
              });
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 300),
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<UserCubit>().forgetPasswordEmail.clear();
            },
            icon: const Icon(
              Icons.close,
            )),
      );
    }
  }

  Widget forgetPassword() {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //Titles
          Text(
            controller.items[currentIndex].title,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontFamily: "Manrope",
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 14),
          Text(
            controller.items[currentIndex].description,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontFamily: "Manrope"),
          ),
          Form(
            key: context.read<UserCubit>().forgetPasswordFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: context.read<UserCubit>().forgetPasswordEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 17),
                    hintText: "Enter your Email",
                    hintStyle: const TextStyle(color: borderColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(color: borderColor, width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(color: primaryColor, width: 3.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(color: errorColor, width: 3.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(color: errorColor, width: 3.0),
                    ),
                  ),
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) {
                    if (response!.email != null) {
                      if (value!.isEmpty) {
                        return response!.email![0];
                      } else {
                        return response!.email![0];
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: SizedBox(
                    width: 227,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff1E6930),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        BlocProvider.of<UserCubit>(context).sendCode();
                      },
                      child: Text(
                        controller.items[0].button,
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

  Widget vCode() {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //Titles
          Text(
            controller.items[currentIndex].title,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontFamily: "Manrope",
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 14),
          Text(
            controller.items[currentIndex].description,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontFamily: "Manrope"),
          ),
          const SizedBox(
            height: 14,
          ),
          Form(
            key: context.read<UserCubit>().otpFormKey,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  square(controller: otpController1),
                  square(controller: otpController2),
                  square(controller: otpController3),
                  square(controller: otpController4),
                  square(controller: otpController5),
                  square(controller: otpController6)
                ]),
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: SizedBox(
              width: 227,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1E6930),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  currentOTP = otpController1.text +
                      otpController2.text +
                      otpController3.text +
                      otpController4.text +
                      otpController5.text +
                      otpController6.text;
                  context.read<UserCubit>().forgetPasswordOtp.text =
                      currentOTP!;
                  BlocProvider.of<UserCubit>(context).otp();
                },
                child: Text(
                  controller.items[1].button,
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          codeResend()
        ]));
  }

  Widget resetPassword() {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //Titles
          Text(
            controller.items[currentIndex].title,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontFamily: "Manrope",
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          Form(
            key: context.read<UserCubit>().resetFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "New Password",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: obscureText,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 17),
                    hintText: "Enter your Password",
                    hintStyle: const TextStyle(color: borderColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide:
                          const BorderSide(color: borderColor, width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide:
                          const BorderSide(color: primaryColor, width: 3.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(color: errorColor, width: 3.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(color: errorColor, width: 3.0),
                    ),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        child: Image.asset(obscureText
                            ? 'assets/images/visiability on.png'
                            : 'assets/images/visiability off.png')),
                  ),
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) {
                    if (response!.newPassword != null) {
                      if (value!.isEmpty) {
                        return response!.newPassword![0];
                      } else {
                        return response!.newPassword![0];
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Confirm Password",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: obscureText2,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 17),
                    hintText: "Enter your Password",
                    hintStyle: const TextStyle(color: borderColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide:
                          const BorderSide(color: borderColor, width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide:
                          const BorderSide(color: primaryColor, width: 3.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(color: errorColor, width: 3.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(color: errorColor, width: 3.0),
                    ),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscureText2 = !obscureText2;
                          });
                        },
                        child: Image.asset(obscureText2
                            ? 'assets/images/visiability on.png'
                            : 'assets/images/visiability off.png')),
                  ),
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) {
                    if (value != passwordController.text) {
                      return 'Please confirm your password';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    width: 227,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff1E6930),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () {
                        if (confirmPasswordController.text ==
                            passwordController.text) {
                          context.read<UserCubit>().newPassword =
                              passwordController;

                          BlocProvider.of<UserCubit>(context).resetPassword();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Please Confirm Your Password')));
                        }
                      },
                      child: Text(
                        controller.items[2].button,
                        style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          // Center(child: button())
        ]));
  }

  Widget square({required TextEditingController controller}) {
    return SizedBox(
      width: 55,
      height: 55,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: borderColor, width: 3.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: primaryColor, width: 3.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: errorColor, width: 3.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: errorColor, width: 3.0),
          ),
        ),
        validator: (value) {
          if (response!.otp != null) {
            if (value!.isEmpty) {
              return '';
            } else {
              return '';
            }
          }
          return null;
        },
      ),
    );
  }

//Resend code
  Widget codeResend() {
    if (currentIndex == 1) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 27.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t Recieve Code? ',
                style: TextStyle(fontFamily: "Manrope", fontSize: 18),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: _isButtonEnabled
                    ? () {
                        BlocProvider.of<UserCubit>(context).sendCode();
                      }
                    : () {},
                child: Text(
                  'Resend',
                  style: TextStyle(
                    color: _isButtonEnabled
                        ? const Color(0xff1E6930)
                        : borderColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox(
        height: 2,
      );
    }
  }
}
