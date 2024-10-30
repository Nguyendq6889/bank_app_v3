import 'package:bank_app_v3/modules/user_info/repository/user_info_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../app_assets/app_colors.dart';
import '../../../app_assets/app_icons.dart';
import '../../../app_assets/app_images.dart';
import '../../../app_assets/app_styles.dart';
import '../../../config/router.dart';
import '../../../features/authentication/cubits/auth_cubit.dart';
import '../../../features/multi_language/multi_language_widget.dart';
import '../../user_info/cubits/user_info_cubit.dart';
import '../../user_info/pages/user_info_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if(state is UnAuthenticatedState) {
          context.loaderOverlay.hide();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go(RouteName.signInPage);
          });
        }
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
          body: Localizations.override(
            context: context,
            locale: context.locale,
            child: Stack(
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
                            MaterialPageRoute(builder: (BuildContext context) =>
                                BlocProvider(
                                    create: (context) =>
                                        UserInfoCubit(UserInfoRepo()),
                                    child: const UserInfoPage()
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
                                  border: Border.all(
                                      color: Colors.white, width: 1),
                                  image: const DecorationImage(
                                    image: AssetImage(AppImages.avatar),
                                    fit: BoxFit.contain,
                                  )
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Đỗ Quang Nguyên',
                                    style: AppStyles.titleAppBarWhite),
                                const SizedBox(height: 4),
                                Text(
                                    "touch_to_view".tr(),
                                    style: AppStyles.textButtonWhite.copyWith(
                                        fontWeight: FontWeight.w400, height: 1.5)
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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
                            _buildFeature(
                                AppIcons.iconNotifications, 'notification'.tr()),
                            const Divider(height: 1,
                                color: Color(0xffF1F1F1),
                                thickness: 1),
                            _buildFeature(AppIcons.iconSecurity, 'security'.tr(),
                                showMark: true),
                            const Divider(height: 1,
                                color: Color(0xffF1F1F1),
                                thickness: 1),
                            _buildFeature(AppIcons.iconHelp, 'help'.tr()),
                            const Divider(height: 1,
                                color: Color(0xffF1F1F1),
                                thickness: 1),
                            _buildFeature(AppIcons.iconContact, 'contact'.tr()),
                            const Divider(height: 1,
                                color: Color(0xffF1F1F1),
                                thickness: 1),
                            // _buildFeature(
                            //   AppIcons.iconLanguages,
                            //   'language'.tr(),
                            //   showLanguage: (_language != null) ? true : false,
                            //   onTap: () {
                            //     // WidgetsBinding.instance.addPostFrameCallback((_) {
                            //     _showModalBottomSheet();
                            //     // });
                            //   }
                            // ),
                            const MultiLanguageWidget(page: 'Account'),
                            const Divider(height: 1,
                                color: Color(0xffF1F1F1),
                                thickness: 1),
                            _buildFeature(
                                AppIcons.iconLogOut,
                                'sign_out'.tr(),
                                hideArrowRight: true,
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Basic dialog title'),
                                        content: const Text(
                                          'Bạn có chắc chắn muốn đăng xuất không?',
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              textStyle: Theme.of(context).textTheme.labelLarge,
                                            ),
                                            child: const Text('Ok'),
                                            onPressed: () {
                                              context.loaderOverlay.show();     // Show loading effect
                                              Navigator.of(context).pop();
                                              context.read<AuthCubit>().signOut();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('${'version'.tr()} v2.0',
                          style: AppStyles.textFeatures.copyWith(
                              color: const Color(0xffA1A1A1))),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buildFeature(String icon, String label, {bool? hideArrowRight, bool? showMark, VoidCallback? onTap}) {
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
}
