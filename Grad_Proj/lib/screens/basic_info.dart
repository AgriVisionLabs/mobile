import 'package:flutter/material.dart';

import '../Components/color.dart';

class BasicInfo extends StatefulWidget {
  final Function(List, int) onInputChanged;
  final int currentIndex;
  final bool editFarm ;
  const BasicInfo(
      {super.key, required this.onInputChanged, required this.currentIndex , this.editFarm = false});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  GlobalKey<FormState> formstate = GlobalKey();
  String farmName = '';
  String farmSize = '';
  String farmLocation = '';
  String? selectedValue;
  int index = 0;
  List farm = [];
  List<String> soil = ['Sandy', 'Clay', 'Loamy'];
  List editFarm = ['Green Farm','900','Ismailia','Clay'];

  void add() {
    if (formstate.currentState!.validate()) {
      farm.add(farmName);
      farm.add(farmSize);
      farm.add(farmLocation);
      farm.add(selectedValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 380,
      height: 630,
      child: Form(
          key: formstate,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ///Field 1
            const Text('Farm Name',
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
                hintText: widget.editFarm ? editFarm[0] :
                "Enter Farm Name",
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
                  return "Please Enter Farm Name";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  farmName = value;
                });
              },
            ),
            const SizedBox(height: 10),

            ///Field 2
            const Text('Farm Size (acres)',
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
                hintText: widget.editFarm ? editFarm[1] :"Enter Farm Size",
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
                  return "Please Enter Farm Size";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  farmSize = value;
                });
              },
            ),
            const SizedBox(height: 10),

            ///Field 3
            const Text('Farm Location',
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
                hintText: widget.editFarm ? editFarm[2] :"Enter Farm Location",
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
                  return "Please Enter Farm Location";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  farmLocation = value;
                });
              },
            ),
            const SizedBox(height: 10),

            ///Field 4
            const Text('Soil Type',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              width: 390,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: borderColor, width: 3)),
              child: DropdownButton(
                dropdownColor: Colors.white,
                isExpanded: true,
                hint: Text(widget.editFarm ? editFarm[3] : 'Soil Type'),
                style: const TextStyle(
                    fontFamily: 'Manrope',
                    color: borderColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
                value: selectedValue,
                icon: const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: borderColor,
                  size: 40,
                ),
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                items: soil.map<DropdownMenuItem<String>>((dynamic value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const Spacer(),
            widget.editFarm ? const SizedBox(height: 1,) : Align(
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
                          if (selectedValue == null ) {
                            formstate.currentState!.validate();
                            ScaffoldMessenger.of(context).clearSnackBars();
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please Enter Soil Type"),
                                ),
                              );
                            });
                          }else if(widget.editFarm == true){
                            index = widget.currentIndex;
                            index++;
                            widget.onInputChanged(farm, index);
                          }
                           else {
                            add();
                            index = widget.currentIndex;
                            index++;
                            widget.onInputChanged(farm, index);
                          }
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
