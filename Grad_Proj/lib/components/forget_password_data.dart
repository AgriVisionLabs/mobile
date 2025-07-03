import 'package:grd_proj/components/forget_password_info.dart';

class ForgetPasswordData {
  List<ForgetPasswordInfo> items = [
    ForgetPasswordInfo(
        title: "Forgot Password?",
        description:
        "Don’t worry! it occurs. Please enter the email address linked with your account.",
        button: "Send Code"),
    ForgetPasswordInfo(
        title: "OTP Verification",
        description:
        "Enter the verification code we just sent on your email address",
        button : "Verify"),
    ForgetPasswordInfo(
        title: "Reset Password",
        description:
        "",
        button: "Reset Password"),
  ];
}
