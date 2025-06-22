import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/field_model.dart';

class SelectField extends StatelessWidget {
  final String farmId;
  final String operation;
  final Function(int) onInputChanged;
  final int currentIndex;
  const SelectField({super.key, required this.farmId, required this.operation,required this.onInputChanged, required this.currentIndex,});

  @override
  Widget build(BuildContext context) {
    String? selectedValue;
    int index = 0;
    context.read<FieldBloc>().add(OpenFieldEvent(farmId: farmId));
    List<FieldModel>? fields;
    return BlocConsumer<FieldBloc, FieldState>(
      listener: (context, state) {
        if (state is FieldEmpty) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('There is no farms to show'),
              ),
            );
          });
        } else if (state is FieldLoaded) {
          fields = state.fields;
        } else if (state is FieldFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
        }
      },
      builder: (context, state) {
        return Container(
          width: 380,
          height: 630,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
            const Text('Field',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                )),
                SizedBox(height: 14,),
            Container(
              padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
              width: 380,
              height: 53,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: const Color.fromARGB(138, 159, 159, 159), width: 3)),
              child: DropdownButton(
                hint: const Text('select field'),
                dropdownColor: Colors.white,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
                value: selectedValue,
                isExpanded: true,
                icon: Image.asset(
                  'assets/images/arrow.png',
                ),
                items: fields?.map<DropdownMenuItem<String>>((field) {
                  return DropdownMenuItem(
                    value: field.id,
                    child: Text(field.name),
                  );
                }).toList(),
                onChanged: (String? value) {
                  selectedValue = value;
                },
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  width: 100,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: primaryColor,
                  ),
                  child: TextButton(
                      onPressed: () {
                        if (selectedValue == null) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please Choose Field"),
                              ),
                            );
                          });
                        } else {
                          index = currentIndex;
                          index++;
                          onInputChanged(index);
                        }
                      },
                      child: const SizedBox(
                        width: 380,
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
                            SizedBox(width: 5,),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ))),
            ),
          ]),
        );
      },
    );
  }
}
