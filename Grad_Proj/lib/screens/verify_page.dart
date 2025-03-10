import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Components/color.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool isSuccess = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is ConfirmEmailSuccess) {
        ScaffoldMessenger.of(context).clearSnackBars();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("success"),
            ),
          );
        });
      } else if (state is ConfirmEmailFailure) {
        ScaffoldMessenger.of(context).clearSnackBars();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
            ),
          );
        });
      }
    }, builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 100),
            width: 380,
            height: 700,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              SizedBox(
                height: 150,
                width: 350,
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
              const Text(
                'Welcome to Agrivision',
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: "Manrope",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'We re excited to have you on board. Let\'s verify your email to get started.',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "Manrope",
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Form(
                key: context.read<UserCubit>().confirmFormKey,
                child: TextFormField(
                  controller: context.read<UserCubit>().confirmToken,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: "Confirm Link",
                    hintStyle: const TextStyle(color: borderColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(color: borderColor, width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(color: primaryColor, width: 3.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: errorColor, width: 3.0),
                    ),
                  ),
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your Confirm Token";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1E6930),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8)),
                  onPressed: () {
                    BlocProvider.of<UserCubit>(context).confirmEmail();
                    if (state is ConfirmEmailSuccess) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontFamily: "Manrope",
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1E6930),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8)),
                  onPressed: () {
                    BlocProvider.of<UserCubit>(context).confirmEmailResand();
                  },
                  child: const Text(
                    'Resand verify',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: "Manrope",
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ]),
          ),
        ),
      );
    });
  }
}
