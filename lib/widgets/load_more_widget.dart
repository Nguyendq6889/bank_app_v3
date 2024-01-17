import 'package:flutter/material.dart';
import '../app_assets/app_colors.dart';

class LoadMoreWidget extends StatelessWidget {
  const LoadMoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
