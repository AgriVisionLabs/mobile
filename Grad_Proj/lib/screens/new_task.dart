// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/control_bloc/control_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/components/date_input_formatter.dart';
import 'package:grd_proj/screens/widget/text.dart';

// ignore: must_be_immutable

class NewTask extends StatefulWidget {
  final String farmId;
  const NewTask({super.key, required this.farmId});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  Map priority = {'Low': 0, 'Medium': 1, 'High': 2};
  Map category = {
    'Irrigation': 0,
    'Fertilization': 1,
    'PlantingOrHarvesting': 2,
    'Maintenance': 3,
    'Inspection': 4,
    "PestAndHealthControl": 5
  };
  int? selectedtype;
  int? selectedcat;
  String? selectedFieldId;
  @override
  void initState() {
    context.read<FieldBloc>().add(OpenFieldEvent(farmId: widget.farmId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          context.read<ControlBloc>().add(OpenFarmTasksEvent(
                farmId: widget.farmId,
              ));
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
                                          TextFormField(
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
                                                return "Please Enter Task Title";
                                              } else if (value.length < 3 ||
                                                  value.length > 100) {
                                                return "must be between 30 and 100 characters. You entered 2 characters.";
                                              }
                                              return null;
                                            },
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
                                          SizedBox(
                                            width: 410,
                                            height: 52,
                                            child:
                                                DropdownButtonFormField2<int>(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 15,
                                                        right: 15,
                                                        top: 10,
                                                        bottom: 10),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: const BorderSide(
                                                      color: borderColor,
                                                      width: 3),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: const BorderSide(
                                                      color: borderColor,
                                                      width: 3),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red,
                                                      width: 3),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red,
                                                      width: 3),
                                                ),
                                              ),
                                              isExpanded: true,
                                              hint: text(
                                                  fontSize: 18,
                                                  label: "select priority",
                                                  fontWeight: FontWeight.w600,
                                                  color: borderColor),
                                              value: selectedtype,
                                              items:
                                                  priority.entries.map((cat) {
                                                return DropdownMenuItem<int>(
                                                  value: cat.value,
                                                  child: Text(
                                                    cat.key!,
                                                    style: const TextStyle(
                                                      fontFamily: 'Manrope',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedtype = value;
                                                  context
                                                          .read<ControlBloc>()
                                                          .itemPriority
                                                          .text =
                                                      selectedtype!.toString();
                                                });
                                              },
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                maxHeight: 250,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: borderColor),
                                                ),
                                                elevation: 2,
                                                offset: const Offset(0, -5),
                                              ),
                                              iconStyleData:
                                                  const IconStyleData(
                                                icon: Icon(Icons
                                                    .keyboard_arrow_down_rounded),
                                                iconSize: 40,
                                                iconEnabledColor: Colors.black,
                                              ),
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
                                          SizedBox(
                                            width: 410,
                                            height: 52,
                                            child: DropdownButtonFormField2<
                                                String>(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 15,
                                                        right: 15,
                                                        top: 10,
                                                        bottom: 10),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: const BorderSide(
                                                      color: borderColor,
                                                      width: 3),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: const BorderSide(
                                                      color: borderColor,
                                                      width: 3),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red,
                                                      width: 3),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red,
                                                      width: 3),
                                                ),
                                              ),
                                              isExpanded: true,
                                              hint: text(
                                                  fontSize: 18,
                                                  label: "select field",
                                                  fontWeight: FontWeight.w600,
                                                  color: borderColor),
                                              value: selectedFieldId,
                                              items: state.fields.map((field) {
                                                return DropdownMenuItem<String>(
                                                  value: field.id,
                                                  child: Text(
                                                    field.name,
                                                    style: const TextStyle(
                                                      fontFamily: 'Manrope',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedFieldId = value;
                                                });
                                              },
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                maxHeight: 250,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: borderColor),
                                                ),
                                                elevation: 2,
                                                offset: const Offset(0, -5),
                                              ),
                                              iconStyleData:
                                                  const IconStyleData(
                                                icon: Icon(Icons
                                                    .keyboard_arrow_down_rounded),
                                                iconSize: 40,
                                                iconEnabledColor: Colors.black,
                                              ),
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
                                          SizedBox(
                                            width: 410,
                                            height: 52,
                                            child:
                                                DropdownButtonFormField2<int>(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 15,
                                                        right: 15,
                                                        top: 10,
                                                        bottom: 10),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: const BorderSide(
                                                      color: borderColor,
                                                      width: 3),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: const BorderSide(
                                                      color: borderColor,
                                                      width: 3),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red,
                                                      width: 3),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red,
                                                      width: 3),
                                                ),
                                              ),
                                              isExpanded: true,
                                              hint: text(
                                                  fontSize: 18,
                                                  label: "select category",
                                                  fontWeight: FontWeight.w600,
                                                  color: borderColor),
                                              value: selectedcat,
                                              items:
                                                  category.entries.map((cat) {
                                                return DropdownMenuItem<int>(
                                                  value: cat.value,
                                                  child: Text(
                                                    cat.key!,
                                                    style: const TextStyle(
                                                      fontFamily: 'Manrope',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedcat = value;
                                                  context
                                                          .read<ControlBloc>()
                                                          .category
                                                          .text =
                                                      selectedcat!.toString();
                                                });
                                              },
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                maxHeight: 250,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: borderColor),
                                                ),
                                                elevation: 2,
                                                offset: const Offset(0, -5),
                                              ),
                                              iconStyleData:
                                                  const IconStyleData(
                                                icon: Icon(Icons
                                                    .keyboard_arrow_down_rounded),
                                                iconSize: 40,
                                                iconEnabledColor: Colors.black,
                                              ),
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
                                                  if (selectedFieldId == null || selectedcat == null || selectedtype == null) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          AlertDialog(
                                                        title: const Text(
                                                            "ِAlert",
                                                            style: TextStyle(
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "manrope",
                                                              color:
                                                                  primaryColor,
                                                            )),
                                                        backgroundColor:
                                                            Colors.white,
                                                        content: const Text(
                                                            "Please Enter Requested Information",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "manrope",
                                                              color:
                                                                  Colors.black,
                                                            )),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: const Text(
                                                                "Cancle",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      "manrope",
                                                                  color: Colors
                                                                      .black,
                                                                )),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "Ok",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      "manrope",
                                                                  color:
                                                                      primaryColor,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    );
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
