import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../app_assets/app_colors.dart';
import '../../../app_assets/app_icons.dart';
import '../../../app_assets/app_styles.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'notifications'.tr(),
          style: AppStyles.titleAppBarWhite,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.colorAppBar,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const TransactionDetailScreen())),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color(0xffE9F2FF),
                          ),
                          child: Center(
                            child: SvgPicture.asset(AppIcons.iconNotifications),
                            // child: SvgPicture.asset(AppIcons.iconNotificationOutline),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (index % 2 == 0) ? 'account_received_payment'.tr() :  'transfer_successful'.tr(),
                                style: AppStyles.textButtonBlack.copyWith(height: 1)
                              ),
                              const SizedBox(height: 4),
                              (index % 2 == 0) ? Text.rich(
                                TextSpan(
                                  style: AppStyles.textNormalBlack.copyWith(color: const Color(0xff666666)),
                                  children: [
                                    TextSpan(text: '${'account'.tr()} '),
                                    const TextSpan(text: '1014686229', style: AppStyles.textButtonBlack),
                                    TextSpan(text: ' ${'received_amount'.tr()} '),
                                    TextSpan(
                                      text: '+100,000 ${'currency'.tr()}',
                                      style: AppStyles.textButtonBlack.copyWith(color: const Color(0xff49A66A)),
                                    ),
                                  ]
                                )
                              ) : Text.rich(
                                TextSpan(
                                  style: AppStyles.textNormalBlack.copyWith(color: const Color(0xff666666)),
                                  children: [
                                    TextSpan(text: '${'account'.tr()} '),
                                    const TextSpan(text: '1014686229', style: AppStyles.textButtonBlack),
                                    TextSpan(text: ' ${'successfully_transferred_amount'.tr()} '),
                                    TextSpan(
                                      text: '-100,000 ${'currency'.tr()}',
                                      style: AppStyles.textButtonBlack.copyWith(color: const Color(0xffD03339)),
                                    ),
                                  ]
                                )
                              ),
                              const SizedBox(height: 4),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "11/06/2023 12:45",
                                  style: AppStyles.textFeatures.copyWith(fontWeight: FontWeight.w400)
                                ),
                              ),
                              const SizedBox(height: 12),
                              if(index != 19) const Divider(color: Color(0xfff1f1f1), height: 1.0, thickness: 1),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
