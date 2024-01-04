import '/custom_code/actions/index.dart' as actions;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';
import 'backend/firebase/firebase_config.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:new_qasas/custom_code/actions/player_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await initFirebase();

  // Start initial custom actions code
  await actions.changeStatusBarColor();
  await actions.fixDeviceOrientationUp();
  await actions.initAudioService();
  // End initial custom actions code

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => appState),
        Provider<PlayerBloc>(
          create: (context) => PlayerBloc(
            musicUrls: [
              'https://firebasestorage.googleapis.com/v0/b/qasasapp.appspot.com/o/users%2FfOXq1u3t0tX6PmLfdAIyRp4qxEo2%2Fuploads%2F1703717170915000_0.mp3?alt=media&token=cb103b00-b823-4b7a-9ac8-de905a6649d9',
              'https://firebasestorage.googleapis.com/v0/b/qasasapp.appspot.com/o/users%2FfOXq1u3t0tX6PmLfdAIyRp4qxEo2%2Fuploads%2F1703717170915000_1.mp3?alt=media&token=e2d89aa7-15ad-42c6-af72-ef6657db93da',
              'https://firebasestorage.googleapis.com/v0/b/qasasapp.appspot.com/o/users%2FfOXq1u3t0tX6PmLfdAIyRp4qxEo2%2Fuploads%2F1703717170915000_2.mp3?alt=media&token=7cc477a5-e5e9-4322-8523-2002bee96e9d',
            ],
            titles: [
              'test track 1',
              'test track 2',
              'test track 3',
            ],
            initialUrl:
                'https://firebasestorage.googleapis.com/v0/b/qasasapp.appspot.com/o/users%2FfOXq1u3t0tX6PmLfdAIyRp4qxEo2%2Fuploads%2F1703717160888000.mp3?alt=media&token=61b7c3a5-ce89-4475-9f95-071a5d44b092',
            playlistImage:
                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/new-qasas-f219mx/assets/3tgx6hyivp6h/NEW2_LOGO-PWA-512-Noa.png',
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;

  late Stream<BaseAuthUser> userStream;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  final authUserSub = authenticatedUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = newQasasFirebaseUserStream()
      ..listen((user) => _appStateNotifier.update(user));
    jwtTokenStream.listen((_) {});
    Future.delayed(
      const Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();

    super.dispose();
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NEW QASAS',
      localizationsDelegates: const [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: const ScrollbarThemeData(),
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}
