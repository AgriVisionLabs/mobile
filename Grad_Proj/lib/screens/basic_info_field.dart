import 'package:flutter/material.dart';

import '../Components/color.dart';

class BasicInfoField extends StatefulWidget {
  final Function(List , int) onInputChanged;
  final int currentIndex;
  const BasicInfoField(
      {super.key,required this.onInputChanged , required this.currentIndex});

  @override
  State<BasicInfoField> createState() => _BasicInfoFieldState();
}

class _BasicInfoFieldState extends State<BasicInfoField> {
  GlobalKey<FormState> formstate = GlobalKey();
  String fieldName = '';
  String fieldSize = '';
  String cropType = '';
  int  index =0 ;
  List  field = [] ;
  

  void add() {
    if (formstate.currentState!.validate()) {
      field.add(fieldName);
      field.add(fieldSize);
      field.add(cropType);
      index = widget.currentIndex;
      index++;
      widget.onInputChanged(field , index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 380,
      height: 530,
      child: Form(
          key: formstate,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ///Field 1
            const Text(
              'Field Name',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )),
            const SizedBox(height: 5),
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "Enter Field Name",
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
                  return "Please Enter Field Name";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  fieldName = value;
                });
              },
            ),
            const SizedBox(height: 10),

            ///Field 2
            const Text('Field Size (acres)',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )),
            const SizedBox(height: 5),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter Field Size",
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
                  return "Please Enter Field Size";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  fieldSize = value;
                });
              },
            ),
            const SizedBox(height: 10),

            ///Field 3
            const Text('Crop Type',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )),
            const SizedBox(height: 5),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Enter Crop Type",
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
                  return "Please Enter Crop Type";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  cropType = value;
                });
              },
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  height: 60,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: primaryColor,
                  ),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          add();
                        });
                      },
                      child: const SizedBox(
                        width: 70,
                        child: Row(
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 3),
                            Icon(Icons.arrow_forward_ios,
                                color: Colors.white, size: 20),
                          ],
                        ),
                      ))),
            )
          ])),
    );
  }
}
