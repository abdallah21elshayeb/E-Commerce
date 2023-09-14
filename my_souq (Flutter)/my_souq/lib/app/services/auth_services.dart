import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_souq/app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:my_souq/app/screens/auth_screen.dart';
import 'package:my_souq/app/widgets/custom_bottom_bar.dart';
import 'package:my_souq/components/error/errorHandling.dart';
import 'package:my_souq/components/utils/util.dart';
import 'package:my_souq/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/mainComponent/declarations.dart';

class AuthService {
  void signUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) async {
    try {
      User user = User(
          id: '',
          name: name,
          password: password,
          address: '',
          type: '',
          token: '',
          email: email,
          cart: []);

      http.Response res = await http.post(
        Uri.parse('$url01/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
      );

      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Account created, Now you are login");
            Navigator.pushNamed(context, AuthScreen.routeName);
          });
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('$url01/api/signin'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8'
          });

      // ignore: use_build_context_synchronously
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await preferences.setString(
                "souq-elshayeb-auth-token", jsonDecode(res.body)['token']);
            // showSnackBar(context, "Success you are welcome :))");
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          });
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString('souq-elshayeb-auth-token');
      if (token == null) {
        sp.setString('souq-elshayeb-auth-token', '');
      }

      var resToken = await http.post(
        Uri.parse('$url01/isValidToken'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'souq-elshayeb-auth-token': token!
        },
      );

      var response = jsonDecode(resToken.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$url01/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'souq-elshayeb-auth-token': token
          },
        );
        // ignore: use_build_context_synchronously
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('souq-elshayeb-auth-token', '');

      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routeName, (route) => false);
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }
}
