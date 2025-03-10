import 'package:flutter/material.dart';

import '../Components/color.dart';

class Team extends StatefulWidget {
  final Function(List, int) onInputChanged;
  final int currentIndex;
  final bool editFarm ;
   const Team(
      {super.key, required this.onInputChanged, required this.currentIndex ,this.editFarm = false});

  @override
  State<Team> createState() => _TeamState();
}

List<Map<String, dynamic>> myRoleList = [];

class _TeamState extends State<Team> {
  GlobalKey<FormState> formstate = GlobalKey();
  String? userName;
  String? selectedValue;
  List farm = [];
  bool addedRole = false;
  int index = 0;
  List<String> role = ['Manager', 'Owner', 'Worker', 'Export'];
  Map<String, dynamic> myRoleListEdit = {'name' : 'Hessian' , 'role' : 'Manager'};
  void add() {
    if (formstate.currentState!.validate()) {
      farm.add(userName);
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
            const Text('Email or Username',
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
                hintText: widget.editFarm? myRoleListEdit['name'] : "Enter Email or Username",
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
                  return "Please Enter User Name";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  userName = value;
                });
              },
            ),
            const SizedBox(height: 16),

            ///Field 2
            const Text('Role',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    width: 280,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: borderColor, width: 3)),
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      hint: Text(widget.editFarm ? myRoleListEdit['role'] : 'Manger'),
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
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      },
                      items:
                          role.map<DropdownMenuItem<String>>((dynamic value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor,
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          ///add code
                          if (selectedValue == null) {
                            formstate.currentState!.validate();
                            ScaffoldMessenger.of(context).clearSnackBars();
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Please Enter Role"),
                                ),
                              );
                            });
                          } else {
                            myRoleList.add({
                              'name': userName,
                              'role': selectedValue,
                            });
                            add();
                            addedRole = true;
                          }
                        });
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.editFarm?_buildRolesList(): myRoleList.isNotEmpty
                ? _buildRolesList()
                : const SizedBox(
                    height: 1,
                  ),
            const Spacer(),
            widget.editFarm ?
            const SizedBox(height: 1,)
            : Align(
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
                          if (selectedValue == null) {
                            formstate.currentState!.validate();
                            ScaffoldMessenger.of(context).clearSnackBars();
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Please Enter Soil Type"),
                                ),
                              );
                            });
                          } else {
                            index = widget.currentIndex;
                            index++;
                            if(addedRole){
                              widget.onInputChanged(farm, index);
                            }
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


Widget _buildRolesList() {
  ///team members part
  return SizedBox(
    width: 390,
    height: 260,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      
        const Text('Team Members',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            )),
        const SizedBox(
          height: 8,
        ),


        ///scrollabel part contain team members 
        SizedBox(
          width: 380,
          height: 220,

          //list of members
          child: ListView.builder(
              ///length is list of all members added by user
              itemCount: widget.editFarm ?1 : myRoleList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {

                //green box contain each member
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 12 , horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(30, 105, 48, 0.15),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  ///used to give constant layout to all added members
                  child: ListTile(
                    title: Row(
                      children: [

                        //name
                        Text(
                          widget.editFarm ? 'Hessian':
                          myRoleList[index]['name'],
                          style: const TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            // decoration: TextDecoration.lineThrough
                          ),
                        ),


                        const Spacer(),

                        //role
                        Text(widget.editFarm ? 'Manager':
                          myRoleList[index]['role'],
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              // decoration: TextDecoration.lineThrough
                            ))
                      ],
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