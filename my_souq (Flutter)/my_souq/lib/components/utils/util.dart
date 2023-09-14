import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showSnackBar(BuildContext context, String Txt) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(Txt)),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (files != null && files.files.isNotEmpty) {
      for (var i = 0; i < files.files.length; i++) {
        images.add(
          File(files.files[i].path!),
        );
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}

showAlertDialog(BuildContext context, VoidCallback onOk, String txtHead,
    String txtMessage) {
  Widget cancelButton = TextButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: Text(AppLocalizations.of(context)!.cancel),
  );
  Widget okButton = TextButton(
    onPressed: onOk,
    child: Text(AppLocalizations.of(context)!.ok),
  );

  AlertDialog alertDialog = AlertDialog(
    title: Text(txtHead),
    content: Text(txtMessage),
    actions: [
      cancelButton,
      okButton,
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

showAlertDialog2(BuildContext context, String txtHead, String txtMessage) {
  Widget cancelButton = TextButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: const Text('Ok'),
  );

  AlertDialog alertDialog = AlertDialog(
    title: Text(txtHead),
    content: Text(txtMessage),
    actions: [
      cancelButton,
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

String getStatus(int value) {
  switch (value) {
    case 0:
      return "pending";
    case 1:
      return "Preparing";
    case 2:
      return "Ready";
    case 3:
      return "On Way";
    case 4:
      return "Completed";
    default:
      return "Preparing";
  }
}

Color getStatusColor(int value) {
  switch (value) {
    case 0:
      return Colors.green;
    case 1:
      return Colors.blue;
    case 2:
      return Colors.yellowAccent;
    case 3:
      return Colors.deepOrange;
    case 4:
      return Colors.purple;
    default:
      return Colors.green;
  }
}

double getProportionateScreenHeight(double inputHeight, BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  return (inputHeight / 812.0) * screenHeight;
}

double getProportionateScreenWidth(double inputWidth, BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  return (inputWidth / 375.0) * screenWidth;
}
