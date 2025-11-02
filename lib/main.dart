import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'screens/common/language_selection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('te', 'IN'),
      ],
      path: 'assets/lang', // folder for en-US.json & te-IN.json
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Healthy Steps',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'NotoSansTelugu',
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const LanguageSelectionScreen(), // 🟢 first screen
    );
  }
}
