import 'package:flutter/material.dart';

import '../../components/mainComponent/declarations.dart';
import '../services/auth_services.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const String routeName = "/signup-screen";
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signUpKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  final TextEditingController _emailTxt = TextEditingController();
  final TextEditingController _passwordTxt = TextEditingController();
  final TextEditingController _nameTxt = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailTxt.dispose();
    _passwordTxt.dispose();
    _nameTxt.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailTxt.text,
        password: _passwordTxt.text,
        name: _nameTxt.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    'it\'s quick and easy.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 250,
                      height: 250,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Declarations.backgroundColor,
                    child: Form(
                      key: _signUpKey,
                      child: Column(
                        children: [
                          CustomText(
                            controller: _nameTxt,
                            hintTxt: 'Name',
                            icon: Icons.person_outline,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                              text: 'sign Up',
                              onTap: () {
                                if (_signUpKey.currentState!.validate()) {
                                  signUpUser();
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
