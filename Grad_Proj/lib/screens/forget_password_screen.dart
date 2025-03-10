import 'package:firebase_auth/firebase_auth.dart';
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
  final _firebase = FirebaseAuth.instance;
  bool obscureText = true;
  bool obscureText2 = true;
  final controller = ForgetPasswordData();
  final pageController = PageController();
  int currentIndex = 0;
  String code = '12345';


  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        // Return true to allow back navigation, false to prevent it
        if (currentIndex > 0) {
          pageController.previousPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SizedBox(
            height: 385,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  head(),
                  body(),
                  currentIndex == 0
                      ? email()
                      : currentIndex == 1
                          ? buildSequare()
                          : password(),
                  button(),
                  codeResend()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


//back and close arrow
  Widget head() {
    if (currentIndex > 0) {
      return Padding(
        padding: const EdgeInsets.only(top: 3.0, right: 300),
        child: IconButton(
            onPressed: () {
              pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
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

  //Body
  Widget body() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 14),
        child: Center(
          child: PageView.builder(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Titles
                  Text(
                    controller.items[index].title,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 14),
                  //Description
                  currentIndex != 2
                      ? Text(
                          controller.items[index].description,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "Manrope"),
                        )
                      : const SizedBox(height: 0),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  //email text field
  Widget email() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Form(
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
            const SizedBox(height: 8,),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Enter your Email",
                hintStyle: const TextStyle(color: borderColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: borderColor, width: 3.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: primaryColor, width: 3.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: errorColor, width: 3.0),
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
    );
  }


//reset password
  Widget password() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Form(
        key: formstate,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "New Password",
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontFamily: "Manrope",
                  fontWeight: FontWeight.normal),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: obscureText,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: "Enter your  Password",
                hintStyle: const TextStyle(color: borderColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(color: borderColor, width: 3.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(color: primaryColor, width: 3.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: errorColor, width: 3.0),
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off)),
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
              height: 5,
            ),
            const Text(
              "Confirm Password",
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontFamily: "Manrope",
                  fontWeight: FontWeight.normal),
            ),
            TextFormField(
              obscureText: obscureText2,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: "Enter your  Password",
                hintStyle: const TextStyle(color: borderColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(color: borderColor, width: 3.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(color: primaryColor, width: 3.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: errorColor, width: 3.0),
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText2 = !obscureText2;
                      });
                    },
                    icon: Icon(
                        obscureText2 ? Icons.visibility : Icons.visibility_off)),
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
    );
  }

  Widget buildSequare() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 17),
        child: Row(
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
        ));
  }

  //Button
  Widget button() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 37.0),
      child: Container(
        width: MediaQuery.of(context).size.width * .6,
        height: 47,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: primaryColor,
        ),
        child: TextButton(
          onPressed: () {
          if (currentIndex == 0 &&formstate.currentState!.validate()) {
          try {
              _firebase.sendPasswordResetEmail(
                  email: emailController.text);
          }on FirebaseAuthException catch(e){
            ScaffoldMessenger.of(context).clearSnackBars();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.message ?? "An error occurred"),
                ),
              );
             });
             } 
             pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linearToEaseOut,
                );
           }
          else if (currentIndex == 1) {
          try {
              _firebase.verifyPasswordResetCode(code);
          }on FirebaseAuthException catch(e){
            ScaffoldMessenger.of(context).clearSnackBars();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.message ?? "An error occurred"),
                ),
              );
             });
             } 
             pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linearToEaseOut,
                );
            
           }
          else if (currentIndex == 2&& formstate.currentState!.validate()) {
          try {
              _firebase.confirmPasswordReset(
                    code: "123456", 
                    newPassword: passwordController.text);
          }on FirebaseAuthException catch(e){
            ScaffoldMessenger.of(context).clearSnackBars();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.message ?? "An error occurred"),
                ),
              );
             });
             } 
             Navigator.pop(context);
             
            
           }
          // pageController.nextPage(
          //         duration: const Duration(milliseconds: 500),
          //         curve: Curves.linearToEaseOut,
          //       );
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
      ),
    );
  }

//Resend code
  Widget codeResend() {
    if (currentIndex == 1){
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
    }else{
      return const SizedBox(height: 2,);
    }
  }
}
