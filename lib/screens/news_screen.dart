import 'package:easy_localization/easy_localization.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../app_assets/app_icons.dart';
import '../app_assets/app_images.dart';
import '../app_assets/app_styles.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final PageController _bannerPageController = PageController(initialPage: 0);

  int _selectedBannerPage = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 16),
/// News slider start
              ExpandablePageView(
                controller: _bannerPageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index){
                  setState(() {
                    _selectedBannerPage = index;
                  });
                },
                children: [
                  _banner(AppImages.imageNews1, size),
                  _banner(AppImages.imageNews2, size),
                  _banner(AppImages.imageNews3, size),
                  _banner(AppImages.imageNews4, size),
                ]
              ),
/// News slider end
              const SizedBox(height: 16),
/// Dots indicator start
              SizedBox(
                height: 10,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        _bannerPageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                      },
                      child: AnimatedContainer(
                        width: _selectedBannerPage == index ? 28 : 10,
                        height: 10,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        duration: const Duration(milliseconds: 100),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _selectedBannerPage == index ? const Color(0xff5289F4) : const Color(0xffDDDDDD),
                        ),
                      ),
                    );
                  },
                ),
              ),
/// Dots indicator end
              const SizedBox(height: 16),
/// Recent news start
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: const Color(0xffF9F9F9),
                child: Text(
                  'recent_news'.tr(),
                  style: AppStyles.textButtonBlack
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    _recentNews(AppImages.imageRecentNews1, 'recent_news_title_1'.tr()),
                    _recentNews(AppImages.imageRecentNews3, 'recent_news_title_3'.tr()),
                    _recentNews(AppImages.imageRecentNews2, 'recent_news_title_2'.tr()),
                  ]
                ),
              )
/// Recent news end
            ],
          ),
        ),
      ),
    );
  }

  Widget _banner(String image, Size size) {
    return Column(
      children: [
        Container(
          height: size.height * 26.108 / 100,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(image), fit: BoxFit.cover,
            )
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
          child: Text(
            'news_title'.tr(),
            style: AppStyles.textButtonBlack
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Row(
            children: [
              SvgPicture.asset(AppIcons.iconClock),
              const SizedBox(width: 8),
              Text(
                "09:00 - 03/11/2023",
                style: AppStyles.textFeatures.copyWith(color: const Color(0xffA1A1A1)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _recentNews(String image, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 74,
          width: 112,
          margin: const EdgeInsets.only(bottom: 12),
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
                title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.textFeatures,
              ),
              const SizedBox(height: 6),
              Text(
                "09:00 - 03/11/2023",
                style: AppStyles.textFeatures.copyWith(color: const Color(0xffA1A1A1)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
