import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../app_assets/app_styles.dart';

class FeatureWidget extends StatelessWidget {
  final String title;
  final String icon;
  final double? iconWidth;
  final VoidCallback? onTap;
  const FeatureWidget({Key? key, required this.title, required this.icon, this.iconWidth, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8, // soften the shadow
              spreadRadius: 0, //extend the shadow
            )
          ],
        ),
        child: Column(
          children: [
            SvgPicture.asset(icon, width: iconWidth),
            const SizedBox(height: 6),
            Expanded(
              child: Center(
                child: Text(
                  title.tr(),
                  textAlign: TextAlign.center,
                  style: AppStyles.textFeatures.copyWith(height: 1.2)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}