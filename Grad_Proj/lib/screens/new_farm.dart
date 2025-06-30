// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';
import 'package:grd_proj/models/farm_model.dart';
import 'package:grd_proj/screens/basic_info.dart';
import 'package:grd_proj/screens/review.dart';
import 'package:grd_proj/screens/team.dart';
import '../Components/color.dart';

class NewFarm extends StatefulWidget {
  const NewFarm({super.key});

  @override
  State<NewFarm> createState() => _NewFarmState();
}

class _NewFarmState extends State<NewFarm> {
  int currentIndex = 0;
  String  farmId =  " ";
  void _onInputChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _onInputChanged2(int index , String farmIdbasic) {
    setState(() {
      farmId = farmIdbasic;
      currentIndex = index;
    });
  }
  bool edit = false;
  FarmModel ? farm;

  void didChangeDependencies() {
    context.read<FarmBloc>().name.clear();
    context.read<FarmBloc>().area.clear();
    context.read<FarmBloc>().location.clear();
    context.read<FarmBloc>().soilType.clear();
    context.read<FarmBloc>().recipient.clear();
    context.read<FarmBloc>().roleName.clear();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FarmBloc, FarmState>(
      listener: (context, state) {
        if (state is FarmSuccess) {
          farm = state.farm;
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
                    children: [
                      top(),
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
                         if (edit)
                          if (state is FarmSuccess || state is FarmEditFailure)
                            BasicInfo(
                              onInputChanged: _onInputChanged2,
                              currentIndex: currentIndex,
                              editFarm: true,
                              farm: farm,
                            )
                          else
                            const Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            )
                          else
                            BasicInfo(
                              onInputChanged: _onInputChanged2,
                              currentIndex: currentIndex,
                              editFarm: false,
                              farm: farm,
                            )
                        else if (currentIndex == 1)
                          Team(
                              farmId: farmId,
                              onInputChanged: _onInputChanged,
                              currentIndex: currentIndex)
                        else
                          Review(
                            farmId: farmId,
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

  Widget top() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              if(currentIndex == 2){
                context.read<FarmBloc>().add(ViewFarmMembers(farmId: farmId));
              }else if (currentIndex == 1){
                edit = true;
                context.read<FarmBloc>().add(ViewFarmDetails(farmId: farmId));
              }else{
                context.read<FarmBloc>().add(OpenFarmEvent());
                Navigator.pop(context);
              }
              if (currentIndex > 0) currentIndex--;
              
            });
          },
          icon: Icon(Icons.arrow_back_rounded,
              color: currentIndex == 0 ? Colors.white : Color(0xff757575),
              size: 24),
        ),
        const Spacer(),
        const Text(
          'Add New Farm',
          style: TextStyle(
            fontFamily: 'Manrope',
            color: primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            context.read<FarmBloc>().add(OpenFarmEvent());
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close_rounded,
              color: Color(0xff757575), size: 24),
        ),
      ],
    );
  }

  Widget buildIndicatorItem(int index) {
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
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildDots() {
    return SizedBox(
      width: 350,
      height: 60,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Column(
                children: [
                  buildIndicatorItem(index),
                  const SizedBox(height: 7),
                  Text(
                    index == 0
                        ? 'Basic Info'
                        : index == 1
                            ? 'Team'
                            : 'Review',
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              if (index < 2)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  width: 50,
                  height: 1,
                  color: const Color(0xFF333333),
                ),
            ],
          );
        },
      ),
    );
  }
}
