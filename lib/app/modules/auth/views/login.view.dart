import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_v101/app/modules/auth/controllers/auth_controller.dart';
import 'package:fyp_v101/app/ui/component/checkbox_login.dart';
import 'package:fyp_v101/app/ui/component/login_textField.dart';
import 'package:get/get.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                width: 1.sw,
                height: 0.25.sh,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("imgs/splash_top.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 22),
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        color: Color(0xFF333333),
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                'Hi! Welcome back, you have been missed.',
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(
                      'Username',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        color: Color(0xFF454545),
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: MyTextField(
                      controller: controller.username,
                      hintText: 'Enter Username / Acc No',
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        color: Color(0xFF454545),
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: MyTextField(
                      controller: controller.password,
                      hintText: 'Enter Password',
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: 5),
                        RectangularCheckbox(
                          isChecked: controller.rememberMe.value,
                          onChanged: (value) {
                            controller.rememberMe.value =
                                value; // Update the state variable
                          },
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Remember me',
                          style: TextStyle(
                            color: Color(0xFF4285F4),
                          ),
                        ),
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Forget Password?'),
                                  content: const Text(
                                      'To reset your password, contact us:\n  hammadsafeer42@gmail.com'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Forget Password?',
                            style: TextStyle(
                              color: Color(0xFF4285F4),
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFF4285F4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 1.sw,
                  height: 0.45.sh,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("imgs/splash_bottom.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          // Check if username and password are correct
                          // For demonstration, assume username is 'admin' and password is 'admin123'
                          if (controller.username.text.isEmail &&
                              controller.password.text.length > 5) {
                            controller.loginWithEmail(context);
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text(
                                      'Invalid username or password'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(
                                0xFF4285F4), // Set the background color here
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            const Size(339, 44),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 18,
                              color: Color(0xFFFFFFFF)),
                        ),
                      ),

                      const SizedBox(
                          height:
                              40), // Add some space between the button and the text
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account?',
                            style: TextStyle(
                              color: Color(
                                  0xFF616161), // Use the same color as the button
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            ' Sign up',
                            style: TextStyle(
                              color: Color(
                                  0xFF4285F4), // Use the same color as the button
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      Expanded(child: Container()),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 90),
                          child: Text(
                            'App Version 1.01',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              color: Color(0xFF616161),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
