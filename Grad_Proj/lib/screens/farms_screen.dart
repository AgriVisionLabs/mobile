// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/farm_model.dart';
import 'package:grd_proj/screens/edit_farm.dart';
import 'package:grd_proj/screens/home_screen.dart';
import 'package:grd_proj/screens/new_farm.dart';
import 'package:grd_proj/screens/widget/soil.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';

class FarmsScreen extends StatefulWidget {
  const FarmsScreen({super.key});

  @override
  State<FarmsScreen> createState() => _FarmsScreen();
}
class _FarmsScreen extends State<FarmsScreen> {
  String? soil;
  @override
  void initState() {
    context.read<FarmBloc>().add(OpenFarmEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<FarmModel>? farms;
    return BlocBuilder<FarmBloc, FarmState>(
      builder: (context, state) {
        if (state is FarmEmpty) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: _buildEmptyState(context),
          );
        }
        if (state is FarmsLoaded) {
          farms = state.farms;
          return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Expanded(child: _buildFieldList(farms!)),
                ],
              ));
        } else if (state is FarmFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          );
        } else if (state is DeleteFarmSuccess) {
          context.read<FarmBloc>().add(OpenFarmEvent());
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Done Deleting Farm'),
              ),
            );
          });
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          );
        } else if (state is DeleteFarmFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          ),
        );
      },
    );
  }

  Widget _buildFieldList(List<FarmModel> farms) {
    return ListView.builder(
      itemCount: farms.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                const Text("Farms Management",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'manrope',
                    )),
                const Spacer(),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Color(0xFF1E6930)),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewFarm()),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          final farm = farms[index - 1];
          soil = getSoilName(farm.soilType);
          return GestureDetector(
            onTap: () {
              context.read<FieldBloc>().add(OpenFieldEvent(
                  farmId: farm.farmId,
                  ));

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            initialIndex: 4,
                          )));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    25,
                  ),
                  border: Border.all(
                      color: const Color.fromARGB(11, 13, 18, 28), width: 2),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(50, 0, 0, 0),
                        blurRadius: 15,
                        spreadRadius: 3,
                        offset: Offset(-2, 2))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    farm.name,
                    style: const TextStyle(
                      color: Color(0xff1E6930),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "manrope",
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          color: Color(0xff616161)),
                      SizedBox(width: 8),
                      Text(farm.location, style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text("Fields : ${farm.fieldsNo}",
                          style: TextStyle(fontSize: 18)),
                      Spacer(),
                      Text("Area : ${farm.area}",
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text("Avg. Growth : 75%", style: TextStyle(fontSize: 18)),
                      Spacer(),
                      Text("Soil Type : $soil", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 22),
                  Row(
                    children: [
                      Container(
                        width: 77,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: borderColor, width: 1)),
                        child: Center(
                          child: Text(
                            farm.roleName,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditFarm(farmId: farm.farmId)));
                        },
                        child: Image.asset('assets/images/edit.png',
                            width: 30, height: 30),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<FarmBloc>()
                              .add(DeleteFarmEvent(farmId: farm.farmId));
                        },
                        child: Image.asset('assets/images/delete.png',
                            width: 30, height: 30),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }


  // Function to build the empty state
  Widget _buildEmptyState(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Farms & Fields Management",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            fontFamily: "manrope",
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "You don’t have any farms yet",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: "manrope",
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // Add farm logic here
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewFarm()));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: const Text(
                "Add New Farm",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "manrope",
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(207, 54),
                backgroundColor: Color(0xFF1E6930),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
