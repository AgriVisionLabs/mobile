//ignore_for_file: deprecated_member_use, prefer_const_constructors, depend_on_referenced_packages

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grd_proj/Components/color.dart';
import 'package:grd_proj/components/onboarding_data.dart';
import 'package:grd_proj/screens/Login_Screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';




class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = OnboardingData();
  final pageController = PageController();
  int currentIndex = 0;

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
        body: Column(
          children: [
            body(),
            buildDots(),
            button(),
          ],
        ),
      ),
    );
  }

  //Body
  Widget body() {
    return Expanded(
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Images
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Material(
                      elevation: 15,
                      child: Image.asset(
                          controller.items[index].image,
                          height: 485,
                          width: 412 ,
                          fit: BoxFit.fill
                        ),
                    ),),
                  const SizedBox(height: 50),
                  //Titles
                  Text(
                    controller.items[index].title,
                    style: const TextStyle(
                      fontSize: 25,
                      color: primaryColor,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  //Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      controller.items[index].description,
                      style: const TextStyle(color: Colors.black, fontSize: 18,fontFamily: "Manrope"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  //Dots
  Widget buildDots() {
    return Container(
      child: SmoothPageIndicator(
      controller: pageController, // PageController
      count: 3,
      effect: ColorTransitionEffect(
        dotColor: secondaryColor,
        activeDotColor: primaryColor,
        dotWidth: 10,
        dotHeight: 10,
      ),
      ) 
      );

  }

  //Button
  Widget button() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 43),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: primaryColor,
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            if (currentIndex != controller.items.length - 1) {
              pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linearToEaseOut,
              );
            } 
            else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
          });
        },
        child: Text(
          currentIndex == 0 ? controller.items[currentIndex].button : currentIndex == 1? controller.items[currentIndex].button :controller.items[currentIndex].button,
          style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400,),
        ),
      ),
    );
  }

  
}


