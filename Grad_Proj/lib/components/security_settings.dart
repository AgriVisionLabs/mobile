// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/account_bloc/bloc/account_bloc.dart';
import 'package:grd_proj/bloc/user_cubit.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/screens/change_password.dart';

class SecuritySettings extends StatefulWidget {
  const SecuritySettings({super.key});

  @override
  State<SecuritySettings> createState() => _SecuritySettingsState();
}

class _SecuritySettingsState extends State<SecuritySettings> {
  bool isEditingPassword = false;
  bool obscureText = true;
  bool obscureText2 = true;
  bool isSwitched = false;
  AccountBloc? _accountBloc;
  var error;
  @override
  void initState() {
    super.initState();
    _accountBloc = context.read<AccountBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Image.asset('assets/images/shield.png', width: 24, height: 24),
            SizedBox(
              width: 4,
            ),
            Text('Security Settings',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: "manrope",
                ))
          ]),
          SizedBox(height: 4),
          Text('Manage your account security and authentication methods.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontFamily: "manrope",
              )),
          SizedBox(height: 30),
          Row(children: [
            SizedBox(
              width: 231,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Two-Factor Authentication',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: "manrope",
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Add an extra layer of security to your account.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontFamily: "manrope",
                        ))
                  ]),
            ),
            SizedBox(width: 50),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
              activeColor: Colors.white,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[200],
              activeTrackColor: primaryColor,
            )
          ]),
          SizedBox(height: 24),
          Divider(
            thickness: 1,
            color: borderColor,
          ),
          SizedBox(height: 24),
          BlocConsumer<AccountBloc, AccountState>(
            listener: (context, state) {
              if (state is ChangePasswordFailure) {
                error = state.errors;
                print("==========${error['NewPassword']}");
                _accountBloc!.changePasswordFormKey.currentState!.validate();
                ScaffoldMessenger.of(context).clearSnackBars();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errMessage),
                    ),
                  );
                });
              } else if (state is ChangePasswordSuccess) {
                isEditingPassword = false;
                _accountBloc!.newPassword.clear();
                _accountBloc!.currentPassword.clear();
                ScaffoldMessenger.of(context).clearSnackBars();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Password Changed"),
                    ),
                  );
                });
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Password',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: "manrope",
                      )),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "*" * 10,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: "manrope",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<UserCubit>(context).forgetPasswordEmail.text = _accountBloc!.email.text;
                          BlocProvider.of<UserCubit>(context).sendCode();
                          setState(() {
                            showModalBottomSheet(
                              context: context,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              enableDrag: false,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: borderColor,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0),
                                ),
                              ),
                              builder: (context) {
                                return SizedBox(
                                  height: 400,
                                  child: ChangePassword(),
                                );
                              },
                            );
                          });
                        },
                        child: Container(
                          height: 39,
                          width: 160,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(color: Color(0xff333333), width: 1),
                          ),
                          child: Center(
                            child: Text(
                              'Change Password',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontFamily: "manrope",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
          SizedBox(height: 24),
          Divider(color: borderColor),
          SizedBox(height: 24),
          Text('Last Login',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: "manrope",
              )),
          SizedBox(height: 24),
          Text('April 18, 2025, 2:45 PM',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: "manrope",
              )),
          SizedBox(height: 24),
          Divider(color: borderColor),
          SizedBox(height: 24),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 54,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: borderColor, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logout.png',
                      width: 24, height: 24),
                  SizedBox(width: 4),
                  Text(
                    'Logout from all devices',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "manrope",
                    ),
                  )
                ],
              ),
            ),
          ),
        ]));
  }
}
