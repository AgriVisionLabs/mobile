// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grd_proj/bloc/account_bloc/bloc/account_bloc.dart';
import 'package:grd_proj/components/color.dart';
import 'package:grd_proj/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalSetting extends StatefulWidget {
  const PersonalSetting({super.key});

  @override
  State<PersonalSetting> createState() => _PersonalSettingState();
}

class _PersonalSettingState extends State<PersonalSetting> {
  bool isEditingFirstName = false;
  bool isEditingLastName = false;
  bool isEditingUsername = false;
  bool isEditingEmail = false;
  bool isEditingPhone = false;

  final borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.grey.shade400),
  );

  @override
  void initState() {
    super.initState();
    context.read<AccountBloc>().add(ViewAccountDetails());
    _loadSavedImage();
  }

  

  @override
  void didChangeDependencies() {
    context.read<AccountBloc>().firstName.clear();
    context.read<AccountBloc>().lastName.clear();
    context.read<AccountBloc>().userName.clear();
    context.read<AccountBloc>().phoneNumber.clear();
    super.didChangeDependencies();
  }

  UserModel? user;

  String? description;
  File? _selectedImage;

  bool _isPickingImage = false;




  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('profile_image_path');
    if (path != null && File(path).existsSync()) {
      setState(() {
        _selectedImage = File(path);
      });
    }
  }

  Future<void> _pickImage() async {
    if (_isPickingImage) return;
    _isPickingImage = true;

    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        final file = File(picked.path);
        setState(() {
          _selectedImage = file;
        });

        // حفظ المسار
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('profile_image_path', picked.path);
      }
    } catch (e) {
      print('Error picking image: $e');
    } finally {
      _isPickingImage = false;
    }
  }

  Future<void> _removeImage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile_image_path');

    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is ViewAccountDetailsFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
        } else if (state is ViewAccountDetailsSuccess) {
          user = state.user;
          context.read<AccountBloc>().firstName.text = state.user.firstName;
          context.read<AccountBloc>().lastName.text = state.user.lastName;
          context.read<AccountBloc>().userName.text = state.user.userName;
          context.read<AccountBloc>().email.text = state.user.email;
          context.read<AccountBloc>().phoneNumber.text =
              state.user.phoneNumber ?? '';
          isEditingEmail = false;
          isEditingFirstName = false;
          isEditingLastName = false;
          isEditingPhone = false;
          isEditingUsername = false;
        } else if (state is EditAccountDetailsFailure) {
          if (state.errMessage == "Conflict") {
            description = state.errors[0]['description'];
          }
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          });
          context.read<AccountBloc>().editFormKey.currentState!.validate();
        } else if (state is EditAccountDetailsSuccess) {
          context.read<AccountBloc>().add(ViewAccountDetails());
          ScaffoldMessenger.of(context).clearSnackBars();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Your Account Updated Successfuly"),
              ),
            );
          });
        }
      },
      builder: (context, state) {
        return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: borderColor, width: 1),
            ),
            child: user != null
                ? Form(
                    key: context.read<AccountBloc>().editFormKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Image.asset('assets/images/person_icon.png',
                                color: Colors.black, width: 24, height: 24),
                            SizedBox(
                              width: 4,
                            ),
                            Text('Personal Information',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "manrope",
                                ))
                          ]),
                          SizedBox(height: 4),
                          Text(
                              'Manage your personal details and contact information.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontFamily: "manrope",
                              )),
                          SizedBox(height: 30),
                          Text('Profile Picture',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontFamily: "manrope",
                              )),
                          SizedBox(height: 24),
                          Row(children: [
                            GestureDetector(
                              onTap: _pickImage,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: _selectedImage != null
                                    ? FileImage(_selectedImage!)
                                    : const AssetImage(
                                            'assets/images/person.png')
                                        as ImageProvider,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: _pickImage,
                                  child: const Text(
                                    'Upload new picture',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xff616161),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "manrope",
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: _removeImage,
                                  child: const Text(
                                    'Remove',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xffE13939),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "manrope",
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                          SizedBox(height: 24),
                          Divider(
                            color: borderColor,
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Text(
                                'First Name',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "manrope",
                                ),
                              ),
                              Spacer(),
                              if (!isEditingFirstName)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isEditingFirstName = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/edit.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 4),
                                        Text('Edit',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "manrope",
                                            )),
                                        SizedBox(width: 16),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 24),
                          isEditingFirstName
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller:
                                          context.read<AccountBloc>().firstName,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 17),
                                        hintText: "Enter Field Name",
                                        hintStyle:
                                            const TextStyle(color: borderColor),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: borderColor, width: 3.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 3.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: errorColor, width: 3.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: errorColor, width: 3.0),
                                        ),
                                      ),
                                      autocorrect: false,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "First Name Can't Be Empty";
                                        } else if (value.length < 3 ||
                                            value.length > 32) {
                                          return "Name must be between 3 and 100 characters.";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 24),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {
                                            context
                                                .read<AccountBloc>()
                                                .add(EditAccountDetails());
                                          },
                                          icon: Image.asset(
                                              'assets/images/si_check-line.png',
                                              width: 24,
                                              height: 24),
                                          label: Text(
                                            "Save",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontFamily: "manrope",
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(width: 50),
                                        TextButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              isEditingFirstName = false;
                                            });
                                          },
                                          icon: Image.asset(
                                              'assets/images/proicons_cancel.png',
                                              width: 24,
                                              height: 24),
                                          label: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontFamily: "manrope",
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Text(
                                  user!.firstName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: "manrope",
                                  ),
                                ),
                          SizedBox(height: 24),
                          Divider(
                            color: borderColor,
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Text(
                                'Last Name',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "manrope"),
                              ),
                              Spacer(),
                              if (!isEditingLastName)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isEditingLastName = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/edit.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 4),
                                        Text('Edit',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "manrope",
                                            )),
                                        SizedBox(width: 16),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 24),
                          isEditingLastName
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller:
                                          context.read<AccountBloc>().lastName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "manrope",
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 17),
                                        hintText: "Enter Field Name",
                                        hintStyle:
                                            const TextStyle(color: borderColor),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: borderColor, width: 3.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 3.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: errorColor, width: 3.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: errorColor, width: 3.0),
                                        ),
                                      ),
                                      autocorrect: false,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Last Name Can't Be Empty";
                                        } else if (value.length < 3 ||
                                            value.length > 32) {
                                          return "Name must be between 3 and 100 characters.";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {
                                            context
                                                .read<AccountBloc>()
                                                .add(EditAccountDetails());
                                          },
                                          icon: Image.asset(
                                              'assets/images/si_check-line.png',
                                              width: 24,
                                              height: 24),
                                          label: Text(
                                            "Save",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontFamily: "manrope",
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(width: 50),
                                        TextButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              isEditingLastName = false;
                                            });
                                          },
                                          icon: Image.asset(
                                              'assets/images/proicons_cancel.png',
                                              width: 24,
                                              height: 24),
                                          label: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontFamily: "manrope",
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Text(
                                  user!.lastName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: "manrope",
                                  ),
                                ),
                          SizedBox(height: 24),
                          Divider(
                            color: borderColor,
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Text(
                                'Username',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "manrope"),
                              ),
                              Spacer(),
                              if (!isEditingUsername)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isEditingUsername = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/edit.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 4),
                                        Text('Edit',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "manrope",
                                            )),
                                        SizedBox(width: 16),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 24),
                          isEditingUsername
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller:
                                          context.read<AccountBloc>().userName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "manrope",
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 17),
                                        hintText: "Enter Field Name",
                                        hintStyle:
                                            const TextStyle(color: borderColor),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: borderColor, width: 3.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 3.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: errorColor, width: 3.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: errorColor, width: 3.0),
                                        ),
                                      ),
                                      autocorrect: false,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Email Can't Be Empty";
                                        } else if (value.length < 3 ||
                                            value.length > 32) {
                                          return "Name must be between 3 and 100 characters.";
                                        } else if (description!.isNotEmpty) {
                                          return description;
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {
                                            context
                                                .read<AccountBloc>()
                                                .add(EditAccountDetails());
                                          },
                                          icon: Image.asset(
                                              'assets/images/si_check-line.png',
                                              width: 24,
                                              height: 24),
                                          label: Text(
                                            "Save",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontFamily: "manrope",
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(width: 50),
                                        TextButton.icon(
                                          onPressed: () {
                                            context
                                                .read<AccountBloc>()
                                                .add(EditAccountDetails());
                                          },
                                          icon: Image.asset(
                                              'assets/images/proicons_cancel.png',
                                              width: 24,
                                              height: 24),
                                          label: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontFamily: "manrope",
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Text(
                                  user!.userName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: "manrope",
                                  ),
                                ),
                          SizedBox(height: 24),
                          Divider(
                            color: borderColor,
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "manrope"),
                              ),
                              Spacer(),
                              if (!isEditingEmail)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isEditingEmail = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/edit.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 4),
                                        Text('Edit',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "manrope",
                                            )),
                                        SizedBox(width: 16),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 24),
                          isEditingEmail
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller:
                                          context.read<AccountBloc>().email,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "manrope",
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 17),
                                        hintText: "Enter Field Name",
                                        hintStyle:
                                            const TextStyle(color: borderColor),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: borderColor, width: 3.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: primaryColor, width: 3.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: errorColor, width: 3.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: errorColor, width: 3.0),
                                        ),
                                      ),
                                      autocorrect: false,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "User Name Can't Be Empty";
                                        } else if (!value.contains("@")) {
                                          return "Enter A Correct Email.";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {
                                            context
                                                .read<AccountBloc>()
                                                .add(EditAccountDetails());
                                          },
                                          icon: Image.asset(
                                              'assets/images/check_shape.png.png',
                                              width: 24,
                                              height: 24),
                                          label: Text(
                                            "Save",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontFamily: "manrope",
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(width: 50),
                                        TextButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              isEditingEmail = false;
                                            });
                                          },
                                          icon: Image.asset(
                                              'assets/images/wrong_shape.png',
                                              width: 24,
                                              height: 24),
                                          label: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontFamily: "manrope",
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Text(
                                  user!.email,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: "manrope",
                                  ),
                                ),
                          SizedBox(height: 24),
                          Divider(
                            color: borderColor,
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Text(
                                'Phone',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "manrope"),
                              ),
                              Spacer(),
                              if (!isEditingPhone)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isEditingPhone = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/edit.png',
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 4),
                                        Text('Edit',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "manrope",
                                            )),
                                        SizedBox(width: 16),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 24),
                          isEditingPhone
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: context
                                                .read<AccountBloc>()
                                                .phoneNumber,
                                            keyboardType: TextInputType.phone,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: "manrope",
                                            ),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 17),
                                              hintText: "Enter Field Name",
                                              hintStyle: const TextStyle(
                                                  color: borderColor),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                    color: borderColor,
                                                    width: 3.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                    color: primaryColor,
                                                    width: 3.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                    color: errorColor,
                                                    width: 3.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                    color: errorColor,
                                                    width: 3.0),
                                              ),
                                            ),
                                            autocorrect: false,
                                            textCapitalization:
                                                TextCapitalization.none,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              isEditingPhone = false;
                                            });
                                          },
                                          icon: Image.asset(
                                              'assets/images/check_shape.png',
                                              width: 24,
                                              height: 24),
                                          label: Text(
                                            "Save",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontFamily: "manrope",
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(width: 50),
                                        TextButton.icon(
                                          onPressed: () {
                                            context
                                                .read<AccountBloc>()
                                                .add(EditAccountDetails());
                                          },
                                          icon: Image.asset(
                                              'assets/images/wrong_shape.png',
                                              width: 24,
                                              height: 24),
                                          label: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontFamily: "manrope",
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Text(
                                      "+20 ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "manrope",
                                      ),
                                    ),
                                    Text(
                                      user!.phoneNumber ?? "Not Exist",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "manrope",
                                      ),
                                    ),
                                  ],
                                ),
                        ]),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ));
      },
    );
  }
}
