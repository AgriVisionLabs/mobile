import 'package:flutter/material.dart';
import 'package:grd_proj/components/forget_password_data.dart';

import '../components/color.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool obscureText2 = true;
  final controller = ForgetPasswordData();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(22),
              child: Column(children: [
                head(),
                currentIndex == 0
                    ? forget_password()
                    : currentIndex == 1
                        ? vCode()
                        : resetPassword(),
                
              ]))),
    );
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
            },
            icon: const Icon(
              Icons.close,
            )),
      );
    }
  }


  Widget forget_password() {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            key: formstate,
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
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 30 , vertical: 17),
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
                  ),
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    } else if (!value.contains("@")) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16,),
          Center(child: button())
        ]));
  }

  Widget vCode() {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          const SizedBox(height: 14,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) {
              return SizedBox(
                width: 40,
                height: 40,
                child: TextField(
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                  keyboardType: TextInputType.number,
                ),
              );
            }),
          ),
          const SizedBox(height: 16,),
          Center(child: button()),
          const SizedBox(height: 16,),
          codeResend()
        ]));
  }

  Widget resetPassword() {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            key: formstate,
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30 , vertical: 17),
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
                    if (value != passwordController.text) {
                      return 'Please confirm your password';
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
                  obscureText: obscureText2,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30 , vertical: 17),
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
              ],
            ),
          ),
          const SizedBox(height: 16,),
          Center(child: button())
        ]));
  }

  //Button
  Widget button() {
    return Container(
      width: MediaQuery.of(context).size.width * .6,
      height: 47,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: primaryColor,
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            if (currentIndex == 0 && formstate.currentState!.validate()) {
              currentIndex++;
            } else if (currentIndex == 1) {
              currentIndex++;
            } else if (currentIndex == 2 && formstate.currentState!.validate()) {
              Navigator.pop(context);
            }
          });
        },
        child: Text(
          currentIndex == 0
              ? controller.items[currentIndex].button
              : currentIndex == 1
                  ? controller.items[currentIndex].button
                  : controller.items[currentIndex].button,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
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
                onTap: () {},
                child: const Text(
                  'Resend',
                  style: TextStyle(
                    color: Color(0xff1E6930),
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
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
