import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../app_assets/app_colors.dart';
import '../../app_assets/app_icons.dart';
import '../../app_assets/app_styles.dart';
import '../../widgets/feature_widget.dart';
import 'interbank_transfer_screen.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: AppBar(
          backgroundColor: const Color(0xff4E86F3),
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: size.width,
                height: 105,
                decoration: const BoxDecoration(
                  gradient: AppColors.colorAppBar,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 52,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: SvgPicture.asset(AppIcons.iconBack),
                            ),
                          ),
                          Text('transfer'.tr(), style: AppStyles.titleAppBarWhite.copyWith(height: 1)),
                          const SizedBox(width: 42)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 70),
              Text(
                'select_transfer_type'.tr(),
                style: AppStyles.textButtonBlack
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.zero,
                  childAspectRatio: 108/106,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  crossAxisCount: 3,
                  children: <Widget>[
                    // FeatureWidget in lib/widgets/feature_widget.dart file.
                    FeatureWidget(
                      title: 'intra_bank',
                      icon: AppIcons.iconIntraBank,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const InterbankTransferScreen()))
                    ),
                    FeatureWidget(
                      title: 'interbank',
                      icon: AppIcons.iconInterbank,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const InterbankTransferScreen()))
                    ),
                    const FeatureWidget(title: 'international', icon: AppIcons.iconInternational),
                    const FeatureWidget(title: 'savedList', icon: AppIcons.iconSavedList),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 16,
            top: 52,
            child: Container(
              width: size.width - 32,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    offset: const Offset(0, 4),
                    blurRadius: 8, // soften the shadow
                    spreadRadius: 0, //extend the shadow
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'transfer_from'.tr(),
                        style: AppStyles.textButtonBlack,
                      ),
                      Text(
                        'change'.tr(),
                        style: AppStyles.textButtonBlue,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${'account'.tr()}:',
                          style: AppStyles.textFeatures.copyWith(color: const Color(0xff888888), fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${'balance'.tr()}:',
                          style: AppStyles.textFeatures.copyWith(color: const Color(0xff888888), fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: <Widget>[
                      const Expanded(
                        child: Text(
                          '1014686229',
                          style: AppStyles.textButtonBlack,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '15.200.000 ${'currency'.tr()}',
                          style: AppStyles.textButtonBlack,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}