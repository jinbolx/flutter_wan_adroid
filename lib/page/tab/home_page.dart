import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android/generated/l10n.dart';
import 'package:flutter_wan_android/model/article.dart';
import 'package:flutter_wan_android/provider/provider_widget.dart';
import 'package:flutter_wan_android/provider/view_state_widget.dart';
import 'package:flutter_wan_android/ui/helper/refresh_helper.dart';
import 'package:flutter_wan_android/view_model/home_model.dart';
import 'package:flutter_wan_android/view_model/tap_to_top_model.dart';
import 'package:flutter_wan_android/utils/status_bar_utils.dart';
import 'package:flutter_wan_android/widget/animated_provider.dart';
import 'package:flutter_wan_android/widget/app_banner.dart';
import 'package:flutter_wan_android/widget/article_list_item.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const double kHomeRefreshHeight = 180.0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bannerHeight = MediaQuery.of(context).size.width * 7 / 11;

    return ProviderWidget2<HomeModel, TapToTopModel>(
      builder: (context, homeModel, tapToTopModel, child) {
        return Scaffold(
          body: MediaQuery.removePadding(
            context: context,
            removeTop: false,
            child: Builder(
              builder: (context) {
                if (homeModel.isError && homeModel.list.isEmpty) {
                  return AnnotatedRegion<SystemUiOverlayStyle>(
                    value: StatusBarUtils.systemUiOverlayStyle(context),
                    child: ViewStateErrorWidget(
                      error: homeModel.viewStateError,
                      onPressed: homeModel.initData(),
                    ),
                  );
                }
                return RefreshConfiguration.copyAncestor(
                    context: context,
                    twiceTriggerDistance: kHomeRefreshHeight - 15,
                    headerTriggerDistance:
                        80 + MediaQuery.of(context).padding.top / 3,
                    maxOverScrollExtent: kHomeRefreshHeight,
                    child: SmartRefresher(
                      controller: homeModel.refreshController,
                      enableTwoLevel: homeModel.list.isNotEmpty,
                      enablePullDown: true,
                      enablePullUp: homeModel.list.isNotEmpty,
                      header: HomeRefreshHeader(),
                      onTwoLevel: () async {},
                      onLoading: () => homeModel.loadMore(),
                      onRefresh: () async {
                        await homeModel.refresh();
                        homeModel.showErrorMessage(context);
                      },
                      footer: RefreshFooter(),
                      child: CustomScrollView(
                        controller: tapToTopModel.scrollController,
                        slivers: [
                          SliverToBoxAdapter(),
                          appbar(
                              context, homeModel, tapToTopModel, bannerHeight),
                          if (homeModel.isEmpty) emptyWidget(homeModel),
                          if (homeModel.topArticles?.isNotEmpty ?? false)
                            HomeTopArticleList(),
                          HomeArticleList(),
                        ],
                      ),
                    ));
              },
            ),
          ),
        );
      },
      model1: HomeModel(),
      model2: TapToTopModel(PrimaryScrollController.of(context),
          height: bannerHeight - kToolbarHeight),
      onModelReady: (homeModel, tapToTopModel) {
        homeModel.initData();
        tapToTopModel.init();
      },
    );
  }

  Widget appbar(context, homeModel, TapToTopModel tapToTopModel, bannerHeight) =>
      SliverAppBar(
        brightness:
            Theme.of(context).brightness == Brightness.light && homeModel.isBusy
                ? Brightness.light
                : Brightness.dark,
        flexibleSpace: FlexibleSpaceBar(
          background: BannerWidget(),
          titlePadding: EdgeInsets.all(0),
          centerTitle: false,
          title: GestureDetector(
            onDoubleTap: tapToTopModel.scrollToTop,
            onTap: (){
              showToast('click');
            },
            child: Container(
              height: double.infinity,
              alignment: Alignment.center,
              color: Colors.transparent,
              width: double.infinity,
              child: EmptyAnimatedSwitcher(
                display: tapToTopModel.showTopBtn,
                child:
                Text(Platform.isIOS ? 'Fun Flutter' : S.of(context).appName),
              ),
            ),
          ),
        ),
        expandedHeight: bannerHeight,
        pinned: true,
        floating: true,
        titleSpacing: 0,
        actions: [
          EmptyAnimatedSwitcher(
            display: tapToTopModel.showTopBtn,
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
              },
            ),
          ),
        ],
      );

  Widget emptyWidget(HomeModel homeModel) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 50),
        child: ViewStateEmptyWidget(
          onPressed: homeModel.initData(),
        ),
      ),
    );
  }
}

class HomeTopArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = Provider.of(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        Article article = homeModel.topArticles[index];
        return ArticleItemWidget(
          article: article,
          index: index,
          onTap: () {},
          top: true,
        );
      }, childCount: homeModel?.topArticles?.length ?? 0),
    );
  }
}

class HomeArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = Provider.of(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (context, index) => ArticleItemWidget(
                article: homeModel.list[index],
                index: index,
                top: false,
              ),
          childCount: homeModel.list.length ?? 0),
    );
  }
}
