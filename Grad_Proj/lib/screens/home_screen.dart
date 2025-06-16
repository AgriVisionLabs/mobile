// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/user_cubit.dart';
import 'package:grd_proj/bloc/user_state.dart';
import 'package:grd_proj/screens/Login_Screen.dart';
import 'package:grd_proj/screens/fields_screen.dart';
import '../Components/color.dart';
import 'dash_board.dart';
import 'farms_screen.dart';
import 'scan_screen.dart';
import 'tasks_screen.dart';
import 'more_screen.dart';
import '../models/farms.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex;
  const HomeScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int indexing = 0;
  late int initialIndex;
  final List farmsList = [
    Farm(name: "Green farm", location: "SpringField, IL"),
    Farm(name: "blue farm", location: "Texas, TX"),
    Farm(name: "white farm", location: "Egypt, CA"),
  ];

  // Define screens
  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    // Set initial index from widget parameter
    indexing = widget.initialIndex;
    // Initialize the screens list AFTER creating the farm list
    _screens.addAll([
      DashBoard(), // Dashboard Screen
      FarmsScreen(farms: farmsList), // Pass farms list to FarmsScreen
    ]);
    super.initState();
  }

  // String? selectedValue;
  final List<Widget> screens = [
    const DashBoard(),
    const FarmsScreen(
      farms: [],
    ),
    const ScanScreen(),
    const TaskScreen(),
    const MoreScreen(),
    const FieldsScreen(field: [])
  ];

  void _onItemTapped(int index) {
    setState(() {
      indexing = index;
    });
  }

  // Future<void> _login() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('isLoggedIn', false);
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignOut) {
          context.read<UserCubit>().logout();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) =>
                false, // This will remove all previous routes
          );
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 90,
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: screenWidth * 0.3,
                height: screenHeight * 0.1,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  print("call note");
                },
                child: Image.asset('assets/images/Vector.png',
                    width: 30, height: 30),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  print("call acc");
                },
                child: Image.asset('assets/images/image 6.png',
                    width: 30, height: 30),
              )
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1.0,
              color: borderColor,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: indexing > 4 ? 2 : indexing,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/dashboard.png',
                  height: 30,
                  width: 30,
                  color: indexing == 0 ? Colors.green[900] : Colors.black),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/farms.png',
                  height: 30,
                  width: 30,
                  color: indexing == 1 || indexing == 5
                      ? Colors.green[900]
                      : Colors.black),
              label: 'Farms',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/Scan.png',
                  height: 30,
                  width: 30,
                  color: indexing == 2 ? Colors.green[900] : Colors.black),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/tasks.png',
                  height: 25,
                  width: 25,
                  color: indexing == 3 ? Colors.green[900] : Colors.black),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/more.png',
                  height: 25,
                  width: 25,
                  color: indexing == 4 ? Colors.green[900] : Colors.black),
              label: 'More',
            ),
          ],
          selectedItemColor: Colors.green[900],
          unselectedItemColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),

        body: screens[indexing], // Show selected page
      ),
    );
  }
}
