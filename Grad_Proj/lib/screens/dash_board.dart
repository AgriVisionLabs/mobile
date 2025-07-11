// ignore_for_file: prefer_const_constructors
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/models/farm_model.dart';
import 'package:grd_proj/models/field_model.dart';
import 'package:grd_proj/screens/alerts_bar.dart';
import 'package:grd_proj/screens/todo_bar.dart';
import 'package:grd_proj/screens/activity_bar.dart';
import 'package:grd_proj/screens/widget/card.dart';
import 'package:grd_proj/screens/widget/circule_indector.dart';
import 'package:grd_proj/screens/widget/text.dart';
import '../Components/color.dart';
import 'weather_bar.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String? selectedFarmId;
  List<FarmModel>? farms;
  List<FieldModel>? fields;
  String? roleName;
  FieldBloc? _fieldBloc;
  @override
  void initState() {
    _fieldBloc = context.read<FieldBloc>();
    context.read<FarmBloc>().add(OpenFarmEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<FarmBloc, FarmState>(
          listener: (context, state) {
          if (state is FarmsLoaded) {
            print("==============================================");
            farms = state.farms;
            selectedFarmId = farms![0].farmId;
            roleName = farms![0].roleName;
            _fieldBloc!.add(OpenFieldEvent(farmId: selectedFarmId!));
          }
        }, builder: (context, state) {
          if (state is FarmEmpty) {
           return Center(
                child: text(
                    fontSize: 24,
                    label:
                        "You don't have any farm yet. Go to the farm page and add a farm or have someone add you to their farm."));
          } 
          if (state is FarmsLoaded) {
           return _thereIsFarms(context, state.farms);
          } else if (state is FarmFailure) {
           return Center(child: text(fontSize: 24, label: state.errMessage));
          }
          return circularProgressIndicator();
        }));
  }

  Widget _thereIsFarms(BuildContext content, List<FarmModel>? farms) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child:
          ListView(scrollDirection: Axis.vertical, shrinkWrap: true, children: [
        SizedBox(height: 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 280,
                      height: 60,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Select Farm',
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w600),
                          ),
                          value: selectedFarmId,
                          items: farms?.map((farm) {
                            return DropdownMenuItem<String>(
                              value: farm.farmId,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    farm.name,
                                    style: const TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: 77,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                            color: borderColor, width: 2)),
                                    child: Center(
                                      child: Text(
                                        farm.roleName,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (farms == null || farms.isEmpty)
                              ? null
                              : (value) {
                                  setState(() {
                                    final selectedFarm = farms
                                        .where((farm) => farm.farmId == value)
                                        .toList();
                                    selectedFarmId = value;
                                    roleName = selectedFarm.first.roleName;
                                    _fieldBloc!.add(OpenFieldEvent(
                                        farmId: selectedFarmId!));
                                  });
                                },
                          selectedItemBuilder: (farms == null || farms.isEmpty)
                              ? null
                              : (BuildContext context) {
                                  return farms.map((farm) {
                                    return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        farm.name,
                                        style: const TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  }).toList();
                                },
                          buttonStyleData: ButtonStyleData(
                            height: 55,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: borderColor, width: 1),
                              color: Colors.white,
                            ),
                          ),
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
                            iconSize: 30,
                            iconEnabledColor: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Container(
                      width: 77,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: borderColor, width: 2)),
                      child: Center(
                        child: Text(
                          roleName ?? '',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
                selectedFarmId != null
                    ? BlocBuilder<FieldBloc, FieldState>(
                        builder: (context, state) {
                          if (state is FieldLoadingFailure) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              child: Center(
                                child: Text('Sonething went wrong',
                                    style: const TextStyle(
                                      fontFamily: 'Manrope',
                                      color: primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      // decoration: TextDecoration.lineThrough
                                    )),
                              ),
                            );
                          }
                          if (state is FieldLoaded) {
                            fields = state.fields
                                .where((field) => field.cropName != null)
                                .toList();
                            return Container(
                              height: state.fields.length > 3 ? 530 : null,
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.only(
                                  bottom: 20, top: 30, left: 5, right: 5),
                              child: _buildFeilds(context, fields),
                            );
                          } else if (state is FieldEmpty) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              child: Center(
                                child: Text('No Fields Found',
                                    style: const TextStyle(
                                      fontFamily: 'Manrope',
                                      color: primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      // decoration: TextDecoration.lineThrough
                                    )),
                              ),
                            );
                          }
                          return Container(
                            margin: EdgeInsets.all(20),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            ),
                          );
                        },
                      )
                    : SizedBox(
                        height: 0,
                      )
              ],
            ),
            SizedBox(height: 20),
            //Weather
            CardContainer(
              height: 324,
              child: WeatherBar(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ),

            const SizedBox(height: 60),

            //Alerts
            CardContainer(
              height: 290,
              child: AlertsBar(),
            ),

            SizedBox(height: 50),
            Text(
              'Key Performance Indicators',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'manrope'),
            ),
            SizedBox(height: 20),
            Container(
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
                child: Container(
                    padding: const EdgeInsets.all(24),
                    width: 380,
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text('Temperature',
                              style: TextStyle(
                                color: Colors.green[900],
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'manrope',
                              )),
                          Spacer(),
                          Image.asset('assets/images/temp.png')
                        ]),
                        SizedBox(height: 30),
                        Text('Good',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            )),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: 0.55,
                            backgroundColor: Colors.grey[300],
                            color: Colors.green[900],
                            minHeight: 6,
                          ),
                        ),
                        SizedBox(height: 4),
                      ],
                    ))),
            SizedBox(height: 24),
            Container(
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
                child: Container(
                    padding: const EdgeInsets.all(24),
                    width: 380,
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text('Moisture level',
                              style: TextStyle(
                                color: Colors.green[900],
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'manrope',
                              )),
                          Spacer(),
                          Image.asset('assets/images/water.png')
                        ]),
                        SizedBox(height: 30),
                        Text('Optimal',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            )),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: 0.20,
                            backgroundColor: Colors.grey[300],
                            color: Colors.green[900],
                            minHeight: 6,
                          ),
                        ),
                        SizedBox(height: 4),
                      ],
                    ))),
            SizedBox(height: 24),
            Container(
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
                child: Container(
                    padding: const EdgeInsets.all(24),
                    width: 380,
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text('Crop growth',
                              style: TextStyle(
                                color: Colors.green[900],
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'manrope',
                              )),
                          Spacer(),
                          Image.asset(
                            'assets/images/growth.png',
                            height: 24,
                            width: 24,
                          )
                        ]),
                        SizedBox(height: 30),
                        Text('On Track',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            )),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: 0.35,
                            backgroundColor: Colors.grey[300],
                            color: Colors.green[900],
                            minHeight: 6,
                          ),
                        ),
                        SizedBox(height: 4),
                      ],
                    ))),
            SizedBox(height: 24),
            Container(
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
                child: Container(
                    padding: const EdgeInsets.all(24),
                    width: 380,
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text('Yield forecast',
                              style: TextStyle(
                                color: Colors.green[900],
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'manrope',
                              )),
                          Spacer(),
                          Image.asset(
                            'assets/images/forcast.png',
                            height: 24,
                            width: 24,
                          )
                        ]),
                        SizedBox(height: 30),
                        Text('4.2 tons/acre',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            )),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: 0.70,
                            backgroundColor: Colors.grey[300],
                            color: Colors.green[900],
                            minHeight: 6,
                          ),
                        ),
                        SizedBox(height: 4),
                      ],
                    ))),
            SizedBox(height: 50),
            //Recent Activity
            Container(
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
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 22),
                    width: 380,
                    height: 396,
                    child: const Activitybar())),
            const SizedBox(height: 50),
            //To-Do List
            Container(
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
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 22),
                    width: 380,
                    height: 396,
                    child: const TodoBar())),
            const SizedBox(height: 20),
          ],
        )
      ]),
    );
  }

  Widget _buildFeilds(BuildContext content, List<FieldModel>? fields) {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          itemCount: fields?.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final field = fields?[index];
            //container of each task
            return Container(
              margin: const EdgeInsets.only(
                  bottom: 10, left: 15, right: 15, top: 10),
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
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

                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Text(
                              field.isActive == true ? "Active" : "Inactive",
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
                            field.cropName == null
                                ? text(fontSize: 20, label: "No Crop")
                                : Text(field.cropName!,
                                    style: const TextStyle(
                                      fontFamily: 'Manrope',
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    )),
                            field.progress == null
                                ? SizedBox(
                                    height: 1,
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      LinearProgressIndicator(
                                        value: (field.progress! / 100),
                                        backgroundColor: Colors.grey[300],
                                        color: Colors.green[900],
                                        minHeight: 6,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Progress: ${field.progress}%",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                          ]),
                    ),
                  )),
            );
          }),
    );
  }
}
