import 'package:flutter/material.dart';
import '../app_assets/app_styles.dart';

class MainButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? width;
  const MainButtonWidget({Key? key, required this.text, required this.onTap, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: 44.0,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        gradient: LinearGradient(
        colors: [Color(0xff4E86F3), Color(0xff1F69F6)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          tileMode: TileMode.clamp,
        ),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(text, style: AppStyles.textButtonWhite),
      ),
    );
  }
}
