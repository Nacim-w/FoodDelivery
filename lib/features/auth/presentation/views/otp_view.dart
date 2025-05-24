import 'dart:async';
import 'package:flutter/material.dart';
import 'package:legy/core/res/styles/text.dart';
import 'package:legy/features/auth/presentation/widgets/opt/otp_form_widget.dart';

class OtpView extends StatefulWidget {
  static const routePath = 'OtpView';

  const OtpView({super.key});

  @override
  State<OtpView> createState() => OtpViewState();
}

class OtpViewState extends State<OtpView> {
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
          child: OtpForm(),
        ),
      ),
    );
  }
}
