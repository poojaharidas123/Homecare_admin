import 'package:flutter/material.dart';
import 'package:homecare_admin/ui/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: SizedBox(
          width: 300,
          height: 400,
          child: Column(
            children: [
              Material(
                color: Colors.white,
                child: SizedBox(
                  height: 100,
                  width: 50,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                  label: 'e-mail',
                  buttonColor: Colors.white,
                  textColor: Colors.grey,
                  onPressed: () {}),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                  label: 'password',
                  buttonColor: Colors.white,
                  textColor: Colors.grey,
                  onPressed: () {}),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                  label: 'Login',
                  buttonColor: Color(0xFFAAD013),
                  textColor: Colors.white,
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    ));
  }
}
