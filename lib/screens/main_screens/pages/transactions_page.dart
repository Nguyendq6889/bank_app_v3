import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../app_assets/app_colors.dart';
import '../../../app_assets/app_icons.dart';
import '../../../app_assets/app_styles.dart';
import '../../../widgets/common_widget.dart';
import '../../transaction_detail_screen.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  String month = 'february'.tr();
  String year = '2023';
  String transactionType = 'all'.tr();

  List<String> listMonths = [
    'january'.tr(),
    'february'.tr(),
    'march'.tr(),
    'april'.tr(),
    'may'.tr(),
    'june'.tr(),
    'july'.tr(),
    'august'.tr(),
    'september'.tr(),
    'october'.tr(),
    'november'.tr(),
    'december'.tr()
  ];
  List<String> listYears = [
    '2020',
    '2021',
    '2022',
    '2023'
  ];
  List<String> listTransactionType = [
    'from'.tr(),
    'to'.tr(),
    'all'.tr()
  ];

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
                height: 91,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
                decoration: const BoxDecoration(
                  gradient: AppColors.colorAppBar,
                ),
                child: Center(
                  child: Text('transactions_history'.tr(), style: AppStyles.titleAppBarWhite.copyWith(height: 1)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 52, 16, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              // modalBottomSheetSelectValue function in lib/widgets/common_widget.dart file.
                              onTap: () => CommonWidget.modalBottomSheetSelectValue(
                                context: context,
                                listData: listMonths,
                                valueType: 'select_month'.tr(),
                                currentValue: month,
                                onValueSelected: (selectedValue) {
                                  // Reset the value of variable "month" to the selected value
                                  setState(() {
                                    month = selectedValue;
                                  });
                                },
                              ),
                              child: Container(
                                height: 44,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xfff7f6f6)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      month,
                                      style: AppStyles.textNormalBlack.copyWith(color: const Color(0xff2e2e2e))
                                    ),
                                    SvgPicture.asset(AppIcons.iconArrowDown)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: InkWell(
                              // modalBottomSheetSelectValue function in lib/widgets/common_widget.dart file.
                              onTap: () => CommonWidget.modalBottomSheetSelectValue(
                                context: context,
                                listData: listYears,
                                valueType: 'select_year'.tr(),
                                currentValue: year,
                                onValueSelected: (selectedValue) {
                                  // Reset the value of variable "year" to the selected value
                                  setState(() {
                                    year = selectedValue;
                                  });
                                },
                              ),
                              child: Container(
                                height: 44,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xfff7f6f6)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      year,
                                      style: AppStyles.textNormalBlack.copyWith(color: const Color(0xff2e2e2e))
                                    ),
                                    SvgPicture.asset(AppIcons.iconArrowDown)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: InkWell(
                              // modalBottomSheetSelectValue function in lib/widgets/common_widget.dart file.
                              onTap: () => CommonWidget.modalBottomSheetSelectValue(
                                context: context,
                                listData: listTransactionType,
                                valueType: 'select_type'.tr(),
                                currentValue: transactionType,
                                onValueSelected: (selectedValue) {
                                  // Reset the value of variable "transactionType" to the selected value
                                  setState(() {
                                    transactionType = selectedValue;
                                  });
                                },
                              ),
                              child: Container(
                                height: 44,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xfff7f6f6)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      transactionType,
                                      style: AppStyles.textNormalBlack.copyWith(color: const Color(0xff2e2e2e))
                                    ),
                                    SvgPicture.asset(AppIcons.iconArrowDown)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: 20,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: InkWell(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const TransactionDetailScreen())),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 44,
                                      height: 44,
                                      margin: const EdgeInsets.only(right: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: const Color(0xfff8f8f8),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(index % 2 == 0 ? AppIcons.iconArrowUpBlue : AppIcons.iconArrowDownRed),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "11/06/2023 12:45",
                                            style: AppStyles.textFeatures.copyWith(fontWeight: FontWeight.w400)
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            index % 2 == 0
                                                ? '${'from'.tr()}: 1014686229'
                                                : '${'to'.tr()}: 1014686229',
                                            style: AppStyles.textButtonBlack.copyWith(fontWeight: FontWeight.w600)
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(
                                      index % 2 == 0
                                          ? '+1,000,000 ${'currency'.tr()}'
                                          : '-500,000 ${'currency'.tr()}',
                                      style: AppStyles.textButtonBlack.copyWith(
                                        color: index % 2 == 0 ? AppColors.primaryColor : const Color(0xffEB383D),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 16,
            top: 52,
            child: Container(
              width: size.width - 32,
              height: 80,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8, // soften the shadow
                    spreadRadius: 0, //extend the shadow
                  )
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff5077F7),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'total_revenues'.tr(),
                                  style: AppStyles.textNormalBlack.copyWith(color: const Color(0xffA1A1A1))
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 22),
                              child: Text(
                                "16,100,000",
                                style: AppStyles.titleAppBarBlack.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: double.infinity,
                    color: const Color(0xffEEEEEE),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffD03339),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'total_expenditure'.tr(),
                                  style: AppStyles.textNormalBlack.copyWith(color: const Color(0xffA1A1A1))
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 22),
                              child: Text(
                                "2,100,000",
                                style: AppStyles.titleAppBarBlack.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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