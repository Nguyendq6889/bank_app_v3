import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_assets/app_colors.dart';
import '../../../app_assets/app_icons.dart';
import '../../../app_assets/app_images.dart';
import '../../../app_assets/app_styles.dart';
import '../../../features/biometrics_authentication/biometrics_authen_widget.dart';
import '../../../widgets/language_option_widget.dart';
import '../../../widgets/main_button_widget.dart';
import '../../../screens/main_screens/main_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String? _language;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _getLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Retrieve the screen size information of the device

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width, // Set the width of the Container equal to the width of the device
          height: size.height, // Set the height of the Container equal to the height of the device
          color: const Color(0xff1F69F6),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: AppColors.colorAppBar,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(width: double.infinity, height: MediaQuery.of(context).padding.top),
/// Language selection button start
                          InkWell(
                            onTap: () => _showModalBottomSheet(),
                            child: Padding(
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
                            ),
                          ),
/// Language selection button end
                        ],
                      ),
                    )
                  ),
                  Container(
                    width: size.width,
                    height: size.height * 60.837 / 100,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
/// Features section start
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _feature('QR Pay', AppIcons.iconQRPay),
                            _feature('ATM', AppIcons.iconATM),
                            _feature('book_tickets'.tr(), AppIcons.iconTicket),
                            _feature('support'.tr(), AppIcons.iconSupport),
                          ],
                        ),
/// Features section end
                      ],
                    )
                  ),
/// Sign up account section start
                  Container(
                    width: size.width,
                    height: size.height * 10.714 / 100,
                    padding: const EdgeInsets.all(16),
                    color: const Color(0xff5dc9a0),
                    child: GestureDetector(
                      onTap: () {
                        // print("Đăng ký tạo tài khoản");
                      },
                      child: Text(
                        'sign_up'.tr(),  // Use the tr() method to enable translation feature.
                        textAlign: TextAlign.center,
                        style: AppStyles.textButtonWhite.copyWith(
                          height: 1.5,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ),
                  )
/// Sign up account section end
                ],
              ),
/// Login form start
              Positioned(
                left: 16,
                bottom: size.height * 30.788 / 100,
                child: Container(
                  width: size.width - 32,
                  height: size.height * 56.403 / 100,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 8, // soften the shadow
                        spreadRadius: 0, //extend the shadow
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SvgPicture.asset(AppImages.imageLogoVisa),
                      ),
                      Expanded(
                        flex: 5,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 44,
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: const Color(0xfff7f6f6),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: TextFormField(
                                    controller: _userNameController,
                                    style: AppStyles.textNormalBlack,
                                    cursorColor: AppColors.primaryColor,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                      isCollapsed: true,
                                      border: InputBorder.none,
                                      hintText: '${'username'.tr()} / ${'phone_number'.tr()}',  // Use the tr() method to enable translation feature.
                                        hintStyle: const TextStyle(
                                        fontSize: 14, color: Color(0xffA1A1A1), fontWeight: FontWeight.w400
                                      ),
                                    ),
                                    onChanged: (value) {
                                      // print(_userNameController.text.trim());
                                    },
                                    onTapOutside: (PointerDownEvent event) {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 44,
                                margin: EdgeInsets.only(bottom: size.height * 2.5 / 100),
                                decoration: BoxDecoration(
                                  color: const Color(0xfff7f6f6),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: TextFormField(
                                    controller: _passwordController,
                                    style: AppStyles.textNormalBlack,
                                    cursorColor: AppColors.primaryColor,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                      isCollapsed: true,
                                      border: InputBorder.none,
                                      hintText: 'password'.tr(),  // Use the tr() method to enable translation feature.
                                        hintStyle: const TextStyle(
                                        fontSize: 14, color: Color(0xffA1A1A1), fontWeight: FontWeight.w400
                                      )
                                    ),
                                    onChanged: (value) {
                                      // print(_passwordController.text.trim());
                                    },
                                    onTapOutside: (PointerDownEvent event) {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                    },
                                  ),
                                ),
                              ),
                              BiometricsAuthenWidget(
                                onChanged: (bool authenticated) {
                                  if(authenticated) _goToMainScreen();
                                },
                              ),
                              SizedBox(height: size.height * 2.5 / 100),
                              // MainButtonWidget in lib/widgets/main_button_widget.dart file.
                              MainButtonWidget(text: 'sign_in'.tr(), onTap: () => _goToMainScreen()),
                              SizedBox(height: size.height * 2.5 / 100),
                              GestureDetector(
                                onTap: () {
                                  // print('Quên mật khẩu?');
                                },
                                child: Text(
                                  'forgot_password'.tr(),  // Use the tr() method to enable translation feature.
                                  style: AppStyles.textButtonBlue.copyWith(height: 1.5, decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
/// Login form end
            ],
          ),
        ),
      ),
    );
  }

  Widget _feature(String title, String icon) {
    return Column(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(height: 12),
        Text(
          title,
          style: AppStyles.textFeatures.copyWith(fontSize: 13)
        )
      ],
    );
  }

  // ModalBottomSheet select language
  Future<void> _showModalBottomSheet() {
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
                    child: Text(
                      'select_language'.tr(),  // Use the tr() method to enable translation feature.
                      style: AppStyles.titleAppBarBlack.copyWith(fontSize: 16),
                    ),
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
                  'language_use_question'.tr(),  // Use the tr() method to enable translation feature.
                  style: AppStyles.textButtonGray,
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

  // Function to retrieve the saved language preference from SharedPreferences and update the state.
  Future<void> _getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();    // Retrieve an instance of SharedPreferences.
    final String savedLanguage = prefs.getString('language') ?? 'en_US';    // Get the saved language preference from SharedPreferences, defaulting to 'en_US' if not found.
    setState(() {    // Update the state with the saved language preference.
      _language = savedLanguage;
    });
  }

  // Function to save the selected language to SharedPreferences and update the state.
  Future<void> _saveLanguage(String newLanguage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();    // Retrieve an instance of SharedPreferences.
    prefs.setString('language', newLanguage);    // Save the new language preference to SharedPreferences.
    setState(() {    // Update the state with the new language.
      _language = newLanguage;
    });
  }

  void _goToMainScreen() {
    context.loaderOverlay.show();     // Show loading effect
    Future.delayed(const Duration(seconds: 1), () {
      // After 1 seconds, hide loading effect and navigate to the MainScreen and replace the current SignInPage.
      context.loaderOverlay.hide();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const MainScreen()));
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();    // Dispose of the _userNameController to release resources
    _passwordController.dispose();    // Dispose of the _passwordController to release resources
    super.dispose();
  }
}