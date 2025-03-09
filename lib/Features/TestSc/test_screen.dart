import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final controller = TextEditingController();
  EmailOTP myAuth = EmailOTP();
  void sendCode() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 40),
              ),
              onPressed: () async {
                myAuth.setConfig(
                    appEmail: "mobin.ahmadiaa6@gmail.com",
                    appName: "aio movie",
                    userEmail: 'mobin1384ahmadi1384@gmail.com',
                    otpLength: 5,
                    otpType: OTPType.digitsOnly);
                if (await myAuth.sendOTP() == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('send code to your email'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('no send code'),
                    ),
                  );
                }
              },
              child: const Text(
                'send code',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                color: Colors.red,
              ))),
            ),
            ElevatedButton(
              onPressed: () async {
                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) {
                //     return VerificationSCreen(myAuth);
                //   },
                // ));
              },
              child: const Text('confirm'),
            )
          ],
        ),
      ),
    );
  }
}
