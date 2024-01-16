import 'package:flutter/material.dart';
import '../app_assets/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.primaryColor,
        ),
      )
    );
  }
}
