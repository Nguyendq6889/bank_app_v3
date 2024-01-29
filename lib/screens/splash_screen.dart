import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_assets/app_colors.dart';
import '../modules/sign_in/pages/sign_in_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive); // Hide the default device navigation bar.

    // Delay the navigation to the SignInPage by 2 seconds.
    Future.delayed(const Duration(seconds: 2), () {
      // After 2 seconds, navigate to the SignInPage and replace the current SplashScreen.
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const SignInPage()));
      // Navigator.pushReplacementNamed(context, 'SignInPage');
    });
    super.initState();
  }

  @override
  void dispose() {
    // Restore the default navigation bar of the device.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width, // Set the width of the Container equal to the width of the device.
        height: MediaQuery.of(context).size.height, // Set the height of the Container equal to the height of the device.
        decoration: const BoxDecoration(
          gradient: AppColors.colorAppBar,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'welcome_to'.tr(),  // Use the tr() method to enable translation feature.
                style: const TextStyle(
                  height: 1.5,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                )
              ),
              const SizedBox(height: 16),
              const Text(
                "Mobile banking",
                style: TextStyle(
                  height: 1.5,
                  fontSize: 36,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
