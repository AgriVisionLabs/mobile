import 'package:flutter/material.dart';

import '../components/color.dart';

class FieldsScreen extends StatefulWidget {
  final List field;
  const FieldsScreen({super.key, required this.field});

  @override
  State<FieldsScreen> createState() => _FieldsScreenState();
}

List<Map<String, dynamic>> fields = [
  {'feildnum': "Field 1", 'state': 'active', 'crop': 'Corn', 'progress': 65},
  {'feildnum': "Field 2", 'state': 'active', 'crop': 'Corn', 'progress': 65},
  {'feildnum': "Field 3", 'state': 'active', 'crop': 'Corn', 'progress': 65}
];

class _FieldsScreenState extends State<FieldsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
            child: Container(
          width: 380,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(22),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Text(
                  'Green Farm',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    color: primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: const Text('Manager',
                      style: TextStyle(
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
                    const Text('Ismaillia',
                        style: TextStyle(
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
                    const Text('Clay',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          // decoration: TextDecoration.lineThrough
                        )),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/images/users.png')),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/images/edit.png')),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/images/analytics.png')),
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
                const Text('900 acres',
                    style: TextStyle(
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
            widget.field.isNotEmpty
                ?
                //task list is not empty
                SizedBox(
                    width: 380,
                    height: 700,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: 3,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          //container of each task
                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 22),
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFFFFFFF)),

                                  //listTile used for constant layout of each item
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(0),

                                    //task content
                                    title: Row(
                                      children: [
                                        //Task Descrption
                                        SizedBox(
                                          width: 185,
                                          child: Text(
                                            fields[index]['feildnum'],
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
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(30)),
                                          ),
                                          child: Text(fields[index]['state'],
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
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(fields[index]['crop'],
                                                style: const TextStyle(
                                                  fontFamily: 'Manrope',
                                                  color: Colors.black,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child: LinearProgressIndicator(
                                                value: (fields[index]
                                                        ['progress'] /
                                                    100),
                                                backgroundColor:
                                                    Colors.grey[300],
                                                color: Colors.green[900],
                                                minHeight: 6,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "Progress: ${fields[index]['progress']}%",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black87),
                                            ),
                                          ]),
                                    ),
                                  )),
                            ),
                          );
                        }),
                  )
                :

                //all tasks are done
                const SizedBox(
                    child: Center(
                    child: Text(
                      "You have done all tasks",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                  )),
          ]),
        )),
      ),
    );
  }
}
