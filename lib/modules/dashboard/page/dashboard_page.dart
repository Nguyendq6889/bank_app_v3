import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../app_assets/app_icons.dart';
import '../../qr_code/pages/qr_code_scan_page.dart';
import '../../account/pages/account_page.dart';
import '../../home/pages/home_page.dart';
import '../../notifications/pages/notifications_page.dart';
import '../../transactions/pages/transactions_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  static const TextStyle selectedLabelStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w700, height: 1.6);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    TransactionsPage(),
    Text(
      'Index 2: QR Code Scan Screen',
    ),
    NotificationsPage(),
    AccountPage()
  ];

  void _onItemTapped(int index) {
    if(index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const QRCodeScanPage()));
      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const QRCodeInfoPage()));
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Localizations.override(
        context: context,
        locale: context.locale,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedLabelStyle: selectedLabelStyle,
          unselectedLabelStyle: selectedLabelStyle,
          selectedItemColor: const Color(0XFF5289F4),
          unselectedItemColor: const Color(0xffC4C4C4),
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(AppIcons.iconHomeBlue),
              icon: SvgPicture.asset(AppIcons.iconHomeGray),
              label: 'home'.tr(),
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(AppIcons.iconTransactionsBlue),
              icon: SvgPicture.asset(AppIcons.iconTransactionsGray),
              label: 'transactions'.tr(),
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(AppIcons.iconQRPay, width: 22),
              icon: SvgPicture.asset(AppIcons.iconQrGray),
              label: 'QR',
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(AppIcons.iconNotificationsHomeBlue),
              icon: SvgPicture.asset(AppIcons.iconNotificationsHomeGray),
              label: 'notifications'.tr(),
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(AppIcons.iconAccountBlue),
              icon: SvgPicture.asset(AppIcons.iconAccountGray),
              label: 'account'.tr(),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
