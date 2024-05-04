import 'package:bank_app_v3/features/authentication/cubits/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../modules/dashboard/page/dashboard_page.dart';
import '../modules/news/pages/news_page.dart';
import '../modules/payment/pages/payment_page.dart';
import '../modules/qr_code/pages/qr_code_scan_page.dart';
import '../modules/sign_in/pages/sign_in_page.dart';
import '../modules/transfer/pages/transfer_page.dart';
import '../modules/user_info/pages/user_info_page.dart';

class RouteName {
  static const String splashScreen = '/SplashScreen';
  static const String signInPage = '/SignInPage';
  static const String dashboardPage = '/';
  // static const String homePage = '/HomePage';
  // static const String transactionsPage = '/TransactionsPage';
  static const String qRCodeScanPage = '/QRCodeScanPage';
  // static const String notificationsPage = '/NotificationsPage';
  // static const String accountPage = '/AccountPage';
  static const String newsPage = '/NewsPage';
  static const String transferPage = '/TransferPage';
  static const String paymentPage = '/PaymentPage';
  static const String userInfoPage = '/UserInfoPage';

  static const publicRoutes = [
    // Những trang không cần đăng nhập.
    // splashScreen,
    signInPage,
    // dashboardPage,
  ];
}

final GoRouter router = GoRouter(
  redirect: (context, state) {
    // Nếu người dùng vào những trang mà không cần đăng nhập thì return null.
    if (RouteName.publicRoutes.contains(state.fullPath)) {
      return null;
    }
    if(context.read<AuthCubit>().state is AuthenticatedState) {
      return null;
    }
    // Nếu người dùng vào những trang phải đăng nhập mà chưa đăng nhập thì chuyển đến '/SignInPage'.
    return RouteName.signInPage;
  },
  routes: [
    GoRoute(
      path: RouteName.signInPage,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: RouteName.dashboardPage,
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: RouteName.qRCodeScanPage,
      builder: (context, state) => const QRCodeScanPage(),
    ),
    GoRoute(
      path: RouteName.newsPage,
      builder: (context, state) => const NewsPage(),
    ),
    GoRoute(
      path: RouteName.transferPage,
      builder: (context, state) => const TransferPage(),
    ),
    GoRoute(
      path: RouteName.paymentPage,
      builder: (context, state) => const PaymentPage(),
    ),
    GoRoute(
      path: RouteName.userInfoPage,
      builder: (context, state) => const UserInfoPage(),
    ),
  ],
);
