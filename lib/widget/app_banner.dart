import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wan_android/config/resource_manager.dart';
import 'package:flutter_wan_android/view_model/home_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: Consumer<HomeModel>(
        builder: (context, homeModel, child) {
          if (homeModel.isBusy) {
            return CupertinoActivityIndicator();
          } else {
            var banner = homeModel?.banners ?? [];
            return Swiper(
              itemCount: banner.length,
              loop: true,
              autoplay: true,
              autoplayDelay: 5000,
              pagination: SwiperPagination(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showToast('$index');
                  },
                  child: CachedNetworkImage(
                    placeholder: (context, _) {
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    },
                    fit: BoxFit.fill,
                    imageUrl: ImageHelper.warpUrl(banner[index].imagePath),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
