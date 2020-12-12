import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:what_food/Screens/Login/login_screen.dart';
import 'package:what_food/Screens/Signup/components/background.dart';
import 'package:what_food/Screens/Signup/components/or_divider.dart';
import 'package:what_food/Screens/Signup/components/social_icon.dart';
import 'package:what_food/Services/AuthService.dart';
import 'package:what_food/components/already_have_an_account_acheck.dart';
import 'package:what_food/components/rounded_button.dart';
import 'package:what_food/components/rounded_input_field.dart';
import 'package:what_food/components/rounded_password_field.dart';

class Body extends StatelessWidget {
  String _phone, _password, _email, _name;

  @override
  Widget build(BuildContext context) {
    _submit() {
      AuthService.signup_Dio(_phone, _password, _email, _name);
    }

    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGN UP",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.02),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.15,
            ),
            RoundedInputField(
              hintText: "Your Phone",
              onChanged: (value) => _phone = value,
            ),
            RoundedPasswordField(
              onChanged: (value) => _password = value,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) => _email = value,
            ),
            RoundedInputField(
              hintText: "Your Name",
              onChanged: (value) => _name = value,
            ),
            RoundedButton(
              text: "SIGNUP",
              press: _submit,
            ),
            SizedBox(height: size.height * 0.005),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
