import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/field_bloc.dart/field_bloc.dart';
import 'package:grd_proj/cache/cache_helper.dart';
import 'package:grd_proj/models/field_model.dart';
import 'package:grd_proj/screens/new_field.dart';

import '../components/color.dart';

class FieldsScreen extends StatefulWidget {
  const FieldsScreen({super.key});

  @override
  State<FieldsScreen> createState() => _FieldsScreenState();
}

List<FieldModel>? fields;

class _FieldsScreenState extends State<FieldsScreen> {
  @override
  Widget build(BuildContext context) {
    String name = CacheHelper.getData(key: 'farmname');
    int size = CacheHelper.getData(key: 'area');
    String location = CacheHelper.getData(key: 'location');
    int soilnum = CacheHelper.getData(key: 'soiltype');
    String role = CacheHelper.getData(key: 'roleName');
    String soil = soilnum == 1
        ? "Sandy"
        : soilnum == 2
            ? "Clay"
            : "Loamy";

    return BlocConsumer<FieldBloc, FieldState>(
      listener: (context, state) {
        if (state is FieldLoaded) {
          fields = state.fields;
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: state is FieldInitial
                ? const Center(
                    child: CircularProgressIndicator(
                    color: primaryColor,
                  ))
                : Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 150),
                      width: 400,
                      height: MediaQuery.of(context).size.height,
                      child: Column(children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontFamily: 'Manrope',
                                    color: primaryColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                  ),
                                  child: Text(role,
                                      style: const TextStyle(
                                        fontFamily: 'Manrope',
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        // decoration: TextDecoration.lineThrough
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
                                Text(location,
                                    style: const TextStyle(
                                      fontFamily: 'Manrope',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      // decoration: TextDecoration.lineThrough
                                    )),
                                const SizedBox(
                                  width: 25,
                                ),
                                Image.asset('assets/images/soil.png'),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(soil,
                                    style: const TextStyle(
                                      fontFamily: 'Manrope',
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      // decoration: TextDecoration.lineThrough
                                    )),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon:
                                        Image.asset('assets/images/users.png')),
                                IconButton(
                                    onPressed: () {},
                                    icon:
                                        Image.asset('assets/images/edit.png')),
                                IconButton(
                                    onPressed: () {},
                                    icon: Image.asset(
                                        'assets/images/analytics.png')),
                                IconButton(
                                    onPressed: () {},
                                    icon: Image.asset(
                                      'assets/images/delete.png',
                                      color: Colors.red,
                                    ))
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/ruler.png'),
                            const SizedBox(
                              width: 8,
                            ),
                            Text('$size! acres',
                                style: const TextStyle(
                                  fontFamily: 'Manrope',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
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
                                color: primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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
                                                    farmId: CacheHelper.getData(
                                                        key: 'farmId'),
                                                  )));
                                    });
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(Icons.add,
                                          color: Colors.white, size: 20),
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
                        SizedBox(
                          width: 400,
                          height: 450,
                          child: state is FieldLoaded
                              ? _buildFeilds(context)
                              : state is FieldEmpty
                                  ? _buildEmptyState(context)
                                  : const Center(
                                      child: CircularProgressIndicator(
                                        color: primaryColor,
                                      ),
                                    ),
                        )
                      ]),
                    ),
                  ));
      },
    );
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
