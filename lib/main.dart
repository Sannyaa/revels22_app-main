import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mitrevels22/logic/blocs/categories/bloc/categories_bloc.dart';
import 'package:mitrevels22/logic/blocs/delegate_card/bloc/delegate_card_bloc.dart';
import 'package:mitrevels22/logic/blocs/events/bloc/events_bloc.dart';
import 'package:mitrevels22/logic/blocs/faq/bloc/faq_bloc.dart';
import 'package:mitrevels22/logic/blocs/proshow/bloc/proshow_bloc.dart';
import 'package:mitrevels22/logic/router.dart';
import 'package:path_provider/path_provider.dart';
import 'logic/blocs/auth/bloc/auth_bloc.dart';
import 'logic/blocs/featured_events/bloc/featured_events_bloc.dart';
import 'logic/blocs/user/bloc/user_bloc.dart';
import 'logic/cubits/token/cubit/token_cubit.dart';
import 'package:uni_links/uni_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'logic/cubits/user_data/cubit/user_data_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());
  await Hive.initFlutter();
  await Hive.openBox('liked_events');
  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp()),
    storage: storage,
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _initialLink;

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  Future<void> initUniLinks() async {
    linkStream.listen((String? link) {
      setState(() {
        _initialLink = link;
      });
    }, onError: (err) {
      debugPrint(err);
    });
    try {
      _initialLink = await getInitialLink();
    } on PlatformException {
      debugPrint('Failed to get initial link.');
    }
  }

  ThemeData _getMaterialTheme(NeumorphicThemeData theme) {
    final color = theme.accentColor;

    if (color is MaterialColor) {
      return ThemeData(
        primarySwatch: color,
        textTheme: theme.textTheme,
        iconTheme: theme.iconTheme,
        scaffoldBackgroundColor: theme.baseColor,
      );
    }

    return ThemeData(
      primaryColor: theme.accentColor,
      accentColor: theme.variantColor,
      iconTheme: theme.iconTheme,
      brightness: ThemeData.estimateBrightnessForColor(theme.baseColor),
      primaryColorBrightness:
          ThemeData.estimateBrightnessForColor(theme.accentColor),
      accentColorBrightness:
          ThemeData.estimateBrightnessForColor(theme.variantColor),
      textTheme: theme.textTheme,
      scaffoldBackgroundColor: theme.baseColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final darkTheme = NeumorphicThemeData(
      appBarTheme: const NeumorphicAppBarThemeData(
        buttonStyle: NeumorphicStyle(
          depth: 4,
          shadowDarkColor: Colors.black,
          shadowLightColor: Color(0xFF454954),
          boxShape: NeumorphicBoxShape.circle(),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      baseColor: const Color(0xFF21242B),
      shadowLightColor: const Color(0xFF454954),
      shadowDarkColor: Colors.black,
      shadowLightColorEmboss: const Color(0xFF454954),
      shadowDarkColorEmboss: Colors.black,
      defaultTextColor: Colors.white,
      textTheme: GoogleFonts.cabinTextTheme(),
    );
    final materialTheme = _getMaterialTheme(neumorphicDefaultTheme);
    final materialDarkTheme = _getMaterialTheme(darkTheme);
    return FutureBuilder(
        future: widget.messaging.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        ),
        builder: (context, settings) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    FeaturedEventsBloc()..add(FeaturedEventsInit()),
              ),
              BlocProvider(
                create: (context) => AuthBloc(),
              ),
              BlocProvider(
                create: (context) => EventsBloc(),
              ),
              BlocProvider(
                  create: (context) =>
                      DelegateCardBloc()..add(DelegateCardInit())),
              BlocProvider(create: (context) => FaqBloc()..add(FaqInit())),
              BlocProvider(
                create: (context) => CategoriesBloc(),
              ),
              BlocProvider(
                  create: (context) => ProshowBloc()..add(ProshowInit())),
              BlocProvider(
                create: (context) => TokenCubit(),
              ),
              BlocProvider(
                create: (context) => UserDataCubit(),
              ),
              BlocProvider(
                create: (context) => UserBloc(),
              ),
            ],
            child: NeumorphicTheme(
              themeMode: ThemeMode.dark,
              darkTheme: darkTheme,
              child: Builder(builder: (context) {
                return IconTheme(
                  data: NeumorphicTheme.currentTheme(context).iconTheme,
                  child: MaterialApp.router(
                    routeInformationParser: RevelsRouteInformationParser(),
                    routerDelegate: RevelsRouterDelegate(
                      appState: RevelsAppState(),
                    ),
                    routeInformationProvider: PlatformRouteInformationProvider(
                      initialRouteInformation:
                          RouteInformation(location: _initialLink ?? '/'),
                    ),
                    theme: materialTheme,
                    darkTheme: materialDarkTheme,
                    themeMode: ThemeMode.dark,
                  ),
                );
              }),
            ),
          );
        });
  }
}
