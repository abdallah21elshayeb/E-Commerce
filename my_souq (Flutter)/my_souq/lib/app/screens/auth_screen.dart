import 'package:flutter/material.dart';
import 'package:my_souq/app/screens/signUp_screen.dart';
import 'package:my_souq/app/services/auth_services.dart';
import 'package:my_souq/app/widgets/custom_button.dart';
import 'package:my_souq/app/widgets/custom_text.dart';
import 'package:my_souq/components/mainComponent/declarations.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth-screen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _signInKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  final TextEditingController _emailTxt = TextEditingController();
  final TextEditingController _passwordTxt = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailTxt.dispose();
    _passwordTxt.dispose();
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailTxt.text,
      password: _passwordTxt.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Declarations.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 250,
                    height: 250,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Declarations.backgroundColor,
                    child: Form(
                      key: _signInKey,
                      child: Column(
                        children: [
                          CustomText(
                            controller: _emailTxt,
                            hintTxt: 'Email',
                            icon: Icons.email_outlined,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            controller: _passwordTxt,
                            hintTxt: 'Password',
                            icon: Icons.password_outlined,
                            isPassword: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              text: 'sign In',
                              onTap: () {
                                if (_signInKey.currentState!.validate()) {
                                  signInUser();
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 250,
                    child: CustomButton(
                        text: 'Create new account',
                        color: const Color.fromARGB(255, 79, 201, 172),
                        onTap: () {
                          Navigator.pushNamed(context, SignupScreen.routeName);
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Image.asset(
                            "assets/buttons/google.png",
                            width: 250,
                          ),
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          child: Image.asset(
                            "assets/buttons/fb.png",
                            width: 250,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
