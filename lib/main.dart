import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:suri_checking_event_app/core/common/common.dart';
import 'package:suri_checking_event_app/core/helper/logger.dart';
import 'package:suri_checking_event_app/core/helper/timezone_helper.dart';
import 'package:suri_checking_event_app/core/routers/app_router.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:suri_checking_event_app/features/gift/presentation/bloc/gift_bloc.dart';
import 'package:suri_checking_event_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_bloc.dart';
import 'package:suri_checking_event_app/features/sponsor/presentation/bloc/sponsor_bloc.dart';
import 'package:suri_checking_event_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:suri_checking_event_app/firebase_options.dart';
import 'di_controller.dart' as di;
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));

  // set Device Orientation
  setOrientation();

  // Init firebase.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Init Get it.
  await di.init();

  // Set timezone
  TimeZoneHelper().initializeTimeZones();

  try {
    await SentryFlutter.init((options) {
      options.dsn =
          'https://a6ec6c881651b948e606d23667e76930@o4508376501583872.ingest.de.sentry.io/4508376505712720';

      options.tracesSampleRate = 1.0;
    },
        appRunner: () => runApp(MultiBlocProvider(providers: [
              // BlocProvider<ConnectivityBloc>(
              //   create: (context) => sl<ConnectivityBloc>(),
              // ),
              BlocProvider<AuthBloc>(
                create: (context) => sl<AuthBloc>(),
              ),
              BlocProvider<MainBloc>(
                create: (context) => sl<MainBloc>(),
              ),
              BlocProvider<HomeBloc>(
                create: (context) => sl<HomeBloc>(),
              ),
              BlocProvider<EventBloc>(
                create: (context) => sl<EventBloc>(),
              ),
              BlocProvider<SponsorBloc>(
                create: (context) => sl<SponsorBloc>(),
              ),
              BlocProvider<GiftBloc>(
                create: (context) => sl<GiftBloc>(),
              ),
              BlocProvider<UserBloc>(
                create: (context) => sl<UserBloc>(),
              ),
            ], child: const MyApp())));
  } catch (e, stackTrace) {
    AppLogger.error('App crashed on startup', e, stackTrace);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: MaterialApp(
          initialRoute: AppRoutes.SPLASH_PAGE,
          debugShowCheckedModeBanner: false,
          title: 'Checking Envent',
          onGenerateRoute: AppRoutes.generateRoute,
          theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
              TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
            }),
            brightness: Brightness.light,
            sliderTheme: const SliderThemeData(
              showValueIndicator: ShowValueIndicator.always,
            ),
          ),
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('vi', 'VN'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: const Locale('vi', 'VN'),
        ));
  }
}
