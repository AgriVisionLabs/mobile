import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/account_bloc/bloc/account_bloc.dart';
import 'package:grd_proj/components/forget_password_data.dart';
import 'package:grd_proj/bloc/user_cubit.dart';
import 'package:grd_proj/models/unauthorize_model.dart';

import '../components/color.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
  int currentIndex = 1;
  String description = '';
  UnAuthorizeModel? response;
  String? currentOTP;
  int _start = 60;
  Timer? _timer;
  bool _isButtonEnabled = false;
  void _startTimer() {
    setState(() {
      _start = 60;
      _isButtonEnabled = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isButtonEnabled = true;
        });
        _timer?.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(listener: (context, state) {
      if (state is VerifySuccess) {
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
      } else if (state is VerifyFailure) {
        if (state.errMessage == 'Unauthorize') {
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
        context.read<AccountBloc>().otpFormKey.currentState!.validate();
      } else if (state is ChangePasswordSuccess) {
        ScaffoldMessenger.of(context).clearSnackBars();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("success"),
            ),
          );
        });
        Navigator.pop(context);
      } else if (state is ChangePasswordFailure) {
        ScaffoldMessenger.of(context).clearSnackBars();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
            ),
          );
        });
        context
            .read<AccountBloc>()
            .changePasswordFormKey
            .currentState!
            .validate();
      }
    }, builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(22),
                child: Column(children: [
                  head(),
                  currentIndex == 1 ? vCode() : resetPassword()
                ]))),
      );
    });
  }

//back and close arrow
  Widget head() {
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
            key: context.read<AccountBloc>().otpFormKey,
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
                  context.read<AccountBloc>().forgetPasswordOtp.text =
                      currentOTP!;
                  BlocProvider.of<AccountBloc>(context).add(VerifyOtp());
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
            key: context.read<AccountBloc>().changePasswordFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Current Password",
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
                  controller: context.read<AccountBloc>().currentPassword,
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
                    if (value!.isEmpty) {
                      return "Current Password Can't Be Empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
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
                    if (value != null) {
                      if (value.isEmpty) {
                        return "New Password Can't Be Empty";
                      } else if (value.length < 8) {
                        return "Password must be at least 8 characters";
                      } else if (!value.contains(RegExp(r'[A-Z]'))) {
                        return "Password must be contain at least one uppercase letter";
                      } else if (!value
                          .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        return "Password must be contain at least one special character";
                      } else if (!value.contains(RegExp(r'[0-9]'))) {
                        return "Password must be contain at least one number";
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
                          context.read<AccountBloc>().newPassword =
                              passwordController;

                          BlocProvider.of<AccountBloc>(context)
                              .add(ChangedPassword());
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                        _startTimer();
                      }
                    : null,
                child: Text(
                  _isButtonEnabled
                      ? 'Resend'
                      : 'Resend in 00:${_start.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: _isButtonEnabled
                        ? const Color(0xff1E6930)
                        : Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
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
