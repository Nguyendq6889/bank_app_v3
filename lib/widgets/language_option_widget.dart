import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../app_assets/app_icons.dart';
import '../app_assets/app_styles.dart';

class LanguageOptionWidget extends StatelessWidget {
  final String icon;
  final String label;
  final bool? selected;
  final VoidCallback? onTap;
  const LanguageOptionWidget({Key? key, required this.icon, required this.label, this.selected, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        color: (selected ?? false) ? const Color(0xfff1f1f1) : null,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(icon),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: AppStyles.textNormalBlack
                )
              ],
            ),
            (selected ?? false) ? SvgPicture.asset(AppIcons.iconSelected) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
