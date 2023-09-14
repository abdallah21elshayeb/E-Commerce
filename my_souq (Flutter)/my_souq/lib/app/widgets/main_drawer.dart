import 'package:flutter/material.dart';
import 'package:my_souq/app/screens/home_screen.dart';
import 'package:my_souq/app/widgets/social_media_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_souq/components/mainComponent/declarations.dart';
import 'package:my_souq/main.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/language.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum SocialMedia { facebook, twitter, instgram, youtube }

class MainDrawer extends StatefulWidget {
  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  Language? selectedLanguage;

  Future share(SocialMedia socialPlatform) async {
    final urls = {
      SocialMedia.facebook: 'https://www.facebook.com/abdallah.elshayeb.5',
      SocialMedia.twitter: '',
      SocialMedia.instgram: '',
      SocialMedia.youtube: '',
    };
    final url = urls[socialPlatform]!;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Widget buildListTile(String title, IconData icon, Function tabHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Colors.blue,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'RootoCondensed',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tabHandler as void Function()?,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 235, 235, 235),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 120,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 60,
                height: 60,
              ),
              Text(
                'Souq El-Shayeb',
                style: TextStyle(
                  color: Declarations.secondaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        buildListTile('Home', Icons.home, () {
          Navigator.of(context).pushNamed(HomeScreen.routeName);
        }),
        buildListTile('About Us!', Icons.person, () {
          Navigator.of(context).pushNamed('');
        }),
        Row(
          children: [
            Container(
              padding: AppLocalizations.of(context)!.localeName == 'ar'
                  ? EdgeInsets.only(right: 15)
                  : EdgeInsets.only(left: 15),
              child: Icon(
                Icons.language,
                color: Colors.blue,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton<String>(
                underline: const SizedBox(),
                iconSize: 30,
                iconEnabledColor: Colors.blue,
                value: selectedLanguage != null
                    ? '${selectedLanguage!.flag} ${selectedLanguage!.languageCode}'
                    : null,
                onChanged: (String? newValue) {
                  setState(() {
                    final languageCode = newValue?.split(' ').last;
                    selectedLanguage = Language.languageList().firstWhere(
                        (language) => language.languageCode == languageCode);
                    MyApp.setLocale(
                      context,
                      Locale(selectedLanguage!.languageCode, ''),
                    );
                  });
                },
                items: Language.languageList()
                    .map<DropdownMenuItem<String>>(
                      (e) => DropdownMenuItem<String>(
                        value: '${e.flag} ${e.languageCode}',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              e.flag,
                              style: const TextStyle(fontSize: 30),
                            ),
                            Text(e.name),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialMediaButton(
              icon: FontAwesomeIcons.facebook,
              color: Colors.black,
              onClicked: () => share(SocialMedia.facebook),
            ),
            SocialMediaButton(
              icon: FontAwesomeIcons.twitter,
              color: Colors.black,
              onClicked: () => share(SocialMedia.twitter),
            ),
            SocialMediaButton(
              icon: FontAwesomeIcons.instagram,
              color: Colors.black,
              onClicked: () => share(SocialMedia.instgram),
            ),
            SocialMediaButton(
              icon: FontAwesomeIcons.youtube,
              color: Colors.black,
              onClicked: () => share(SocialMedia.youtube),
            ),
          ],
        )
      ]),
    );
  }
}
