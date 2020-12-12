import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:what_food/Screens/Login/components/background.dart';

import 'package:what_food/Screens/Signup/signup_screen.dart';
import 'package:what_food/Services/AuthService.dart';
import 'package:what_food/components/already_have_an_account_acheck.dart';
import 'package:what_food/components/rounded_button.dart';
import 'package:what_food/components/rounded_input_field.dart';
import 'package:what_food/components/rounded_password_field.dart';

class Body extends StatelessWidget {
  String _phone, _password;

  @override
  Widget build(BuildContext context) {
    _submit() {
      AuthService.login_Dio(_phone, _password);
    }

    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/user-svgrepo-com.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Phone",
              onChanged: (value) => _phone = value,
            ),
            RoundedPasswordField(
              onChanged: (value) => _password = value,
            ),
            RoundedButton(
              text: "LOGIN",
              press: _submit,
            ),
            SizedBox(height: size.height * 0.13),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
