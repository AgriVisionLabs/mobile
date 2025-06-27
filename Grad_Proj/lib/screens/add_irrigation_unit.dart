import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/screens/irrigation.dart';
import 'package:grd_proj/screens/select_field.dart';
import '../Components/color.dart';

class AddIrrigationUnit extends StatefulWidget {
  final String farmId;
  const AddIrrigationUnit({super.key, required this.farmId});

  @override
  State<AddIrrigationUnit> createState() => _AddIrrigationUnitState();
}

class _AddIrrigationUnitState extends State<AddIrrigationUnit> {
  String? selectedValue;

  int currentIndex = 0;
  List field = [];
  void _onInputChanged(int index) {
    setState(() {
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

            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    if (currentIndex == 0)
                      SelectField(
                          farmId: widget.farmId,
                          onInputChanged: _onInputChanged,
                          currentIndex: currentIndex)
                    else if (currentIndex == 1)
                      Irrigation(
                        fieldId: CacheHelper.getData(key: 'fieldId'),
                        farmId: widget.farmId,
                        onInputChanged: _onInputChanged,
                        currentIndex: currentIndex,
                        form: false,
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
        height: 95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (currentIndex > 0) {
                          currentIndex--;
                          // ignore: avoid_print
                          print('stop');
                        } else if (currentIndex == 0) {
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
                const Text('Add New Irrigation Unit',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      color: primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    )),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    context.read<FieldBloc>().add(OpenFarmIrrigationUnitsEvent(
                          farmId: widget.farmId,
                        ));
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close_rounded,
                      color: Color(0xff757575), size: 24),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Add new irrigation unit to a field',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                )),
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
        width: 317,
        height: 60,
        child: ListView.builder(
            itemCount: 2,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildIndicatorItem(index),
                      const SizedBox(height: 7),
                      Text(index == 0 ? 'select field' : 'Add irrigation',
                          style: const TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400))
                    ],
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 25, left: 10, right: 10),
                    width: 100,
                    height: 1,
                    color: const Color(0xFF333333),
                  ),
                ],
              );
            }));
  }
}
