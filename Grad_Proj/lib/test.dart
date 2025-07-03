// import 'package:flutter/material.dart';

// class Rigester extends StatefulWidget {
//   @override
//   State<Rigester> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<Rigester> {
//   bool? isChecked = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: Stack(
//             children: [
//               // Top Right Image
//               Positioned(
//                 top: 0,
//                 right: 0,
//                 child: Image.asset(
//                   'assets/images/corner_plant.png',
//                   fit: BoxFit.contain,
//                   width: 120,
//                   height: 120,
//                 ),
//               ),
//               // Bottom Left Image
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 child: Image.asset(
//                   'assets/images/bottom_plant.png',
//                   fit: BoxFit.contain,
//                   width: 120,
//                   height: 120,
//                 ),
//               ),
//               // Main Content
//               Column(
//                 children: [
//                   const SizedBox(height: 50),
//                   const Text(
//                     'Welcome Back',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xff1E6930),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     'login to your account',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       children: [
//                         TextField(
//                           decoration: InputDecoration(
//                             hintText: 'Enter your Email',
//                             border: OutlineInputBorder(
//                               borderSide:
//                                   const BorderSide(color: Color(0xff9F9F9F)),
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 15),
//                         TextField(
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             hintText: 'Enter your Password',
//                             border: OutlineInputBorder(
//                               borderSide:
//                                   const BorderSide(color: Color(0xff9F9F9F)),
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Checkbox(
//                               value: isChecked,
//                               activeColor: const Color(0xff1E6930),
//                               tristate: false,
//                               onChanged: (newbool) {
//                                 setState(() {
//                                   isChecked = newbool;
//                                 });
//                               },
//                             ),
//                             const Text('Remember me'),
//                           ],
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => Rigester()),
//                             );
//                           },
//                           child: const Text(
//                             'Forgot Password ?',
//                             style: TextStyle(
//                               color: Color(0xff1E6930),
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 200),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 100),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xff1E6930),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           padding: const EdgeInsets.symmetric(vertical: 13),
//                         ),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => Rigester()),
//                           );
//                         },
//                         child: const Text(
//                           'Login',
//                           style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text('Don\'t have an account? '),
//                       const SizedBox(width: 20),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => Rigester()),
//                           );
//                         },
//                         child: const Text(
//                           'Create account',
//                           style: TextStyle(
//                             color: Color(0xff1E6930),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
