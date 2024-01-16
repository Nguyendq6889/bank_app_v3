import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../app_assets/app_colors.dart';
import '../app_assets/app_icons.dart';
import '../app_assets/app_styles.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // AppBar
          Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 18.472 / 100,
                decoration: const BoxDecoration(
                  gradient: AppColors.colorAppBar,
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: (size.height * 12.807 / 100) - MediaQuery.of(context).padding.top,
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
                            Text('transaction_detail'.tr(), style: AppStyles.titleAppBarWhite.copyWith(height: 1)),
                            const SizedBox(width: 42)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Body
          Positioned(
            left: 16,
            top: size.height * 12.807 / 100,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: size.height * 84 / 100,
                maxWidth: size.width - 32,
              ),
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    offset: const Offset(0, 4),
                    blurRadius: 20, // soften the shadow
                    spreadRadius: 0, //extend the shadow
                  )
                ],
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'transaction'.tr(),
                        style: AppStyles.titleAppBarBlack.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('from'.tr(), textAlign: TextAlign.start, style: AppStyles.textButtonBlack),
                    const SizedBox(height: 8),
                    _buildRow('${'account_number'.tr()} :', '1014686229'),
                    const SizedBox(height: 12),
                    const Divider(thickness: 1, height: 1, color: Color(0xfff1f1f1)),
                    const SizedBox(height: 16),
                    Text('to'.tr(), textAlign: TextAlign.start, style: AppStyles.textButtonBlack),
                    const SizedBox(height: 8),
                    _buildRow('${'account_name'.tr()} :', 'Manwah Hotpot'),
                    _buildRow('${'account_number'.tr()} :', '1014686347'),
                    _buildRow('${'bank'.tr()} :', 'World bank'),
                    const SizedBox(height: 12),
                    const Divider(thickness: 1, height: 1, color: Color(0xfff1f1f1)),
                    const SizedBox(height: 16),
                    Text('transaction_information'.tr(), textAlign: TextAlign.start, style: AppStyles.textButtonBlack),
                    const SizedBox(height: 8),
                    _buildRow('${'transaction_code'.tr()} :', '1560400452392'),
                    _buildRow('${'date'.tr()} :', '11/06/2023'),
                    _buildRow('${'transfer_amount'.tr()} :', '-100,000 ${'currency'.tr()}', contentColor: const Color(0xffEB383D)),
                    _buildRow('${'fee'.tr()} :', '0 ${'currency'.tr()}'),
                    _buildRow('${'total'.tr()} :', '-100,000 ${'currency'.tr()}', contentColor: const Color(0xffEB383D)),
                    _buildRow('${'description'.tr()} :', 'Happy birthday'),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRow(String label, String content, {Color? contentColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            label,
            style: AppStyles.textNormalBlack.copyWith(color: const Color(0xff888888)),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.end,
              style: AppStyles.textButtonBlack.copyWith(color: contentColor ?? const Color(0xff323232)),
            ),
          )
        ],
      ),
    );
  }
}