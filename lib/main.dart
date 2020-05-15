import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tog3ther/pages/oneway_page/oneway_page.dart';
import 'package:tog3ther/services/config/config_service.dart';
import 'package:tog3ther/services/translation/translation_service.dart';
import 'package:tog3ther/tools/language_bloc_base/language_bloc_base.dart';
import 'package:tog3ther/tools/translations_bloc/translations_bloc.dart';

void main() async {
  //await allTranslations.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TranslationsBloc translationsBloc;

  @override
  void initState() {
    super.initState();
    translationsBloc = TranslationsBloc();
  }

  @override
  void dispose() {
    translationsBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StyledToast(
      textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
      backgroundColor: Color(0x99000000),
      borderRadius: BorderRadius.circular(5.0),
      textPadding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
      toastPositions: StyledToastPosition.bottom,
      toastAnimation: StyledToastAnimation.slideFromBottomFade,
      reverseAnimation: StyledToastAnimation.slideFromBottomFade,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(seconds: 4),
      animDuration: Duration(seconds: 1),
      dismissOtherOnShow: true,
      movingOnWindowChange: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tog3ther',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: snapshot.data ?? allTranslations.locale,
        supportedLocales: allTranslations.supportedLocales(),
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          visualDensity: VisualDensity.adaptivePlatformDensity,

          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: MyHomePage(),
      ),
    );
  }

  /* SoonTM
  @override
  Widget build(BuildContext context) {
    return LanguageBlocProvider<TranslationsBloc>(
      bloc: translationsBloc,
      child: StreamBuilder<Locale>(
          stream: translationsBloc.currentLocale,
          initialData: allTranslations.locale,
          builder: (BuildContext context, AsyncSnapshot<Locale> snapshot) {
            return StyledToast(
              textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
              backgroundColor: Color(0x99000000),
              borderRadius: BorderRadius.circular(5.0),
              textPadding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
              toastPositions: StyledToastPosition.bottom,
              toastAnimation: StyledToastAnimation.slideFromBottomFade,
              reverseAnimation: StyledToastAnimation.slideFromBottomFade,
              curve: Curves.fastOutSlowIn,
              reverseCurve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(seconds: 4),
              animDuration: Duration(seconds: 1),
              dismissOtherOnShow: true,
              movingOnWindowChange: true,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Tog3ther',
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                locale: snapshot.data ?? allTranslations.locale,
                supportedLocales: allTranslations.supportedLocales(),
                theme: ThemeData(
                  primarySwatch: Colors.cyan,
                  visualDensity: VisualDensity.adaptivePlatformDensity,

                  textTheme: GoogleFonts.latoTextTheme(
                    Theme.of(context).textTheme,
                  ),
                ),
                home: MyHomePage(),
              ),
            );
          }
      ),
    );
  }*/
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).canvasColor,
      statusBarColor: Colors.transparent, // status bar color
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));

    if (kIsWeb) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OnewayPage()));
    } else {
      prepareApp().then((value) async {
        await Future.delayed(Duration(seconds: 1));
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OnewayPage()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(
                'assets/logo/logo_transparent_without_name.webp'
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
            ),
            SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> prepareApp() async {
    await _applyConfig();
    await _applyAppInformation();
  }

  Future<void> _applyConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var config = await ConfigService.get();

    for (var i in config.keyValuePairs) {
      if (i.shouldDelete != true) {
        if (i.value is String) {
          prefs.setString(i.key, i.value);
        }
        if (i.value is int) {
          prefs.setInt(i.key, i.value);
        }
        if (i.value is double) {
          prefs.setDouble(i.key, i.value);
        }
        if (i.value is bool) {
          prefs.setBool(i.key, i.value);
        }
        if (i.value is List<String>) {
          prefs.setStringList(i.key, i.value);
        }
        print("Added Key: " + i.key + " with value: " + i.value.toString());
      } else {
        prefs.remove(i.key);
        print("Removed Key: " + i.key);
      }
    }
  }

  Future<void> _applyAppInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    prefs.setString('app_name', packageInfo.appName);
    prefs.setString('package_name', packageInfo.packageName);
    prefs.setString('version', packageInfo.version);
    prefs.setString('build_number', packageInfo.buildNumber);
  }
}
