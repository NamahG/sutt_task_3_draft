import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'phone.dart';
import 'package:pinput/pinput.dart';


class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  // static String verify = "";
  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  Widget build(BuildContext context) {




    var smsCode = " ";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context) ;
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Please enter the OTP you received in your messages.",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value){
                  smsCode = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: ()  async {
                      // Create a PhoneAuthCredential with the code
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(
                          verificationId: Phone.verify, smsCode: smsCode);

                      // Sign the user in (or link) with the credential
                      await FirebaseAuth.instance.signInWithCredential(credential);
                      Navigator.pushNamed(context, 'station_input');
                    },
                    child: const Text("Verify OTP")),
              ),
              TextButton(onPressed: () async {
                // Navigator.pushNamedAndRemoveUntil(context, 'phone', (route) => false);

                Navigator.pushNamedAndRemoveUntil(context, 'phone', (route) => false);
              },
                  child: const Text(
                    'Edit Phone Number?',
                    style: TextStyle(
                      // fontSize: 12,
                      color: Colors.blue,
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}