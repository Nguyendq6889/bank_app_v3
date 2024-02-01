import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';

import '../../app_assets/app_colors.dart';
import '../../app_assets/app_icons.dart';
import '../../app_assets/app_styles.dart';

class BiometricsAuthWidget extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  const BiometricsAuthWidget({super.key, required this.onChanged});

  @override
  State<BiometricsAuthWidget> createState() => _BiometricsAuthWidgetState();
}

class _BiometricsAuthWidgetState extends State<BiometricsAuthWidget> {
  bool _supportState = false;
  late final LocalAuthentication _auth;
  List<BiometricType> _availableBiometrics = [];

  @override
  void initState() {
    _auth = LocalAuthentication();
    _getAvailableBiometrics();
    _auth.isDeviceSupported().then((bool isSupported) => setState(() {
        _supportState = isSupported;
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _supportState ? GestureDetector(
      onTap: () => _authenticate(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _availableBiometrics.contains(BiometricType.face)
              ? SvgPicture.asset(AppIcons.iconFaceID, colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn))
              : SvgPicture.asset(AppIcons.iconFingerprint),
          const SizedBox(width: 12),
          Text(
            _availableBiometrics.contains(BiometricType.face)
                ? 'Face ID'
                : 'Touch ID',
            style: AppStyles.textButtonBlack.copyWith(fontWeight: FontWeight.w600),
          )
        ],
      ),
    ) : const SizedBox();
  }

  // Function to retrieve available biometric methods supported by the device.
  Future<void> _getAvailableBiometrics() async {
    _availableBiometrics = await _auth.getAvailableBiometrics(); // Call the authentication service to get the list of available biometrics.
    if (kDebugMode) {
      // If in debug mode, print the list of available biometrics.
      print('List of _availableBiometrics: $_availableBiometrics');
    }
    // Check if the widget is still mounted before proceeding.
    // This is important to avoid updating the state of an unmounted widget.
    if (!mounted) {
      return;
    }
  }

// Biometric authentication function.
  Future<void> _authenticate() async {
    try {
      // Attempt to authenticate using biometrics.
      bool authenticated = await _auth.authenticate(
        localizedReason: 'text_use_finger'.tr(),      // Use the tr() method to enable translation feature.
        options: const AuthenticationOptions(stickyAuth: true, biometricOnly: true),
      );
      if (kDebugMode) {
        // If in debug mode, print whether authentication was successful.
        print('Authenticated: $authenticated');
      }
      if (authenticated) {
        // Nếu xác thực thành công thì gọi hàm onChanged và truyền vào true để sau đó gọi hàm _goToDashboardPage bên trang SignIn.
        widget.onChanged.call(true);
      }
    } on PlatformException catch (e) {
      // Catch and print any platform-specific exceptions that may occur.
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
