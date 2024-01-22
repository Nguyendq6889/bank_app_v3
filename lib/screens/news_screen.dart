import 'package:bank_app_v3/app_assets/app_colors.dart';
import 'package:bank_app_v3/modules/news/cubits/news_state.dart';
import 'package:bank_app_v3/modules/news/models/news_model.dart';
import 'package:bank_app_v3/widgets/load_more_list_view_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../app_assets/app_icons.dart';
import '../app_assets/app_images.dart';
import '../app_assets/app_styles.dart';
import '../modules/news/cubits/news_cubit.dart';
import '../widgets/error_message_widget.dart';
import '../widgets/loaded_all_data_widget.dart';
import '../widgets/loading_list_view_widget.dart';
import '../widgets/no_data_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late final NewsCubit _newsCubit;
  int _page = 1;
  final ScrollController _scrollController = ScrollController();
  // final PageController _bannerPageController = PageController(initialPage: 0);
  // int _selectedBannerPage = 0;

  @override
  void initState() {
    _scrollController.addListener(_loadMore);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _newsCubit = BlocProvider.of<NewsCubit>(context);
      _newsCubit.getListNews(_page);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'news'.tr(),
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
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if(state is InitNewsState || state is LoadingNewsState) {
            // context.loaderOverlay.show();
            return const LoadingListViewWidget();
          } else if(state is ErrorNewsState) {
            // context.loaderOverlay.hide();
            if(kDebugMode) print(state.message);
            return const ErrorMessageWidget();    // ErrorMessageWidget in lib/widgets/error_message_widget.dart file.
          } else if(state is SuccessfulNewsState) {
            // context.loaderOverlay.hide();
            return RefreshIndicator(
              onRefresh: _onRefresh,
              color: AppColors.primaryColor,
              child: state.listNews.isEmpty ? const NoDataWidget(message: 'Không có tin tức nào.') : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.listNews.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if(index < state.listNews.length) {
                            return _recentNewsWidget(AppImages.imageRecentNews1, state.listNews[index]);
                          } else {
                            if(_newsCubit.hasErrorWhenLoadMore){
                              return const ErrorMessageWidget();
                            }
                            return _newsCubit.finishLoadMore
                                ? const LoadedAllDataWidget(message: 'Không còn tin tức nào nữa.')
                                : const LoadMoreListViewWidget();
                          }
                        }
                      ),
                    ),
                  ]
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Future<void> _onRefresh() async {
    await _newsCubit.getListNews(1);
  }

  Future<void> _loadMore() async {
    if (kDebugMode) {
      print('extentBefore ====================== ${_scrollController.position.extentBefore}');
      print('extentAfter ====================== ${_scrollController.position.extentAfter}');
      // print('maxScrollExtent ====================== ${_scrollController.position.maxScrollExtent}');
      // print('offset ====================== ${_scrollController.offset}');
    }
    // if(_scrollController.position.maxScrollExtent == _scrollController.offset) {
    // if(_scrollController.position.extentAfter < 500 && _scrollController.position.extentBefore > 100) {
    // if(_scrollController.position.extentAfter < 700) {
    if(_scrollController.position.extentAfter < 200) {
      if(_newsCubit.isLoading) return;
      _page++;
      await _newsCubit.onLoadMore();
    }
  }

  // Widget _banner(String image, Size size) {
  //   return Column(
  //     children: [
  //       Container(
  //         height: size.height * 26.108 / 100,
  //         width: double.infinity,
  //         margin: const EdgeInsets.symmetric(horizontal: 16),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(16),
  //           image: DecorationImage(
  //             image: AssetImage(image), fit: BoxFit.cover,
  //           )
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
  //         child: Text(
  //           'news_title'.tr(),
  //           style: AppStyles.textButtonBlack
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
  //         child: Row(
  //           children: [
  //             SvgPicture.asset(AppIcons.iconClock),
  //             const SizedBox(width: 8),
  //             Text(
  //               "09:00 - 03/11/2023",
  //               style: AppStyles.textFeatures.copyWith(color: const Color(0xffA1A1A1)),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _recentNewsWidget(String image, NewsModel data) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 74,
            width: 112,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                image: AssetImage(image), fit: BoxFit.cover,
              )
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textFeatures,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "09:00 - 03/11/2023",
                      style: AppStyles.textFeatures.copyWith(color: const Color(0xffA1A1A1)),
                    ),
                    Text(
                      "User ID: ${data.userId ?? ''}",
                      style: AppStyles.textFeatures.copyWith(color: const Color(0xffA1A1A1)),
                    ),
                  ],
                ),
                Text(
                  "ID: ${data.id ?? ''}",
                  style: AppStyles.textFeatures.copyWith(color: const Color(0xffA1A1A1)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // _bannerPageController.dispose();
    super.dispose();
  }
}
