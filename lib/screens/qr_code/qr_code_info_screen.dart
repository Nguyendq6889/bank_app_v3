import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../app_assets/app_colors.dart';
import '../../app_assets/app_icons.dart';
import '../../app_assets/app_images.dart';
import '../../app_assets/app_styles.dart';
import '../../widgets/main_button_widget.dart';

class QRCodeInfoScreen extends StatelessWidget {
  final Barcode result;
  const QRCodeInfoScreen({Key? key, required this.result}) : super(key: key);
  // const QRCodeInfoScreen({Key? key}) : super(key: key);

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
                      height: 60,
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
                          Text('qr_code_detail'.tr(), style: AppStyles.titleAppBarWhite.copyWith(height: 1)),
                          const SizedBox(width: 42)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Body
          Positioned(
            left: 16,
            top: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxHeight: size.height * 74.5 / 100,
                    maxWidth: size.width - 32,
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20, // soften the shadow
                        spreadRadius: 0, //extend the shadow
                      )
                    ],
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Image.asset(AppImages.imageQRCode),
                        const SizedBox(height: 24),
                        const Divider(thickness: 1, height: 1, color: Color(0xfff1f1f1)),
                        const SizedBox(height: 20),
                        Text(
                          'qr_code_info'.tr(),
                          style: AppStyles.titleAppBarBlack.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 14),
                        _buildRow('${'account_name'.tr()} :', 'Manwah Hotpot'),
                        _buildRow('${'account_number'.tr()} :', '1014686229'),
                        _buildRow('${'transfer_amount'.tr()} :', '100,000 ${'currency'.tr()}'),
                        _buildRow('${'description'.tr()} :', ''),
                        _buildRow('${'barcode_type'.tr()} :', describeEnum(result.format)),
                        // _buildRow('${'barcode_type'.tr()} :', 'describeEnum(result.format)'),
                        _buildRow('${'data'.tr()} :', result.code!),
                        // _buildRow('${'data'.tr()} :', 'result.code!'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                MainButtonWidget(     // MainButtonWidget in lib/widgets/main_button_widget.dart file.
                  width: size.width - 32,
                  text: 'transfer'.tr(),
                  onTap: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRow(String label, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
              style: AppStyles.textButtonBlack,
            ),
          )
        ],
      ),
    );
  }
}
