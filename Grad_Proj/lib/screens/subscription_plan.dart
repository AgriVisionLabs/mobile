// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/screens/bank_card.dart';


class SubscriptionPlan extends StatefulWidget {
  const SubscriptionPlan({super.key,});

  @override
  State<SubscriptionPlan> createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends State<SubscriptionPlan> {
    int selectedIndex = 0;
    bool freePlan = false;
    bool advancedPlan = false;
    bool enterprisePlan = false;

    void updateSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
        children: [
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
          child: Container(
            color: Colors.white,
            child: Column(
            children: [
              Row(
              children: [
                Text(
                "Available Subscriptions",
                style: TextStyle(
                  fontSize: 24,
                  color: primaryColor,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                ),
                ),
                Spacer(),
                IconButton(
                icon: Icon(Icons.close, color: primaryColor),
                onPressed: () {
                  Navigator.pop(context);
                },
                ),
              ],
              ),
              SizedBox(height: 40),
              Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 7),
                ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  children: [
                  Text(
                    "Basic Plan",
                    style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Free",
                    style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Manrope',
                    color: primaryColor,
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                  Icon(Icons.check, color: primaryColor),
                  SizedBox(width: 5),
                  Text(
                    "1 Farm",
                    style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Manrope',
                    color: Colors.black,
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                  Icon(Icons.check, color: primaryColor),
                  SizedBox(width: 5),
                  Text(
                    "Up to 3 Fields",
                    style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Manrope',
                    color: Colors.black,
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  'Features:',
                  style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Icon(Icons.check, color: primaryColor),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                    "Access to the dashboard for farm and field management.",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      color: Colors.black,
                    ),
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Icon(Icons.check, color: primaryColor),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                    "Basic soil health and weather insights.",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      color: Colors.black,
                    ),
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Icon(Icons.check, color: primaryColor),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                    "AI-powered disease detection for limited usage.",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      color: Colors.black,
                    ),
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 24),
                Divider(
                  color: Color(0xff898989),
                  thickness: 1,
                ),
                SizedBox(height: 24), 
                GestureDetector(
                  onTap: () {
                    
                    setState(() {
                      freePlan = !freePlan;
                      advancedPlan = false;
                      enterprisePlan = false;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    decoration: BoxDecoration(
                      color: freePlan ? primaryColor : const Color(0xff898989),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Center(
                      child: Text(
                        freePlan ? "Change" : "Selected",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ],
              ),
              ),
              SizedBox(height: 24),
              Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 7),
                ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  children: [
                  Text(
                    "Advanced",
                    style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "499.99 L.E / month",
                    style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Manrope',
                    color: primaryColor,
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                  Icon(Icons.check, color: primaryColor),
                  SizedBox(width: 5),
                  Text(
                    "Up to 3 farms",
                    style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Manrope',
                    color: Colors.black,
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                  Icon(Icons.check, color: primaryColor),
                  SizedBox(width: 5),
                  Text(
                    "5 fields per farm",
                    style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Manrope',
                    color: Colors.black,
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  'Features:',
                  style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Icon(Icons.check, color: primaryColor),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                    "All Free Plan features.",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      color: Colors.black,
                    ),
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Icon(Icons.check, color: primaryColor),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                    "Advanced analytics and predictive insights.",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      color: Colors.black,
                    ),
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Icon(Icons.check, color: primaryColor),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                    "Unlimited AI-powered disease detection.",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      color: Colors.black,
                    ),
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Icon(Icons.check, color: primaryColor),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                    "Customizable automation rules for irrigation and sensor integration.",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      color: Colors.black,
                    ),
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 24),
                Divider(
                  color: Color(0xff898989),
                  thickness: 1,
                  height: 24,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(
                      builder: (context) => BankCard()
                    ));
                    setState(() {
                      freePlan = true;
                      advancedPlan = !advancedPlan;
                      enterprisePlan = false;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    decoration: BoxDecoration(
                      color: advancedPlan ? const Color(0xff898989) : primaryColor,
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Center(
                      child: Text(
                        selectedIndex == 1 ? "Selected" : "Change",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ],
              ),
              ),
              SizedBox(height: 24),
              Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 7),
                ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  children: [
                  Text(
                    "Enterprise",
                    style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Custom",
                    style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Manrope',
                    color: primaryColor,
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                  Icon(Icons.check, color: primaryColor),
                  SizedBox(width: 5),
                  Text(
                    "Unlimited farms",
                    style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Manrope',
                    color: Colors.black,
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                  Icon(Icons.check, color: primaryColor),
                  SizedBox(width: 5),
                  Text(
                    "Unlimited fields per farm",
                    style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Manrope',
                    color: Colors.black,
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  'Features:',
                  style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Icon(Icons.check, color: primaryColor),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                    "All Advanced Plan features.",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      color: Colors.black,
                    ),
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Icon(Icons.check, color: primaryColor),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                    "Advanced analytics and predictive insights.",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      color: Colors.black,
                    ),
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Icon(Icons.check, color: primaryColor),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                    "Unlimited AI-powered disease detection.",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      color: Colors.black,
                    ),
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Icon(Icons.check, color: primaryColor),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                    "Dedicated account manager for personalized support.",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope',
                      color: Colors.black,
                    ),
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 24),
                Divider(
                  color: Color(0xff898989),
                  thickness: 1,
                ),
                SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(
                      builder: (context) => BankCard()
                    ));
                    setState(() {
                      freePlan = true;
                      advancedPlan = false;
                      enterprisePlan = !enterprisePlan;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    decoration: BoxDecoration(
                      color: enterprisePlan ? const Color(0xff898989) : primaryColor,
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Center(
                      child: Text(
                        selectedIndex == 1 ? "Contacted" : "Contact Sales",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ],
              ),
              ),
            ],
            ),
          ),
          ),
        ],
        ),
      ),
      ),
    );
  }
}


