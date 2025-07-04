// ignore_for_file: prefer_const_constructors, avoid_print


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/user_cubit.dart';
import 'package:grd_proj/bloc/user_state.dart';
import 'package:grd_proj/screens/Login_Screen.dart';
import 'package:grd_proj/screens/disease_detection.dart';
import 'package:grd_proj/screens/fields_screen.dart';
import 'package:grd_proj/screens/inve_manage.dart';
import 'package:grd_proj/screens/irrigation_control.dart';
import 'package:grd_proj/screens/sensor_and_devices.dart';
import 'package:grd_proj/screens/settings.dart';
import '../components/color.dart';
import 'dash_board.dart';
import 'farms_screen.dart';
import 'tasks_screen.dart';
import 'more_screen.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int indexing = 0;
  late int initialIndex;
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
      FarmsScreen(), // Pass farms list to FarmsScreen
    ]);
  }

  // String? selectedValue;
  final List<Widget> screens = [
    const DashBoard(),
    const FarmsScreen(),
    const TaskScreen(),
    const MoreScreen(),
    const FieldsScreen(),
    const IrrigationConrtol(),
    const SensorAndDevices(),
    const DiseaseDetection(),
    const Settings(),
    const InventoryManagementScreen()
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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                  // _login();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) =>
                        false, // This will remove all previous routes
                  );
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
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 10),
          margin: EdgeInsets.only(top: 1),
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: borederColor2, width: 3))),
          child: BottomNavigationBar(
            backgroundColor: bottomBarColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: indexing > 3 ? 0 : indexing,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/dashboard.png',
                    height: 24,
                    width: 24,
                    color: indexing == 0 ? primaryColor : bottomBarIconColor),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/location.png',
                    height: 24,
                    width: 24,
                    color: indexing == 1 ? primaryColor : bottomBarIconColor),
                label: 'Farms',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/tabler_checkbox.png',
                    height: 24,
                    width: 24,
                    color: indexing == 2 ? primaryColor : bottomBarIconColor),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/more.png',
                    height: 24,
                    width: 24,
                    color: indexing == 3 ? primaryColor : bottomBarIconColor),
                label: 'More',
              ),
            ],
            selectedItemColor: primaryColor,
            unselectedItemColor: bottomBarTextColor,
            selectedLabelStyle: TextStyle(
                fontSize: 12,
                fontFamily: "manrope",
                fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(
                fontSize: 12,
                fontFamily: "manrope",
                fontWeight: FontWeight.w600),
            showSelectedLabels: true,
            showUnselectedLabels: true,
          ),
        ),

        body: screens[indexing], // Show selected page
      ),
    );
  }
}
