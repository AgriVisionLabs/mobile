// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';

class SubcreptionSetting extends StatefulWidget {
  const SubcreptionSetting({super.key});

  @override
  State<SubcreptionSetting> createState() => _SubcreptionSettingState();
}

class _SubcreptionSettingState extends State<SubcreptionSetting> {
  bool currentPlan = true;
  bool paymentMethod = true;
  bool billingHistory = false;

  Widget _buildCell(
  String text, {
  bool isHeader = false,
  BorderRadius? borderRadius,
}) {
  return Container(
    width: 174,
    height: 70,
    padding: EdgeInsets.all(24),
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      color: isHeader ? Color(0XFFF4F4F4) : Colors.white,
      borderRadius: borderRadius ?? BorderRadius.zero,
    ),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        fontSize: 16,
        fontFamily: "manrope",
        color: Colors.black,
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Image.asset('assets/images/card.png', width: 24, height: 24),
              SizedBox(
                width: 4,
              ),
              Text('Subscription Management',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: "manrope",
                  ))
            ]),
            SizedBox(height: 4),
            Text('Manage your subscription plan and payment methods.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontFamily: "manrope",
                )),
            SizedBox(height: 30),
            Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Color(0xffF4F4F4),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Current Plan',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: "manrope",
                          ),
                        ),
                        Spacer(),
                        Container(
                            height: 30,
                            width: 62,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: borderColor, width: 1),
                            ),
                            child: Text('Active',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: "manrope",
                                ))),
                      ],
                    ),
                    SizedBox(height: 24),
                    currentPlan
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Basic',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "manrope",
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Free',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff616161),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "manrope",
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                      currentPlan = ! currentPlan;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 39,
                                      width: 131,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        'Upgrade Plan',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "manrope",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Advanced',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "manrope",
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '499.99 L.E / month',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff616161),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "manrope",
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/calender.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  SizedBox(width: 8),
                                  Text('Renewal Date: 15 May, 2026'),
                                ],
                              ),
                              SizedBox(height: 24),
                              GestureDetector(
                                onTap: () {
                                  print('Changed');
                                },
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  height: 40,
                                  width: 128,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: borderColor, width: 1),
                                  ),
                                  child: Text(
                                    'Change Plan',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff333333),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "manrope",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentPlan = ! currentPlan;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 178,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Color(0xffE13939), width: 1),
                                  ),
                                  child: Text(
                                    'Cancel Subscription',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffE13939),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "manrope",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                )),
                SizedBox(height: 24),
                    Divider(height: 1, color: borderColor),
                    SizedBox(height: 24),

                    paymentMethod?
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment Method',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: "manrope",
                            ),
                          ),
                          SizedBox(height: 24),
                          Text('No payment method found',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff0D121C),
                              fontFamily: "manrope",
                            ),),
                            SizedBox(height: 24),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                minimumSize: const Size(185, 39),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(
                                    color: borderColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  paymentMethod = ! paymentMethod;
                                });
                              }, child: Text('Add Payment Method',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "manrope",
                              )),
                              ),
                        ],
                      ),
                    ):
                    Container(
                      height: 177,
                      width: double.infinity,
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Color(0xffF4F4F4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Row(children: [
                          Image.asset(
                            'assets/images/visa.png',
                            width: 70,
                            height: 50,
                          ),
                          SizedBox(width: 16),
                          Column(children: [
                            Text('Visa ending in 4242',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "manrope",
                                )),
                                SizedBox(height: 8),
                                Text('Expires on 10/2026',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff616161),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "manrope",
                                ))
                          ])
                        ],),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Spacer(),
                            ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    minimumSize: const Size(130, 39),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(
                                        color: borderColor,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      paymentMethod = ! paymentMethod;
                                    });
                                  }, child: Text('Replace Card',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "manrope",
                                  )),
                                  ),
                          ],
                        ),
                      ],),
                    ),
                    SizedBox(height: 24),
                    Divider(height: 1, color: borderColor),
                    SizedBox(height: 24),

                    Text("Billing History",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: "manrope",
                    )),
                    SizedBox(height: 24),
                    paymentMethod ? 
                    SizedBox(
                      height: 110,
                      child: Center(
                        child: Text('your invoice history will appear here',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff9F9F9F),
                            fontFamily: "manrope",
                            fontWeight: FontWeight.w600
                          ),),
                      ),
                      
                    )
                    : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            // ✅ Header مع زوايا من فوق
                            Row(
                              children: [
                                _buildCell(
                                  "invoice ID",
                                  isHeader: true,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12)),
                                ),
                                _buildCell(
                                  "Date",
                                  isHeader: true,
                                ),
                                _buildCell(
                                  "PLan",
                                  isHeader: true,
                                ),
                                _buildCell(
                                  "Amount",
                                  isHeader: true,
                                ),
                                _buildCell(
                                  "Pay Method",
                                  isHeader: true,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(12)),
                                ),
                              ],
                            ),

                            // ✅ خط تحت الهيدر
                            Divider(height: 1, color: Colors.grey.shade300),

                            // ✅ صف عادي
                            Row(
                              children: [
                                _buildCell("#INV-20250615"),
                                _buildCell("Jun 15, 2025"),
                                _buildCell("Advanced"),
                                _buildCell("499.99 L.E"),
                                _buildCell("Visa ending in 4242"),
                              ],
                            ),

                            // ✅ الصف الأخير مع زوايا تحت
                            Row(
                              children: [
                                _buildCell(
                                  "#INV-20250715",
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)),
                                ),
                                _buildCell(
                                  "Jul 15, 2025",
                                ),
                                _buildCell(
                                  "Advanced",
                                ),
                                _buildCell(
                                  "499.99 L.E",
                                ),
                                _buildCell(
                                  "Visa ending in 4242",
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(12)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
        ));
  }
}
