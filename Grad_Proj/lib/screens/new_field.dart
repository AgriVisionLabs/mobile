import 'package:flutter/material.dart';
import 'package:grd_proj/screens/basic_info_field.dart';
import 'package:grd_proj/screens/irrigation.dart';
import 'package:grd_proj/screens/review_field.dart';
import 'package:grd_proj/screens/sensor.dart';
import '../Components/color.dart';

class NewFeild extends StatefulWidget {
  final List feild;
  const NewFeild({super.key, required this.feild});

  @override
  State<NewFeild> createState() => _NewFeildState();
}

class _NewFeildState extends State<NewFeild> {
  int currentIndex = 0;
  List field = [];
  void _onInputChanged(List value, int index) {
    setState(() {
      field.add(value);
      currentIndex = index;
      // ignore: avoid_print
      print(field);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Top Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  pageTop(),
                  const SizedBox(height: 40),
                  buildDots(),
                ],
              ),
            ),

            // Scrollable Form Section
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    if (currentIndex == 0)
                      BasicInfoField(
                          onInputChanged: _onInputChanged,
                          currentIndex: currentIndex)
                    else if (currentIndex == 1)
                      Irrigation(
                          onInputChanged: _onInputChanged,
                          currentIndex: currentIndex)
                    else if (currentIndex == 2)
                      Sensor(
                          onInputChanged: _onInputChanged,
                          currentIndex: currentIndex)
                    else
                      ReviewField(
                        field: field,
                      ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pageTop() {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: 390,
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (currentIndex > 0) {
                      currentIndex--;
                      // ignore: avoid_print
                      print('stop');
                    }else if(currentIndex == 0){
                      Navigator.pop(context);
                    }
                  });
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                  size: 24,
                )),
            const Spacer(),
            const Text('Add New Feild',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                )),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close_rounded,
                  color: Color(0xff757575), size: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicatorItem(
    int index,
  ) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: currentIndex == index
          ? primaryColor
          : const Color.fromRGBO(30, 105, 48, 0.25),
      child: Text(
        (index + 1).toString(),
        style: const TextStyle(
            fontFamily: 'Manrope',
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget buildDots() {
    return SizedBox(
        width: 380,
        height: 60,
        child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildIndicatorItem(index),
                      const SizedBox(height: 7),
                      Text(
                          index == 0
                              ? 'Basic Info'
                              : index == 1
                                  ? 'Irrigation'
                                  : index == 2
                                      ? 'Sensor'
                                      : 'Review',
                          style: const TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400))
                    ],
                  ),
                  Container(
                    width: 44,
                    height: 1,
                    color: const Color(0xFF333333),
                  ),
                ],
              );
            }));
  }
}

//   Widget button() {
//     return Align(
//       alignment: Alignment.bottomRight,
//       child: Container(
//           height: 60,
//           padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: primaryColor,
//           ),
//           child: TextButton(
//               onPressed: () {
//                 setState(() {
//                   if (currentIndex != 2) {
//                     currentIndex = currentIndex + 1;
//                   } else {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => const Test()),
//                     );
//                   }
//                 });
//               },
//               child: currentIndex < 2
//                   ? const SizedBox(
//                       width: 70,
//                       child: Row(
//                         children: [
//                           Text(
//                             'Next',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(width: 3),
//                           Icon(Icons.arrow_forward_ios,
//                               color: Colors.white, size: 20),
//                         ],
//                       ),
//                     )
//                   : const Text(
//                       'Create Farm',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ))),
//     );
//   }
// }
