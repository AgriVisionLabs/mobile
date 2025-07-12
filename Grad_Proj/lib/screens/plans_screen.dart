// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/components/plans.dart';
import 'package:grd_proj/screens/widget/text.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  int isSelected = CacheHelper.getData(key: "plan") ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.all(16),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: PlansData().items.length,
                (context, index) {
                  final item = PlansData().items[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.only(top: 24),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: const Color.fromARGB(62, 13, 18, 28),
                            width: 1),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(50, 0, 0, 0),
                              blurRadius: 15,
                              spreadRadius: 0.7,
                              offset: Offset(0, 2.25))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(item.title,
                                      style: const TextStyle(
                                        color: Color(0xff1E6930),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "manrope",
                                      )),
                                  const Spacer(),
                                  Text(
                                    item.price,
                                    style: const TextStyle(
                                        color: primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/check.png',
                                    color: primaryColor,
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(item.numberOfFarms,
                                      style: const TextStyle(
                                        color: testColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "manrope",
                                      )),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/check.png',
                                    color: primaryColor,
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(item.numberOfFields,
                                      style: const TextStyle(
                                        color: testColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "manrope",
                                      )),
                                ],
                              ),
                              const SizedBox(height: 16),
                              text(
                                  fontSize: 22,
                                  label: "Features",
                                  fontWeight: FontWeight.w600),
                              Container(
                                height: 257,
                                width: 332,
                                child: ListView.builder(
                                    itemCount: item.features.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: Image.asset(
                                          'assets/images/check.png',
                                          color: primaryColor,
                                          height: 24,
                                          width: 24,
                                        ),
                                        title: text(
                                            fontSize: 18,
                                            label: item.features[index],
                                            fontWeight: FontWeight.w600),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Divider(
                          color: borderColor,
                          thickness: 1,
                        ),
                        SizedBox(height: 16,),
                        Center(
                          child: Container(
                              height: 45,
                              width: 332,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              decoration: BoxDecoration(color: isSelected== index ? grayColor : primaryColor,
                              borderRadius: BorderRadius.circular(25)),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: text(
                                      fontSize: 18,
                                      label: index != 2
                                          ? "Change"
                                          : "Contact Sales",
                                          color: isSelected== index ? borderColor :bottomBarColor),
                                ),
                              )),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
