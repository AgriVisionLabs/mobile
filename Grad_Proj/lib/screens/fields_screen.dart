import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/models/farm_model.dart';
import 'package:grd_proj/models/field_model.dart';
import 'package:grd_proj/screens/new_field.dart';

import '../components/color.dart';

class FieldsScreen extends StatefulWidget {
  const FieldsScreen({super.key});

  @override
  State<FieldsScreen> createState() => _FieldsScreenState();
}

FarmModel? farm;
List<FieldModel>? fields;

class _FieldsScreenState extends State<FieldsScreen> {
  @override
  void initState() {
    context
        .read<FarmBloc>()
        .add(ViewFarmDetails(farmId: CacheHelper.getData(key: 'farmId')));
    super.initState();
  }

  String? soilName;
  Map soil = {'Sandy': 0, 'Clay': 1, 'Loamy': 2};
  String? getSoilName(int soiltype) {
    return soil.entries
        .firstWhere(
          (entry) => entry.value == soiltype,
          orElse: () => const MapEntry('Unknown', null),
        )
        .key;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FarmBloc, FarmState>(builder: (context, state) {
      if (state is FarmFailure) {
        return const Scaffold(
          body: Center(
            child: Text('Sorry something went wrong',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                )),
          ),
        );
      }
      if (state is FarmSuccess) {
        soilName = getSoilName(state.farm.soilType!);
        farm = state.farm;

        return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 150, left: 24, right: 24),
                width: 400,
                height: MediaQuery.of(context).size.height,
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            farm!.name!,
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              color: primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: borderColor, width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Text(farm!.roleName!,
                                style: const TextStyle(
                                  fontFamily: 'Manrope',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )),
                          )
                        ]),
                  ),
                  Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: borderColor,
                          ),
                          Text(farm!.location!,
                              style: const TextStyle(
                                fontFamily: 'Manrope',
                                color: grayColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                // decoration: TextDecoration.lineThrough
                              )),
                          const SizedBox(
                            width: 25,
                          ),
                          Image.asset(
                            'assets/images/soil.png',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(soilName!,
                              style: const TextStyle(
                                fontFamily: 'Manrope',
                                color: grayColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                // decoration: TextDecoration.lineThrough
                              )),
                          const Spacer(),
                          IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/images/edit.png',
                                width: 24,
                                height: 24,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/images/delete.png',
                                width: 24,
                                height: 24,
                                color: Colors.red,
                              ))
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/ruler.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(' acres',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            color: grayColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            // decoration: TextDecoration.lineThrough
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Fields',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          // decoration: TextDecoration.lineThrough
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 24),
                        height: 38,
                        width: 119,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: primaryColor,
                        ),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                //add new field here
                                Navigator.push(
                                    context,
                                    // ignore: prefer_const_constructors
                                    MaterialPageRoute(
                                        builder: (context) => NewFeild(
                                              farmId: farm!.farmId!,
                                              soilType: farm!.soilType!,
                                            )));
                              });
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.add, color: Colors.white, size: 20),
                                SizedBox(width: 3),
                                Text(
                                  'Add Field',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 3),
                              ],
                            )),
                      )
                    ],
                  ),
                  BlocBuilder<FieldBloc, FieldState>(
                    builder: (context, state) {
                      if (state is FieldLoadingFailure) {
                        return const Center(
                          child: Text('Sorry something went wrong',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                              )),
                        );
                      }
                      if (state is FieldLoaded) {
                        return SizedBox(
                            width: 400,
                            height: 450,
                            child: _buildFeilds(context));
                      } else if (state is FieldEmpty) {
                        return SizedBox(
                            width: 400,
                            height: 450,
                            child: _buildEmptyState(context));
                      }
                      return const Center(
                        child:  CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    },
                  )
                ]),
              ),
            ));
      }
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
      );
    });
  }
}

Widget _buildFeilds(BuildContext content) {
  return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: fields?.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final field = fields?[index];
        //container of each task
        return Container(
          margin:
              const EdgeInsets.only(bottom: 20, left: 15, right: 15, top: 20),
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 22),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(50, 0, 0, 0),
                        blurRadius: 10,
                        spreadRadius: 0.7,
                        offset: Offset(0, 2.25))
                  ]),

              //listTile used for constant layout of each item
              child: ListTile(
                //task content
                title: Row(
                  children: [
                    //Task Descrption
                    SizedBox(
                      width: 185,
                      child: Text(
                        field!.name,
                        style: const TextStyle(
                          fontFamily: 'Manrope',
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // decoration: TextDecoration.lineThrough
                        ),
                      ),
                    ),
                    const Spacer(),

                    //Due Date
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                      ),
                      child:
                          Text(field.isActive == true ? "Active" : "Inactive",
                              style: const TextStyle(
                                fontFamily: 'Manrope',
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              )),
                    )
                  ],
                ),

                subtitle: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            field.crop == 1
                                ? "Corn"
                                : field.crop == 2
                                    ? "Wheat"
                                    : field.crop == 3
                                        ? "Rice"
                                        : "Tomato",
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: (50 / 100),
                            backgroundColor: Colors.grey[300],
                            color: Colors.green[900],
                            minHeight: 6,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Progress: 50%",
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ]),
                ),
              )),
        );
      });
}

Widget _buildEmptyState(BuildContext context) {
  return const Center(
    child: Text("you don’t have any fields yet",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'manrope',
        )),
  );
}
