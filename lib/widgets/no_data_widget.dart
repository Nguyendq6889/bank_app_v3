import 'package:flutter/material.dart';
import '../app_assets/app_styles.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  const NoDataWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: AppStyles.textNormalBlack,
      ),
    );
  }
}
