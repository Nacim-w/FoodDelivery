import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testing/common/res/styles/text.dart';
import 'package:testing/pages/auth/opt/widgets/otp_form_widget.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => OtpPageState();
}

class OtpPageState extends State<OtpPage> {
  int remainingSeconds = 600;
  Timer? timer;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    setState(() {
      canResend = false;
      remainingSeconds = 20;
    });

    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        setState(() {
          canResend = true;
        });
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('OTP', style: TextStyles.textSemiBold),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: OtpForm(
            canResend: canResend,
            remainingSeconds: remainingSeconds,
            startTimer: startTimer,
          ),
        ),
      ),
    );
  }
}
