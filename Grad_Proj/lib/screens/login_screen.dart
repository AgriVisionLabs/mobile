// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/cubit/user_cubit.dart';
import 'package:grd_proj/cubit/user_state.dart';
import 'package:grd_proj/screens/forget_password_screen.dart';
import 'package:grd_proj/screens/home_screen.dart';
import 'package:grd_proj/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../models/unauthorize_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordControler = TextEditingController();
  bool obscureText = true;
  bool isChecked = true;
  String description = '';
  UnAuthorizeModel? response;

  @override
  Widget build(BuildContext context) {
    Future<void> login() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
    }

    return Center(
      child: Builder(builder: (context) {
        return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
          if (state is SignInSuccess) {
            ScaffoldMessenger.of(context).clearSnackBars();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("success"),
                ),
              );
            });
            login();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (state is SignInFailure) {
            if (state.errMessage == 'Unauthorized'){
              description = state.errors[0]['description'];
              response = UnAuthorizeModel();
            } else {
              response = UnAuthorizeModel.fromJson(state.errors);
            }
            ScaffoldMessenger.of(context).clearSnackBars();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMessage),
                ),
              );
            });
            context.read<UserCubit>().signInFormKey.currentState!.validate();
          }
        }, builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              // ignore: sized_box_for_whitespace
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    // Top Image with Custom Clip
                    ClipPath(
                      clipper: CurvedClipper(),
                      child: Container(
                        height: 350,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Welcome Text

                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Manrope",
                        color: Color(0xff1E6930),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'login to your account',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: "Manrope",
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Email and Password Fields
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: context.read<UserCubit>().signInFormKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: context.read<UserCubit>().signInEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "Enter your Email",
                                hintStyle: TextStyle(color: borderColor),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                      color: borderColor, width: 3.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 3.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide:
                                      BorderSide(color: errorColor, width: 3.0),
                                ),
                              ),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (response!.email != null) {
                                  if (value!.isEmpty) {
                                    return response!.email![0];
                                  } else if (!value.contains("@")) {
                                    return response!.email![0];
                                  }
                                  }else if(description.isNotEmpty && description != "A user with this username already exists."){
                                    return description;
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller:
                                  context.read<UserCubit>().signInPassword,
                              obscureText: obscureText,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                hintText: "Enter your  Password",
                                hintStyle: TextStyle(color: borderColor),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(
                                      color: borderColor, width: 3.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 3.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide:
                                      BorderSide(color: errorColor, width: 3.0),
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                    icon: Icon(obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                              ),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (response!.password != null) {
                                  if (value!.isEmpty) {
                                    return response!.password![0];
                                  } else {
                                    return response!.password![0];
                                  }
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Remember Me and Forgot Password Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                activeColor: const Color(0xff1E6930),
                                tristate: false,
                                onChanged: (newbool) {
                                  setState(() {
                                    isChecked = newbool!;
                                  });
                                },
                              ),
                              const Text('Remember me'),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  ),
                                ),
                                builder: (context) => ForgetPasswordScreen(),
                              );
                            },
                            child: const Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                color: Color(0xff1E6930),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Login Button
                    state is SignInLoading
                        ? const CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: SizedBox(
                              width: 227,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff1E6930),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                ),
                                onPressed: () {
                                  BlocProvider.of<UserCubit>(context).singIn();
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),

                    const SizedBox(
                      height: 24,
                    ),
                    // Footer Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account? ',
                          style: TextStyle(fontFamily: "Manrope", fontSize: 18),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Rigester(),
                              isScrollControlled: true,
                            );
                          },
                          child: const Text(
                            'Create account',
                            style: TextStyle(
                              color: Color(0xff1E6930),
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      }),
    );
  }
}

// Custom Clipper for Top Image Curve
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.75);

    // First curve
    path.quadraticBezierTo(
        size.width * 0.25,
        size.height, // Control point
        size.width * 0.5,
        size.height * 0.75); // End point

    // Second curve
    path.quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.5, // Control point
        size.width,
        size.height * 0.75); // End point

    path.lineTo(size.width, 0); // Close the path to the top-left corner
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
