import 'package:bank_app_v3/config/dio_config.dart';
import 'package:bank_app_v3/features/authentication/cubits/auth_cubit.dart';
import 'package:bank_app_v3/features/authentication/repository/auth_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/router.dart';
import 'features/authentication/api/auth_api.dart';
import 'utils/local_data.dart';
import 'widgets/loading_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Needs to be called so that we can await for EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([   // Ensure the application always displays in portrait mode.
    DeviceOrientation.portraitUp,
  ]);
  await EasyLocalization.ensureInitialized();  // Initialize EasyLocalization to load translations.
  final SharedPreferences sharedPre = await SharedPreferences.getInstance();    // Retrieve an instance of SharedPreferences.
  final bool english = _getLanguage(sharedPre);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],  // Define supported locales for localization.
      path: 'assets/translations',  // Specify the path where translation files are located.
      startLocale: const Locale('en', 'US'),  // Set the default locale when the app starts.
      fallbackLocale: english ? const Locale('en', 'US') : const Locale('vi', 'VN'),  // Set the fallback locale based on the user's language preference.
      child: MyApp(sharedPre),
    ),
  );
}

// Function to retrieve the saved language preference from SharedPreferences.
bool _getLanguage(SharedPreferences sharedPre) {
  final String language = sharedPre.getString('language') ?? 'en_US';    // Get the saved language preference from SharedPreferences, defaulting to 'en_US' if not found.
  if (language == 'vi_VN') {
    return false;
  }
  return true;
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPre;
  const MyApp(this.sharedPre, {super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(     // This widget is from the loader_overlay package to create loading effects for the app.
      overlayColor: Colors.black.withOpacity(0.3),
      overlayWidgetBuilder: (progress) {
        return const LoadingWidget();     // LoadingWidget in lib/widgets/loading_widget.dart file.
      },
      child: RepositoryProvider(
        create: (context) => AuthRepo(AuthApi(dio), LocalData(sharedPre)),
        child: BlocProvider(
          create: (context) => AuthCubit(context.read<AuthRepo>()),
          child: const AppContent(),
        ),
      ),
    );
  }
}


class AppContent extends StatefulWidget {
  const AppContent({
    super.key,
  });

  @override
  State<AppContent> createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().authentication();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    if (authState is AuthInitialState) {
      return Container();
    }
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,  // Remove the debug banner in the top right corner.
      // Use the localizationDelegates, supportedLocales, and locale from the context.
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        // useMaterial3: true,     // Sử dụng Material 3
        fontFamily: 'Mulish',  // Set the default font family for the entire app.
        primarySwatch: Colors.blue,
        // Disable default Widget splash effect in Flutter.
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      routerConfig: router,
    );
  }
}