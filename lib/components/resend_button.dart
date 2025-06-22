import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grd_proj/components/color.dart';

class ResendButton extends StatefulWidget {
  const ResendButton({super.key});

  @override
  State<ResendButton> createState() => _ResendButtonState();
}

class _ResendButtonState extends State<ResendButton> {
  int _seconds = 30;
  bool _canResend = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _canResend = false;
    _seconds = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
        if (_seconds == 00) {
// هنا تحط كود إرسال التفعيل الجديد
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void _onResendPressed() {
    // هنا تحط كود إرسال التفعيل الجديد
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _canResend ? _onResendPressed : () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: _canResend ? primaryColor : Colors.grey[100],
        minimumSize: _canResend ? const Size(297, 62) : const Size(200, 62),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(45),
        ),
      ),
      child: Text(
        _canResend ? 'Resend verification email' : 'Resend In ${_seconds.toString().padLeft(2, '1')} S',
        style: TextStyle(
          color: _canResend ? Colors.white : Colors.grey,
          fontSize: _canResend ? 20 : 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
