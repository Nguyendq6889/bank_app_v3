import 'package:bank_app_v2/app_assets/app_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../app_assets/app_icons.dart';
import '../app_assets/app_images.dart';
import '../cubits/user_info/user_info_cubit.dart';
import '../cubits/user_info/user_info_state.dart';
import '../models/user_info/user_info_model.dart';
import '../widgets/error_message_widget.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  // late UserInfoCubit userInfoCubit;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<UserInfoCubit>();
      cubit.getUserInfo();
      // userInfoCubit = BlocProvider.of<UserInfoCubit>(context);
      // userInfoCubit.getUserInfo();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'personal_info'.tr(),
          style: AppStyles.titleAppBarBlack.copyWith(height: 1.2),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          padding: const EdgeInsets.only(right: 16),
          icon: SvgPicture.asset(AppIcons.iconBack, colorFilter: const ColorFilter.mode(Color(0xff4380F4), BlendMode.srcIn)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            color: const Color(0xfff1f1f1),
            height: 1.0,
          ),
        ),
      ),
      body: BlocBuilder<UserInfoCubit, UserInfoState>(
        builder: (context, state) {
          if(state is InitUserInfoState || state is LoadingUserInfoState) {
            context.loaderOverlay.show();
            // return const LoadingWidget();
          } else if(state is ErrorUserInfoState) {
            context.loaderOverlay.hide();
            return const ErrorMessageWidget();    // ErrorMessageWidget in lib/widgets/error_message_widget.dart file.
          } else if(state is SuccessfulUserInfoState) {
            context.loaderOverlay.hide();
            return buildView(state.userInfo);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget buildView(UserInfoModel data) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1),
              color: Colors.yellow,
              image: const DecorationImage(
                image: AssetImage(AppImages.avatar), fit: BoxFit.contain,
              )
            ),
          ),
          Text(
            'change_avatar'.tr(),
            style: AppStyles.textButtonBlue
          ),
          const SizedBox(height: 24),
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 62 / 100,
              maxWidth: MediaQuery.of(context).size.width - 32,
            ),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
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
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                _buildRow('${'full_name'.tr()} :', data.name ?? ''),
                _buildRow('${'gender'.tr()} :', 'Male'),
                _buildRow('${'date_of_birth'.tr()} :', '01/01/1990'),
                _buildRow('Email :', data.email ?? ''),
                _buildRow('${'username'.tr()} :', data.username ?? ''),
                _buildRow('${'phone_number'.tr()} :', data.phone ?? ''),
                _buildRow('${'id'.tr()} :', data.id != null ? data.id.toString() : ''),
                _buildRow(
                  '${'address'.tr()} :',
                  '${data.address?.suite ?? ''}, ${data.address?.street ?? ''}, ${data.address?.city ?? ''}',
                  end: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String content, {bool? end}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Text(
                label,
                style: AppStyles.textButtonGray,
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
        ),
        (end == true) ? const SizedBox() : const Divider(thickness: 1, height: 1, color: Color(0xfff1f1f1)),
      ],
    );
  }
}
