import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_souq/app/screens/start_screen.dart';
import 'package:my_souq/app/services/auth_services.dart';
import 'package:my_souq/app/widgets/custom_bottom_bar.dart';
import 'package:my_souq/providers/user_provider.dart';
import 'package:my_souq/router.dart';
import 'package:provider/provider.dart';
import 'components/mainComponent/declarations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findRootAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();

  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Souq Elshayeb',
      theme: ThemeData(
        scaffoldBackgroundColor: Declarations.backgroundColor,
        colorScheme:
            const ColorScheme.light(primary: Declarations.secondaryColor),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? const BottomBar()
          : const StartScreen(),
    );
  }
}
