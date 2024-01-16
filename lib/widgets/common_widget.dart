import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../app_assets/app_icons.dart';
import '../app_assets/app_styles.dart';

class CommonWidget {
  static modalBottomSheetSelectValue({
    required BuildContext context,
    required List<String> listData,
    required String valueType,
    required String? currentValue,
    int? height,
    required Function(String) onValueSelected, // Callback function to handle value selection event
  }) {
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
          height: (height ?? 50) * MediaQuery.of(context).size.height / 100,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(valueType.tr(), style: AppStyles.titleAppBarBlack.copyWith(fontSize: 16)),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SvgPicture.asset(AppIcons.iconClose),
                    ),
                  )
                ],
              ),
              const Divider(color: Color(0xfff1f1f1), height: 1.0, thickness: 1, indent: 16, endIndent: 16),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: listData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        onValueSelected(listData[index]); // Call the callback function and pass in the selected value
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                        color: (listData[index] == currentValue) ? const Color(0xfff1f1f1) : null,
                        child: Row(
                          children: [
                            SizedBox(width: (listData[index] == currentValue) ? 15 : 0),
                            Expanded(
                              child: Text(
                                listData[index],
                                // overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: AppStyles.textButtonBlack.copyWith(color: const Color(0xff666666), height: 1)
                              ),
                            ),
                            (listData[index] == currentValue) ? SvgPicture.asset(AppIcons.iconSelected) : const SizedBox(),
                          ],
                        ),
                      )
                    );
                  }
                )
              )
            ],
          ),
        );
      },
    );
  }
}