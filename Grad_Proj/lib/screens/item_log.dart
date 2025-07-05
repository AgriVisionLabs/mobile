import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/control_bloc/control_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/screens/widget/text.dart';

class ItemLog extends StatefulWidget {
  final String farmId;
  final String itemId;
  final String itemName;
  const ItemLog(
      {super.key,
      required this.farmId,
      required this.itemId,
      required this.itemName});

  @override
  State<ItemLog> createState() => _ItemLogState();
}

class _ItemLogState extends State<ItemLog> {
  int? selectedReason;
  Map reason = {
    "Initial Stock": 0,
    "Restock": 1,
    "Usage": 2,
    "Expired": 3,
    "Transfer": 4
  };
  ControlBloc? _controlBloc;
  @override
  void initState() {
    _controlBloc = context.read<ControlBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _controlBloc!.add(OpenFarmItemsEvent(farmId: widget.farmId));
    _controlBloc!.quantity.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    

    return BlocConsumer<ControlBloc, ControlState>(
      listener: (context, state) {
        if (state is ChangeLogSuccess) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Log Changed Successfuly"),
              ),
            );
          });
          Navigator.pop(context);
        } else if (state is ChangeLogFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
        }
        _controlBloc!.logFormKey.currentState!.validate();
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
              margin: const EdgeInsets.only(top: 50, left: 16, right: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Update Item: ',
                                style: TextStyle(
                                  color: primaryColor,
                                ),
                              ),
                              TextSpan(
                                text: widget.itemName,
                                style: const TextStyle(
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                    const SizedBox(
                      height: 24,
                    ),
                    Form(
                      key: _controlBloc!.logFormKey,
                      child: SizedBox(
                        height: 720,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text(
                                fontSize: 20,
                                label: "Quentity",
                                fontWeight: FontWeight.w600),
                            const SizedBox(height: 5),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _controlBloc!.quantity,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 17),
                                hintText: "Enter quentity",
                                hintStyle: const TextStyle(color: borderColor),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: const BorderSide(
                                      color: borderColor, width: 3.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: const BorderSide(
                                      color: primaryColor, width: 3.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: const BorderSide(
                                      color: errorColor, width: 3.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: const BorderSide(
                                      color: errorColor, width: 3.0),
                                ),
                              ),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter The Quentity";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            text(
                                fontSize: 20,
                                label: "ٌReason",
                                fontWeight: FontWeight.w600),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: 400,
                              height: 57,
                              child: DropdownButtonFormField2<int>(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 10, bottom: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                        color: borderColor, width: 3),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                        color: borderColor, width: 3),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 3),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 3),
                                  ),
                                ),
                                isExpanded: true,
                                hint: text(
                                    fontSize: 18,
                                    label: "select reason",
                                    fontWeight: FontWeight.w600,
                                    color: borderColor),
                                value: selectedReason,
                                items: reason.entries.map((cat) {
                                  return DropdownMenuItem<int>(
                                    value: cat.value,
                                    child: Text(
                                      cat.key!,
                                      style: const TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedReason = value;
                                    _controlBloc!.reason.text =
                                        selectedReason.toString();
                                  });
                                },
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    border: Border.all(color: borderColor),
                                  ),
                                  elevation: 2,
                                  offset: const Offset(0, -5),
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                                  iconSize: 40,
                                  iconEnabledColor: Colors.black,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            0, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: testColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Cancle",
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontFamily: "Manrope",
                                            fontWeight: FontWeight.w600,
                                            color: testColor,
                                          ),
                                        ),
                                      ),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _controlBloc!.add(AddLogEvent(
                                        farmId: widget.farmId,
                                        itemId: widget.itemId));
                                  },
                                  child: Container(
                                    width: 160,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: const Color(0xFF616161),
                                        width: 1,
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Log Change",
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontFamily: "Manrope",
                                          fontWeight: FontWeight.w600,
                                          color: whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    )
                  ]),
            )),
          ),
        );
      },
    );
  }
}
