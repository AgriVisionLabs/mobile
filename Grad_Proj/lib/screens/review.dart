// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/farm_bloc/farm_bloc.dart';
import 'package:grd_proj/models/invation_model.dart';

import '../Components/color.dart';

class Review extends StatefulWidget {
  final String farmId;
  final bool editFarm;
  const Review({super.key, this.editFarm = false, required this.farmId});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  void initState() {
    context.read<FarmBloc>().add(ViewFarmMembers(farmId: widget.farmId));
    super.initState();
    context.read<FarmBloc>().add(ViewFarmDetails(farmId: widget.farmId));
  }

  List<InvitationModel>? invites;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FarmBloc, FarmState>(
      listener: (context, state) {
        if (state is FarmSuccess) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(widget.editFarm ? "Edit Done" : "Farm Created"),
              ),
            );
          });
        } else if (state is FarmFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
        } else if (state is LoadingMember) {
          invites = state.invites;
        } else if (state is NoMember) {
          invites = [];
        } else if (state is LoadingMemberFailure) {
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
        if (state is FarmSuccess) {
          String soil = state.farm.soilType == 1
              ? "Sandy"
              : state.farm.soilType == 2
                  ? "Clay"
                  : "Loamy";
          return SizedBox(
            width: 380,
            height: 680,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Farm Details',
                      style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: 380,
                height: 59,
                child: Row(children: [
                  Column(children: [
                    const Text('Farm Name',
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    Text(state.farm.name!,
                        style: const TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400))
                  ]),
                  Spacer(),
                  Column(children: [
                    const Text('Farm Size',
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    Text('${state.farm.area} acres',
                        style: const TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400))
                  ]),
                ]),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: 390,
                height: 59,
                child: Row(children: [
                  Column(children: [
                    const Text('Location',
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    Text(state.farm.location!,
                        style: const TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400))
                  ]),
                  const Spacer(),
                  Column(children: [
                    Text('Soil Type',
                        style: const TextStyle(
                            fontFamily: 'Manrope',
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    Text('$soil Soil',
                        style: const TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400))
                  ]),
                ]),
              ),
              const SizedBox(
                height: 24,
              ),
              invites == null || invites!.isEmpty
                  ? SizedBox(
                      height: 0,
                    )
                  : _buildRolesList(),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    width: 200,
                    height: 55,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor,
                    ),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<FarmBloc>().add(OpenFarmEvent());
                        },
                        child: Text(
                          widget.editFarm ? "EditFarm" : 'Create Farm',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ))),
              )
            ]),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildRolesList() {
    return SizedBox(
      width: 380,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Team Members',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              )),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: 380,
            height: 220,
            child: ListView.builder(
                itemCount: invites?.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(30, 105, 48, 0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          //Task Descrption
                          Text(
                            invites![index].receiverUserName,
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              // decoration: TextDecoration.lineThrough
                            ),
                          ),
                          const Spacer(),

                          Text(invites![index].roleName,
                              style: const TextStyle(
                                fontFamily: 'Manrope',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                // decoration: TextDecoration.lineThrough
                              )),

                          Align(
                            heightFactor: 1,
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 20,
                              height: 30,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    context
                                        .read<FarmBloc>()
                                        .add(OpenFarmEvent());
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 18,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
