import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../app_assets/app_styles.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Text(
          'error_message'.tr(),
          textAlign: TextAlign.center,
          style: AppStyles.textNormalBlack,
        ),
      ),
    );
  }
}
