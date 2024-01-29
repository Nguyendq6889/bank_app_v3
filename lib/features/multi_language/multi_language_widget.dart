import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_assets/app_icons.dart';
import '../../app_assets/app_styles.dart';

class MultiLanguageWidget extends StatefulWidget {
  final String page;
  const MultiLanguageWidget({super.key, required this.page});

  @override
  State<MultiLanguageWidget> createState() => _MultiLanguageWidgetState();
}

class _MultiLanguageWidgetState extends State<MultiLanguageWidget> {
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
    return InkWell(
      onTap: () {
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        _showModalBottomSheet();
        // });
      },
      child: widget.page == 'SignIn' ? _signInWidget() : _accountWidget()
    );
  }

  Widget _signInWidget() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(_language == 'vi_VN' ? AppIcons.iconVietNam : AppIcons.iconEnglish),
          const SizedBox(width: 6),
          Text(
            _language == 'vi_VN' ? 'VI' : 'EN',
            style: AppStyles.textButtonWhite.copyWith(fontWeight: FontWeight.bold)
          )
        ],
      ),
    );
  }

  Widget _accountWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 20),
                child: SvgPicture.asset(AppIcons.iconLanguages),
              ),
              const SizedBox(width: 16),
              Text('language'.tr(), style: AppStyles.textButtonGray)
            ],
          ),
          Row(
            children: [
              Text(
                _language == 'vi_VN' ? 'Tiếng Việt' : 'English',
                style: AppStyles.textButtonBlue.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 12),
              SvgPicture.asset(AppIcons.iconArrowRight),
            ],
          ),
        ],
      ),
    );
  }

  Widget _languageOptionWidget(String icon, String label, bool selected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: selected ? const Color(0xfff1f1f1) : null,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(icon),
                const SizedBox(width: 16),
                Text(label, style: AppStyles.textNormalBlack)
              ],
            ),
            selected ? SvgPicture.asset(AppIcons.iconSelected) : const SizedBox(),
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
                child: Text('language_use_question'.tr(), style: AppStyles.textButtonGray),
              ),
              const SizedBox(height: 12),
              _languageOptionWidget(
                AppIcons.iconVietNam,
                'Tiếng Việt',
                _language == 'vi_VN' ? true : false,
                    () {
                  context.setLocale(const Locale('vi', 'VN'));
                  _saveLanguage('vi_VN');
                  Navigator.pop(context);
                },
              ),
              _languageOptionWidget(
                AppIcons.iconEnglish,
                'English',
                _language == 'en_US' ? true : false,
                    () {
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
