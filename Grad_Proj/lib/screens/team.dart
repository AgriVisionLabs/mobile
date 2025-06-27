import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';
import 'package:grd_proj/models/invation_model.dart';

import '../Components/color.dart';

class Team extends StatefulWidget {
  final Function(int) onInputChanged;
  final int currentIndex;
  final String farmId;
  const Team(
      {super.key,
      required this.onInputChanged,
      required this.currentIndex,
      required this.farmId});

  @override
  State<Team> createState() => _TeamState();
}

List<InvitationModel>? myRoleList = [];

class _TeamState extends State<Team> {
  GlobalKey<FormState> formstate = GlobalKey();
  String? userName;
  String? selectedValue;
  String description = '';
  bool addedRole = false;
  int index = 0;
  int? pos;
  List<String> role = ['Manager', 'Owner', 'Worker', 'Export'];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FarmBloc, FarmState>(
      listener: (context, state) {
        if (state is LoadingMember) {
          myRoleList = state.invites;
        } else if (state is NoMember) {
          myRoleList = [];
        }
        if (state is AddingMember) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Member added successfuly"),
              ),
            );
          });
          context.read<FarmBloc>().add(ViewFarmMembers(farmId: widget.farmId));
        } else if (state is AddingMemberFailure) {
          if (state.errMessage == 'Conflict') {
            description = state.errors[0]['description'];
            ScaffoldMessenger.of(context).clearSnackBars();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(description),
                ),
              );
            });
          } else {
            ScaffoldMessenger.of(context).clearSnackBars();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMessage),
                ),
              );
            });
          }
          context.read<FarmBloc>().addMembermKey.currentState!.validate();
        }
        if (state is DeletingMember) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Member Deleted successfuly"),
              ),
            );
          });
          context.read<FarmBloc>().add(ViewFarmMembers(farmId: widget.farmId));
        } else if (state is DeletingMemberFailure) {
          if (state.errMessage == 'Conflict') {
            description = state.errors[0]['description'];
            ScaffoldMessenger.of(context).clearSnackBars();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(description),
                ),
              );
            });
          } else {
            ScaffoldMessenger.of(context).clearSnackBars();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMessage),
                ),
              );
            });
          }
        }
      },
      builder: (context, state) {
        return Container(
          color: Colors.white,
          width: 380,
          height: 680,
          child: Form(
              key: context.read<FarmBloc>().addMembermKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      controller: context.read<FarmBloc>().recipient,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 17),
                        hintText: "Enter Email or Username",
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
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: errorColor, width: 3.0),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 1),
                            width: 280,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border:
                                    Border.all(color: borderColor, width: 3)),
                            child: DropdownButton(
                              dropdownColor: Colors.white,
                              isExpanded: true,
                              hint: const Text('Manger'),
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
                              items: role.map<DropdownMenuItem<String>>(
                                  (dynamic value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: primaryColor,
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  if (selectedValue == null) {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("Please Enter Role"),
                                        ),
                                      );
                                    });
                                  } else {
                                    addedRole = true;
                                    context.read<FarmBloc>().roleName.text =
                                        selectedValue!;
                                    context
                                        .read<FarmBloc>()
                                        .add(AddMember(farmId: widget.farmId));
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
                    myRoleList!.isNotEmpty
                        ? _buildRolesList()
                        : const SizedBox(
                            height: 1,
                          ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: primaryColor,
                          ),
                          child: TextButton(
                              onPressed: () {
                                index = widget.currentIndex;
                                index++;
                                widget.onInputChanged(index);
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
      },
    );
  }

  Widget _buildRolesList() {
    ///team members part
    return SizedBox(
      width: 400,
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
            width: 400,
            height: 220,

            //list of members
            child: ListView.builder(

                ///length is list of all members added by user
                itemCount: myRoleList!.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  //green box contain each member
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                    padding: const EdgeInsets.symmetric(vertical: 5),
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
                            myRoleList![index].receiverUserName,
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              // decoration: TextDecoration.lineThrough
                            ),
                          ),

                          const SizedBox(
                            width: 150,
                          ),

                          //role
                          Text(myRoleList![index].roleName,
                              style: const TextStyle(
                                fontFamily: 'Manrope',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                // decoration: TextDecoration.lineThrough
                              )),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  context.read<FarmBloc>().add(DeleteMember(
                                      invitationId: myRoleList![index].id,
                                      farmId: widget.farmId));
                                  pos = index;
                                });
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.black,
                                size: 18,
                              )),
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
