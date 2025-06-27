// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/bloc/control_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/components/date_input_formatter.dart';

// ignore: must_be_immutable

class NewTask extends StatefulWidget {
  final String farmId;
  const NewTask({super.key, required this.farmId});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  Map priority = {'Low': 0, 'Medium': 1, 'High': 2};
  Map category = {'Irrigation': 0, 'Fertilization': 1, 'PlantingOrHarvesting': 2 ,'Maintenance': 3, 'Inspection': 4 , "PestAndHealthControl" : 5};
  int? selectedtype;
  String? selectedFieldId;
  @override
  Widget build(BuildContext context) {
    context.read<FieldBloc>().add(OpenFieldEvent(farmId: widget.farmId));
    return BlocConsumer<ControlBloc, ControlState>(
      listener: (context, state) {
        if (state is AddTaskSuccess) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Task created successfuly"),
              ),
            );
          });
          Navigator.pop(context);
        } else if (state is AddTaskFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
        }
        context.read<ControlBloc>().taskFormKey.currentState!.validate();
      },
      builder: (context, state) {
        return BlocBuilder<FieldBloc, FieldState>(
          builder: (context, state) {
            if (state is FieldLoadingFailure) {
              return Scaffold(
                body: Center(
                  child: Text(
                    "Something went wrong",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              );
            } else if (state is FieldLoaded) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 30, 16, 24),
                  child: SizedBox(
                      height: MediaQuery.sizeOf(context).height,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Create New Task",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.grey[600],
                                      size: 24,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Add a new task to the selected farm.",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Manrope",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(
                                height: 21,
                              ),
                              SizedBox(
                                child: Form(
                                    key:
                                        context.read<ControlBloc>().taskFormKey,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Task Title",
                                            style: TextStyle(
                                              fontSize: 21,
                                              fontFamily: "Manrope",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            height: 50,
                                            child: TextFormField(
                                              controller: context
                                                  .read<ControlBloc>()
                                                  .title,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Enter a descriptive title',
                                                hintStyle: TextStyle(
                                                  color: borderColor,
                                                  fontFamily: "Manrope",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 14),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: const BorderSide(
                                                      color: borderColor,
                                                      width: 3.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: const BorderSide(
                                                      color: primaryColor,
                                                      width: 3.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: const BorderSide(
                                                      color: errorColor,
                                                      width: 3.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: const BorderSide(
                                                      color: errorColor,
                                                      width: 3.0),
                                                ),
                                              ),
                                              autocorrect: false,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please Enter Irrigation Unit Name";
                                                } else if (value.length < 3 ||
                                                    value.length > 100) {
                                                  return "must be between 30 and 100 characters. You entered 2 characters.";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            "Description",
                                            style: TextStyle(
                                              fontSize: 21,
                                              fontFamily: "Manrope",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            height: 130,
                                            child: Expanded(
                                              child: TextFormField(
                                                controller: context
                                                    .read<ControlBloc>()
                                                    .description,
                                                keyboardType:
                                                    TextInputType.text,
                                                expands: true,
                                                maxLines: null,
                                                minLines: null,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Enter detailes about the task',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                    fontFamily: "Manrope",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 16,
                                                          vertical: 14),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: borderColor,
                                                            width: 3.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: primaryColor,
                                                            width: 3.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: errorColor,
                                                            width: 3.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: errorColor,
                                                            width: 3.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            "Priority",
                                            style: TextStyle(
                                              fontSize: 21,
                                              fontFamily: "Manrope",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          //here we need dropdown menu number1
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 20),
                                            width: 320,
                                            height: 53,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                border: Border.all(
                                                    color: borderColor,
                                                    width: 2.5)),
                                            child: DropdownButtonFormField<int>(
                                              hint: const Text("All Types",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "manrope",
                                                  )),
                                              dropdownColor: Colors.white,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              value: selectedtype,
                                              isExpanded: true,
                                              icon: Image.asset(
                                                'assets/images/arrow.png',
                                                color: borderColor,
                                              ),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedtype = newValue;
                                                  context
                                                          .read<ControlBloc>()
                                                          .category
                                                          .text =
                                                      selectedtype!.toString();
                                                });
                                              },
                                              items: priority.entries
                                                  .map<DropdownMenuItem<int>>(
                                                      (type) {
                                                return DropdownMenuItem(
                                                  value: type.value,
                                                  child: Text(type.key),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),

                                          Text(
                                            "Field",
                                            style: TextStyle(
                                              fontSize: 21,
                                              fontFamily: "Manrope",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          //here we need dropdown menu number2
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 20),
                                            width: 320,
                                            height: 53,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                border: Border.all(
                                                    color: borderColor,
                                                    width: 2.5)),
                                            child:
                                                DropdownButtonFormField<String>(
                                              hint: const Text("All Fields",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "manrope",
                                                  )),
                                              dropdownColor: Colors.white,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              value: selectedFieldId,
                                              isExpanded: true,
                                              icon: Image.asset(
                                                'assets/images/arrow.png',
                                                color: borderColor,
                                              ),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedFieldId = newValue;
                                                });
                                              },
                                              items: state.fields.map<
                                                      DropdownMenuItem<String>>(
                                                  (field) {
                                                return DropdownMenuItem<String>(
                                                  value: field.id,
                                                  child: Text(field.name),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            "Category",
                                            style: TextStyle(
                                              fontSize: 21,
                                              fontFamily: "Manrope",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          //here we need dropdown menu number1
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 20),
                                            width: 320,
                                            height: 53,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                border: Border.all(
                                                    color: borderColor,
                                                    width: 2.5)),
                                            child: DropdownButtonFormField<int>(
                                              hint: const Text("All Types",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "manrope",
                                                  )),
                                              dropdownColor: Colors.white,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              value: selectedtype,
                                              isExpanded: true,
                                              icon: Image.asset(
                                                'assets/images/arrow.png',
                                                color: borderColor,
                                              ),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedtype = newValue;
                                                  context
                                                          .read<ControlBloc>()
                                                          .itemPriority
                                                          .text =
                                                      selectedtype!.toString();
                                                  context
                                                      .read<ControlBloc>()
                                                      .category
                                                      .text = "1";
                                                });
                                              },
                                              items: category.entries
                                                  .map<DropdownMenuItem<int>>(
                                                      (type) {
                                                return DropdownMenuItem(
                                                  value: type.value,
                                                  child: Text(type.key),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            "Due Date",
                                            style: TextStyle(
                                              fontSize: 21,
                                              fontFamily: "Manrope",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            height: 60,
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: context
                                                  .read<ControlBloc>()
                                                  .dueDate,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                    8),
                                                DateInputFormatter()
                                              ],
                                              decoration: InputDecoration(
                                                hintText: 'YYYY-MM-DD',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400]),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 14),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: const BorderSide(
                                                      color: borderColor,
                                                      width: 3.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: const BorderSide(
                                                      color: primaryColor,
                                                      width: 3.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: const BorderSide(
                                                      color: errorColor,
                                                      width: 3.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: const BorderSide(
                                                      color: errorColor,
                                                      width: 3.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 70),
                                          //After adding the dropdown menus make sure to add the buttons below are at the end of the screen by adjusting the previous sizedbox()
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: 99,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                      color: Colors.grey[700]!,
                                                      width: 1.8,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: "Manrope",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              GestureDetector(
                                                onTap: () {
                                                  if (selectedFieldId == null) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .clearSnackBars();
                                                    WidgetsBinding.instance
                                                        .addPostFrameCallback(
                                                            (_) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              "Please choose field"),
                                                        ),
                                                      );
                                                    });
                                                  } else {
                                                    context
                                                        .read<ControlBloc>()
                                                        .add(AddTaskEvent(
                                                            farmId:
                                                                widget.farmId,
                                                            fieldId:
                                                                selectedFieldId!));
                                                  }
                                                },
                                                child: Container(
                                                  width: 140,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Creat Task",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: "Manrope",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ])),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              );
            }
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
