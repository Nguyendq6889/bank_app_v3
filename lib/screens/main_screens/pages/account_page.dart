import 'package:bank_app_v3/cubits/user_info/user_info_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_assets/app_colors.dart';
import '../../../app_assets/app_icons.dart';
import '../../../app_assets/app_images.dart';
import '../../../app_assets/app_styles.dart';
import '../../../repositories/user_info_repo.dart';
import '../../../widgets/language_option_widget.dart';
import '../../user_info_screen.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String? _language;

  @override
  void initState() {
    _getLanguage();
    super.initState();
  }

  Future<void> _getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String savedLanguage = prefs.getString('language') ?? 'en_US';
    setState(() {
      _language = savedLanguage;
    });
  }

  Future<void> _saveLanguage(String newLanguage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', newLanguage);
    setState(() {
      _language = newLanguage;
    });
  }

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
                height: 123,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                decoration: const BoxDecoration(
                  gradient: AppColors.colorAppBar,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => BlocProvider(
                          create: (context) => UserInfoCubit(UserInfoRepo()),
                          child: const UserInfoScreen()
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1),
                          image: const DecorationImage(
                            image: AssetImage(AppImages.avatar), fit: BoxFit.contain,
                          )
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Đỗ Quang Nguyên', style: AppStyles.titleAppBarWhite),
                          const SizedBox(height: 4),
                          Text(
                            "touch_to_view".tr(),
                            style: AppStyles.textButtonWhite.copyWith(fontWeight: FontWeight.w400, height: 1.5)
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          ),
          Positioned(
            left: 16,
            top: 92,
            child: Column(
              children: [
                Container(
                  width: size.width - 32,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 8, // soften the shadow
                        spreadRadius: 0, //extend the shadow
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildFeature(AppIcons.iconNotifications, 'notification'.tr()),
                      const Divider(height: 1, color: Color(0xffF1F1F1), thickness: 1),
                      _buildFeature(AppIcons.iconSecurity, 'security'.tr(), showMark: true),
                      const Divider(height: 1, color: Color(0xffF1F1F1), thickness: 1),
                      _buildFeature(AppIcons.iconHelp, 'help'.tr()),
                      const Divider(height: 1, color: Color(0xffF1F1F1), thickness: 1),
                      _buildFeature(AppIcons.iconContact, 'contact'.tr()),
                      const Divider(height: 1, color: Color(0xffF1F1F1), thickness: 1),
                      _buildFeature(
                        AppIcons.iconLanguages,
                        'language'.tr(),
                        showLanguage: (_language != null) ? true : false,
                        onTap: () {
                          // WidgetsBinding.instance.addPostFrameCallback((_) {
                          _showModalBottomSheet();
                          // });
                        }
                      ),
                      const Divider(height: 1, color: Color(0xffF1F1F1), thickness: 1),
                      _buildFeature(AppIcons.iconLogOut, 'sign_out'.tr(), hideArrowRight: true),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text('${'version'.tr()} v2.0', style: AppStyles.textFeatures.copyWith(color: const Color(0xffA1A1A1))),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFeature(String icon, String label, {bool? hideArrowRight, bool? showLanguage, bool? showMark, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 20),
                  child: SvgPicture.asset(icon),
                ),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: AppStyles.textButtonGray
                )
              ],
            ),
            (hideArrowRight ?? false) ? const SizedBox() : Row(
              children: [
                (showLanguage ?? false) ? Text(
                  _language == 'vi_VN'
                      ? 'Tiếng Việt'
                      : 'English',
                  style: AppStyles.textButtonBlue.copyWith(fontWeight: FontWeight.w600),
                ) : const SizedBox(),
                (showMark ?? false)
                    ? SvgPicture.asset(AppIcons.iconMark)
                    : const SizedBox(),
                const SizedBox(width: 12),
                SvgPicture.asset(AppIcons.iconArrowRight),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16)
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 30 * MediaQuery.of(context).size.height / 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('select_language'.tr(), style: AppStyles.titleAppBarBlack.copyWith(fontSize: 16)),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                      child: SvgPicture.asset(AppIcons.iconClose),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'language_use_question'.tr(),
                  style: AppStyles.textButtonGray
                ),
              ),
              const SizedBox(height: 12),
              LanguageOptionWidget(     // LanguageOptionWidget in lib/widgets/language_option_widget.dart file.
                icon: AppIcons.iconVietNam,
                label: 'Tiếng Việt',
                selected: (_language == 'vi_VN') ? true : false,
                onTap: () {
                  context.setLocale(const Locale('vi', 'VN'));
                  _saveLanguage('vi_VN');
                  Navigator.pop(context);
                },
              ),
              LanguageOptionWidget(     // LanguageOptionWidget in lib/widgets/language_option_widget.dart file.
                icon: AppIcons.iconEnglish,
                label: 'English',
                selected: (_language == 'en_US') ? true : false,
                onTap: (){
                  context.setLocale(const Locale('en', 'US'));
                  _saveLanguage('en_US');
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
