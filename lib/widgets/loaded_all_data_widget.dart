import 'package:flutter/material.dart';

import '../app_assets/app_styles.dart';

class LoadedAllDataWidget extends StatelessWidget {
  final String message;
  const LoadedAllDataWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppStyles.textNormalBlack,
        ),
      ),
    );
  }
}
