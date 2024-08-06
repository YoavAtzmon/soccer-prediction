import 'package:flutter/material.dart';
import 'package:namer_app/config/env.dart';
import 'package:namer_app/providers/local_provider.dart';
import 'package:namer_app/providers/user_leagues.dart';
import 'package:namer_app/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvironmentConfig().initialize();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserLeagueProvider()),
      ChangeNotifierProvider(create: (_) => LocaleProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return MaterialApp(
          title: 'Namer App',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          ),
          locale: Locale(localeProvider.locale.languageCode),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('he', ''),
          ],
          home: FutureBuilder(
            future: Future.value(EnvironmentConfig.firebaseApp),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('You have an error! ${snapshot.error.toString()}');
                return const Center(child: Text('Something went wrong'));
              } else if (snapshot.hasData) {
                return const MyHomePage();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      },
    );
  }
}
