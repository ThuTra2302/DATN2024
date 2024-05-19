import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:travel/app/res/image/app_image.dart';
import 'package:travel/app/ui/widget/app_image_widget.dart';

import '../../controller/app_controller.dart';
import '../../controller/planed_trip_controller.dart';
import '../../res/string/app_strings.dart';
import '../theme/app_color.dart';
import '../widget/app_container.dart';
import '../widget/app_header.dart';
import '../widget/app_touchable.dart';
import 'favorite_screen.dart';
import 'history_screen.dart';

class PlanedTripScreen extends GetView<PlanedTripController> {
  const PlanedTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: AppContainer(
          backgroundColor: AppColor.grayFF9,
          child: Stack(
            children: [
              Positioned.fill(
                  child: AppImageWidget.asset(
                path: AppImage.bg,
                fit: BoxFit.fitWidth,
              )),
              Column(
                children: [
                  AppHeader(
                    middleWidget: Text(
                      StringConstants.yourPlanedTrip.tr,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.white,
                      ),
                    ),
                    leftWidget: AppTouchable(
                      width: 40.0.sp,
                      height: 40.0.sp,
                      padding: EdgeInsets.all(2.0.sp),
                      onPressed: Get.back,
                      borderRadius: BorderRadius.circular(22.0.sp),
                      child: Container(
                        width: 45.sp,
                        height: 45.sp,
                        padding: EdgeInsets.all(6.sp),
                        child: AppImageWidget.asset(
                          path: AppImage.ic_back,
                          height: 24.sp,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 72.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40.sp)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: TabBar(
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 20.sp),
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children:  <Widget>[
                              SvgPicture.asset(
                                AppImage.icNoteFavorite,
                                color: Color(0xFFFF2D55),
                              ),
                              SizedBox(width: 8),
                              Text('Favorites'),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Icon(
                                Icons.history,
                                color: Color(0xFF30B0C7),
                              ),
                              SizedBox(width: 8),
                              Text('History'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        FavoriteScreen(),
                        HistoryScreen(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
