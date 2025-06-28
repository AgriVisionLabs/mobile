import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/field_model.dart';
import 'package:grd_proj/models/irrigation_model.dart';
import 'package:intl/intl.dart';

class SensorEdit extends StatefulWidget {
  final String farm;
  final String field;
  final String sensorId;
  const SensorEdit({super.key, required this.farm, required this.field, required this.sensorId});

  @override
  State<SensorEdit> createState() => _SensorEditState();
}

class _SensorEditState extends State<SensorEdit> {
  bool tell = true;
  Map status = {'Active': 0, 'Inactive': 1, 'Mantenance': 2};
  int? selectedtype;
  String? selectedFieldId;
  IrrigationDevice? device;
  List<FieldModel>? fields;

  @override
  void initState() {
    context.read<FieldBloc>().add(OpenFieldSensorUnitsEvent(
      sensorId: widget.sensorId,
        farmId: widget.farm, fieldId: widget.field));
    context.read<FieldBloc>().add(OpenFieldEvent(farmId: widget.farm));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FieldBloc, FieldState>(
      listener: (context, state) {
        if (state is ViewFieldSensorUnitFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
        } else if (state is ViewFieldIrrigationUnitSuccess) {
          device = state.device;
          context.read<FieldBloc>().sensorUnitName.text = device!.name;
          selectedtype = device!.status;
          selectedFieldId = device!.fieldId;
        } else if (state is FieldLoaded) {
          fields = state.fields;
        } else if (state is SensorUnitEditFailure) {
          context
              .read<FieldBloc>()
              .addIrrigationUnitFormKey
              .currentState!
              .validate();
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
        } else if (state is SensorUnitEditSuccess) {
          context
              .read<FieldBloc>()
              .add(OpenFarmIrrigationUnitsEvent(farmId: device!.farmId));
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Container(
            height: double.infinity,
            margin: const EdgeInsets.all(24),
            child: device == null || fields == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  )
                : SizedBox(
                    width: 380,
                    height: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Form(
                        key: context.read<FieldBloc>().addSensorUnitFormKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/Group.png',
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: TextFormField(
                                        controller: context
                                            .read<FieldBloc>()
                                            .sensorUnitName,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          hintText: device!.name,
                                          hintStyle: const TextStyle(
                                            color: borderColor,
                                            fontFamily: "Manrope",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 14),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: const BorderSide(
                                                color: borderColor, width: 2.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: const BorderSide(
                                                color: primaryColor,
                                                width: 2.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: const BorderSide(
                                                color: errorColor, width: 2.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: const BorderSide(
                                                color: errorColor, width: 2.0),
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
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        context.read<FieldBloc>().add(
                                            OpenFarmIrrigationUnitsEvent(
                                                farmId: device!.farmId));
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.close_rounded,
                                          color: Color(0xff757575), size: 24),
                                    ),
                                  ]),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text('Irrigation Unit Details',
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    color: Color(0xFF616161),
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                  )),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        context.read<FieldBloc>().add(
                                            OpenFarmIrrigationUnitsEvent(
                                                farmId: device!.farmId));
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 99,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: const Color(0xFF616161),
                                            width: 1,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Cancle",
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontFamily: "Manrope",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context.read<FieldBloc>().add(
                                            IrrigationUnitsEditEvent(
                                                farmId: device!.farmId,
                                                fieldId: device!.fieldId,
                                                name: context
                                                    .read<FieldBloc>()
                                                    .irrigationUnitName
                                                    .text,
                                                newFieldId: selectedFieldId!,
                                                status: selectedtype!));
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: const Color(0xFF616161),
                                            width: 1,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Save Change",
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontFamily: "Manrope",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text('Status: ',
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 20),
                                      width: 150,
                                      height: 53,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: borderColor, width: 1)),
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
                                          });
                                        },
                                        items: status.entries
                                            .map<DropdownMenuItem<int>>((type) {
                                          return DropdownMenuItem(
                                            value: type.value,
                                            child: Text(type.key),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ]),
                              const SizedBox(
                                height: 16,
                              ),
                              const Row(
                                children: [
                                  Text(
                                    "Type: ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Sprinkle",
                                    style: TextStyle(
                                        color: borderColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "Field & Location ",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 24),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/location.png',
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 20),
                                      width: 250,
                                      height: 53,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: borderColor, width: 1)),
                                      child: DropdownButton<String>(
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
                                        items: fields!
                                            .map<DropdownMenuItem<String>>(
                                                (field) {
                                          return DropdownMenuItem<String>(
                                            value: field.id,
                                            child: Text(field.name),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              const Text(
                                "Serial Number",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 24),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/ha4tag.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      device!.serialNumber,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              const Text(
                                "Firmware Version",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 24),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/Group.png',
                                            width: 24,
                                            height: 24,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            device!.firmWareVersion,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              const Text(
                                "IP Address",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 24),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/material-symbols-light_wifi.png',
                                            width: 24,
                                            height: 24,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            device!.ipAddress ?? "Not Exist",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              const Text(
                                "MAC Address",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 24),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/material-symbols-light_wifi (1).png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      device!.macAddress,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              const Text(
                                "Configuration",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 24),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/Group.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      "8 zones, 360° coverage",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              const Text(
                                "Power Rating",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 24),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/material-symbols-light_electric-bolt-outline-rounded.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      "3.3v / 0.5W",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              const Text(
                                "Last Maintenance",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 24),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/Vector2.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      device!.lastMaintenance == null
                                          ? "Not Exist"
                                          : DateFormat('MMM dd, yyyy')
                                              .format(device!.lastMaintenance!),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              const Text(
                                "Next Maintenance",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 24),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/calender.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      device!.nextMaintenance == null
                                          ? "Not Exist"
                                          : DateFormat('MMM dd, yyyy')
                                              .format(device!.nextMaintenance!),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              const Text(
                                "Battery Level",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 24),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/battery.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: 90,
                                      height: 10,
                                      child: LinearProgressIndicator(
                                        value: 85 / 100,
                                        backgroundColor: const Color.fromARGB(
                                            63, 97, 97, 97),
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Text(
                                      "85%",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              const Text(
                                "Added By",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 24),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/person_icon.png',
                                            width: 24,
                                            height: 24,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            device!.addedBy,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                    ]),
                              ),
                              const Divider(
                                color: borderColor,
                                thickness: 1,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Last Operation",
                                    style: TextStyle(
                                        color: Color(0xFF616161),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                                    width: 380,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(63, 159, 159, 159),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                    "Zone 3 active for 20 minutes",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Last Updated: ${DateFormat('MMM dd, yyyy')
                                              .format(device!.lastUpdated) } at ${DateFormat('HH :MM')
                                              .format(device!.lastUpdated)}",
                                    style: const TextStyle(
                                        color: Color(0xFF616161),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                      ]
                                    ),
                                  )
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ),
          )),
        );
      },
    );
  }
}
