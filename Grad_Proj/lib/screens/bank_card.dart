// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';
import 'package:flutter/services.dart';

class BankCard extends StatefulWidget {
  const BankCard({super.key});
  
  @override
  State<BankCard> createState() => _BankCardState();
}

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String formatted = '';

    if (digitsOnly.length >= 2) {
      formatted = digitsOnly.substring(0, 2);
      if (digitsOnly.length > 2) {
        formatted += '/${digitsOnly.substring(2, digitsOnly.length.clamp(2, 6))}';
      }
    } else {
      formatted = digitsOnly;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _BankCardState extends State<BankCard> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: 60),
          Row(
            children: [
              Text('Add a Bank Card',
                style: TextStyle(
                  fontSize: 24,
                  color: primaryColor,
                  fontFamily: "manrope",
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ), 
              ],
            ),
            SizedBox(height: 40),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Color(0xffF0F2F5),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 7),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Card Name",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontFamily: "manrope",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    hintText: 'Enter Card Name',
                    hintStyle: TextStyle(
                      color: Color(0xff616161),
                      fontSize: 16,
                      fontFamily: "manrope",
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Text("Name",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontFamily: "manrope",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    hintText: 'Enter name on the card',
                    hintStyle: TextStyle(
                      color: Color(0xff616161),
                      fontSize: 16,
                      fontFamily: "manrope",
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    SizedBox(
                      width: 154,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Expire Date",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontFamily: "manrope",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(7), // max MM/YYYY
                              ExpiryDateFormatter(),
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: primaryColor, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey, width: 1),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.red, width: 1),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.red, width: 2),
                              ),
                              hintText: 'Month/Year',
                              hintStyle: TextStyle(
                                color: Color(0xff616161),
                                fontSize: 16,
                                fontFamily: "manrope",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 24),
                    SizedBox(
                      width: 154,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("CVV",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontFamily: "manrope",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 12),
                          TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: primaryColor, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey, width: 1),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.red, width: 1),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.red, width: 2),
                              ),
                              hintText: '123',
                              hintStyle: TextStyle(
                                color: Color(0xff616161),
                                fontSize: 16,
                                fontFamily: "manrope",
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: borderColor, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 7),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Image.asset(
                'assets/images/alert.png',
                width: 24,
                height: 24,
                color: Colors.black,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'The subscription fee will be automatically deducted from your bank card every month.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontFamily: "manrope",
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(height: 175),
          SizedBox(
            height: 55,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45),
                ),
                shadowColor: Colors.transparent,
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: "manrope",
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                // Handle the button press
                Navigator.pop(context);
              },
              child: Text(
                'Add Card',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: "manrope",
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ),
          ],
        ),
      ),
      ),
    );
  }
}
