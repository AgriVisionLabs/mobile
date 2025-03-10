// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:grd_proj/screens/qr_scan.dart';

import '../Components/color.dart';

class Irrigation extends StatefulWidget {
  final Function(List, int) onInputChanged;
  final int currentIndex;
  const Irrigation(
      {super.key, required this.onInputChanged, required this.currentIndex});

  @override
  State<Irrigation> createState() => _IrrigationState();
}



class _IrrigationState extends State<Irrigation> {
  GlobalKey<FormState> formstate = GlobalKey();
  List<Map<String, dynamic>> myIrrigationList = [];
  TextEditingController ? serialNumberController ;
  String? irrigationUnitName;
  String serialNum = ' ';
  List field = [];
  bool addOne = true;
  int index = 0;
  void add() {
    if (formstate.currentState!.validate()) {
      field.add(irrigationUnitName);
      field.add(serialNum);
    }
  }
  
  void _onInputChanged(String serialNumScaned) {
    setState(() {
      print('=====================test=================$serialNumScaned======================================');
      serialNum = serialNumScaned;
      serialNumberController =TextEditingController(text: serialNum);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 380,
      height: 700,
      child: Form(
          key: formstate,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ///Field 1
            const Text('Irrigation Unit Name',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Enter Irrigation Unit Name",
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
                  return "Please Enter Irrigation Unit Name";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  irrigationUnitName = value;
                });
              },
            ),
            const SizedBox(height: 16),
    
            ///Field 2
            const Text('Serial Number',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            SizedBox(
              width: 380,
              height: 60,
              child: Row(
                children: [
                  SizedBox(
                    width: 297,
                    height: 60,
                    child: TextFormField(
                      controller: serialNumberController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter Serial Number",
                        hintStyle: const TextStyle(color: borderColor),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: borderColor, width: 3.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 3.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: errorColor, width: 3.0),
                        ),
                      ),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Serial Number";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          serialNum = value;
                        });
                      },
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: borderColor,
                          width: 2,
                        ),
                        color: Colors.white),
                    child: IconButton(
                        onPressed: () {
                          //add qr code handeler
                          Navigator.push(context , 
                          MaterialPageRoute(builder: (context) => QrScan(onInputChanged: _onInputChanged))
                          );
                        },
                        icon: const Center(
                          child: Icon(
                            Icons.qr_code_2,
                            size: 30,
                            color: borderColor,
                          )
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: addOne?primaryColor : borderColor,
                ),
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        if(addOne == true){
                          if (formstate.currentState!.validate()) {
                            myIrrigationList.add({
                            'name': irrigationUnitName,
                            'number': serialNum,
                          });
                            print(myIrrigationList);

                          addOne = false;
                            
                          } else {
                            print('Please Enter requested info');
                          }
                        }
                        
                      });
                    },
                    child: const SizedBox(
                      width: 380,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 3),
                          Icon(Icons.add, color: Colors.white, size: 20),
                          Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ))),
            const SizedBox(
              height: 10,
            ),
            myIrrigationList.isNotEmpty
                ? _buildIrrigationList()
                : const SizedBox(
                    height: 1,
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
                          if (myIrrigationList.isEmpty) {
                            formstate.currentState!.validate();
                            ScaffoldMessenger.of(context).clearSnackBars();
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Please Enter Irrigation Unit"),
                                ),
                              );
                            });
                          } else {
                            index = widget.currentIndex;
                            index++;
                            add();
                            widget.onInputChanged(field, index);
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


Widget _buildIrrigationList() {
  return SizedBox(
    width: 380,
    height: 260,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Added Irrigation Unit',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            )),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 380,
          height: 220,
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
              itemCount: myIrrigationList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Container(
                  width: 380,
                  height: 110,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(30, 105, 48, 0.15),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //Task Descrption
                          Text(
                            myIrrigationList[index]['name'],
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          
                      
                          Align(
                            heightFactor: 1,
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    myIrrigationList.removeAt(index);
                                    addOne = !addOne;
                                  });
                                }, 
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 18,
                                )),
                            ),
                          ),
                          //Due Date
                          Text('${myIrrigationList[index]['number']}',
                              style: const TextStyle(
                                fontFamily: 'Manrope',
                                color: borderColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                // decoration: TextDecoration.lineThrough
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    ),
  );
}
}