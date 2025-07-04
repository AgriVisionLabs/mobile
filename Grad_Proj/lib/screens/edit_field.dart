import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/models/field_model.dart';
import 'package:grd_proj/screens/basic_info_field.dart';
import 'package:grd_proj/screens/irrigation.dart';
import 'package:grd_proj/screens/review_field.dart';
import 'package:grd_proj/screens/sensor.dart';
import 'package:grd_proj/screens/widget/circule_indector.dart';
import '../Components/color.dart';

class EditField extends StatefulWidget {
  final String farmId;
  final String fieldId;
  const EditField({super.key, required this.farmId, required this.fieldId});

  @override
  State<EditField> createState() => _EditFieldState();
}

class _EditFieldState extends State<EditField> {
  int currentIndex = 0;
  FieldModel? field;
  FieldBloc? _fieldBloc;
  void _onInputChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _onInputChanged2(int index, FieldModel field) {
    setState(() {
      this.field = field;
      currentIndex = index;
    });
  }

  @override
  void initState() {
    _fieldBloc = context.read<FieldBloc>();
    _fieldBloc!
        .add(ViewFieldDetails(farmId: widget.farmId, fieldId: widget.fieldId));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _fieldBloc!.name.clear();
    _fieldBloc!.area.clear();
    _fieldBloc!.cropType.clear();
    _fieldBloc!.irrigationUnitName.clear();
    _fieldBloc!.irrigationSerialNum.clear();
    _fieldBloc!.sensorUnitName.clear();
    _fieldBloc!.sensorSerialNum.clear();
    _fieldBloc!.sensorId.clear();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _fieldBloc!.add(ViewFieldDetails(farmId: widget.farmId , fieldId: widget.fieldId));
    super.dispose();
  }

  bool edit = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FieldBloc, FieldState>(
      listener: (context, state) {
        if(state is FieldSuccess){
          field = state.field;
        }
      },
      builder: (context, state) {
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

                // Scrollable Form Section
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        if (currentIndex == 0)
                        if(field !=null)
                          BasicInfoField(
                            onInputChanged: _onInputChanged2,
                            currentIndex: currentIndex,
                            farmId: widget.farmId,
                            field: field,
                            edit: true,
                          )
                         else
                         circularProgressIndicator()
                        else if (currentIndex == 1)
                          Irrigation(
                            onInputChanged: _onInputChanged,
                            currentIndex: currentIndex,
                            farmId: widget.farmId,
                            fieldId: widget.fieldId,
                            form: true,
                          )
                        else if (currentIndex == 2)
                          Sensor(
                            onInputChanged: _onInputChanged,
                            currentIndex: currentIndex,
                            farmId: widget.farmId,
                            fieldId: widget.fieldId,
                            form: true,
                          )
                        else if (currentIndex == 3)
                          ReviewField(
                            farmId: widget.farmId,
                            fieldId: widget.fieldId,
                            edit: true,
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
      },
    );
  }

  Widget pageTop() {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: 390,
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (currentIndex == 1) {
                      edit = true;
                      _fieldBloc!.add(ViewFieldDetails(
                          farmId: widget.farmId, fieldId: field!.id));
                    }
                    if (currentIndex > 0) currentIndex--;
                  });
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                  size: 24,
                )),
            const Spacer(),
            const Text('Edit Feild',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                )),
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
        width: 380,
        height: 60,
        child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildIndicatorItem(index),
                      const SizedBox(height: 7),
                      Text(
                          index == 0
                              ? 'Basic Info'
                              : index == 1
                                  ? 'Irrigation'
                                  : index == 2
                                      ? 'Sensor'
                                      : 'Review',
                          style: const TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400))
                    ],
                  ),
                  Container(
                    width: 44,
                    height: 1,
                    color: const Color(0xFF333333),
                  ),
                ],
              );
            }));
  }
}
