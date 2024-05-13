import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travel/app/controller/app_controller.dart';
import 'package:travel/app/controller/main_controller.dart';
import 'package:travel/app/extension/int_temp.dart';
import 'package:travel/app/res/image/app_image.dart';
import 'package:travel/app/ui/theme/app_color.dart';
import 'package:travel/app/ui/widget/app_image_widget.dart';
import 'package:travel/app/util/gradient.dart';

import '../../route/app_route.dart';
import '../../util/disable_glow_behavior.dart';
import '../widget/app_container.dart';
import '../widget/app_dialog.dart';
import '../widget/app_touchable3.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({Key? key}) : super(key: key);

  Widget _buildWeatherInfoLoading() {
    return Column(
      key: const ValueKey(0),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 200.0.sp,
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: 30.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.sp),
                bottomLeft: Radius.circular(10.sp),
                bottomRight: Radius.circular(10.sp),
                topLeft: Radius.circular(10.sp),
              ),
              color: AppColor.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeInfo(BuildContext context) {
    return Column(
      key: const ValueKey(1),
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top + 12.0.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 16.0.sp),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('EEEE, dd MMMM yyyy', Get.find<AppController>().currentLocale.languageCode).format(DateTime.now()),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: const Color(0xFF202020),
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Get.find<AppController>().isPremium.value
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 40.sp,
                        ),
                ],
              ),
            ),
            Column(
              children: [
                AppTouchable3(
                  onPressed: () {
                    Get.toNamed(AppRoute.settingScreen);
                  },
                  child: Container(
                    width: 40.0.sp,
                    height: 40.0.sp,
                    padding: EdgeInsets.all(8.0.sp),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(color: AppColor.black.withOpacity(0.15), blurRadius: 4.sp, offset: const Offset(0, 4))]),
                    child: AppImageWidget.asset(
                      path: AppImage.ic_setting,
                      width: 24.0.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 16.0.sp),
          ],
        ),
        SizedBox(height: 12.0.sp),
      ],
    );
  }

  Widget _buildWeatherInfo(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32.sp),
            padding: EdgeInsets.symmetric(vertical: 20.sp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36.sp),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4A8AF4),
                    Color(0xFF93E3F4),
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5B9FF4).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 15),
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 16.sp,
                                ),
                                Expanded(
                                  child: Text(
                                    controller.dataWeather?.summary ?? "--",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 16.sp,
                                ),
                                Expanded(
                                    child: Obx(
                                  () => Text(
                                    controller.isDay.value ? 'Today' : 'Tonight',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 35.sp,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10.sp,
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Obx(() {
                                    UnitTypeTemp u = Get.find<AppController>().currentUnitTypeTemp.value;
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GradientText(
                                          controller.dataWeather?.temperature == null ? '--' : '${controller.valueInC.value.toUnit(u)}',
                                          style: TextStyle(
                                            fontSize: 96.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          gradientDirection: GradientDirection.ttb,
                                          colors: [
                                            AppColor.white,
                                            AppColor.white.withOpacity(0),
                                          ],
                                          stops: const [0.29, 1],
                                        ),
                                        Column(
                                          children: [
                                            GradientText(
                                              'o',
                                              style: TextStyle(
                                                fontSize: 40.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              gradientDirection: GradientDirection.ttb,
                                              colors: [
                                                AppColor.white,
                                                AppColor.white.withOpacity(0),
                                              ],
                                              stops: const [0.29, 1],
                                            ),
                                            SizedBox(
                                              height: 10.sp,
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Feel like: ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0.sp,
                                        ),
                                      ),
                                      Obx(
                                        () => FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            "${controller.feelLikeTemp} °${Get.find<AppController>().currentUnitTypeTemp.value.name.toUpperCase()}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.sp,
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      AppTouchable3(
                                        onPressed: () {
                                          controller.onPressUnitTemp(UnitTypeTemp.c);
                                          controller.feelLikeTemp.value = (controller.dataWeather?.apparentTemperature.round() as int)
                                              .toUnit(Get.find<AppController>().currentUnitTypeTemp.value);
                                        },
                                        child: Container(
                                          height: 32.sp,
                                          width: 32.sp,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.sp),
                                              color: controller.chooseC.value ? Colors.white.withOpacity(0.3) : null),
                                          child: Text(
                                            '°C',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.sp,
                                      ),
                                      AppTouchable3(
                                        onPressed: () {
                                          controller.onPressUnitTemp(UnitTypeTemp.f);
                                          controller.feelLikeTemp.value = (controller.dataWeather?.apparentTemperature.round() as int)
                                              .toUnit(Get.find<AppController>().currentUnitTypeTemp.value);
                                        },
                                        child: Container(
                                          height: 32.sp,
                                          width: 32.sp,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.sp),
                                              color: !controller.chooseC.value ? Colors.white.withOpacity(0.3) : null),
                                          child: Text(
                                            '°F',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20.sp,
                ),
              ],
            ),
          ),
          Positioned(
            top: -80.sp,
            left: 20.sp,
            child: AppImageWidget.asset(
              path: controller.getIcon(),
              width: Get.width / 2,
              height: Get.width / 2.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    String title,
    String pathImage,
    Color color,
    Function() onPress,
  ) {
    return AppTouchable3(
      onPressed: onPress,
      height: 178.sp,
      width: 178.sp,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(38.sp),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          AppImageWidget.asset(
            path: AppImage.bgButton,
            height: 178.sp,
            width: 178.sp,
          ),
          Positioned(
            bottom: 10.sp,
            right: 15.sp,
            child: AppImageWidget.asset(
              path: pathImage,
              width: 85.sp,
            ),
          ),
          Positioned(
            left: 20.sp,
            top: 24.sp,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 16.0.sp),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton('Weather for\nYour Trip', AppImage.icWeatherTrip, const Color(0xFFCEA9FF), () => controller.onPressWeatherForYourTrip()),
            SizedBox(width: 16.0.sp),
            _buildButton('Weather For\nPlace', AppImage.icWeatherPlace, const Color(0xFF57C792), () => controller.onPressWeatherForPlace()),
          ],
        ),
        SizedBox(
          height: 16.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
                'Explore Nearby\nPlaces', AppImage.icExploreNearby, const Color(0xFFF39A9A), () => controller.onPressWeatherForFamousPlace()),
            SizedBox(width: 16.0.sp),
            _buildButton(
              'Your Planed\nTrip',
              AppImage.icPlannedTrip,
              const Color(0xFFECC359),
              () => controller.onPressPlanedTrip(),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return AppContainer(
      showBanner: true,
      isCollapsibleBanner: false,
      backgroundColor: AppColor.white,
      onWillPop: () async {
        showAppDialog(context, '', '',
            hideGroupButton: true,
            widthDialog: Get.width / 1.15,
            widgetBody: Container(
              margin: EdgeInsets.only(
                top: 15.sp,
                right: 10.sp,
                bottom: 10.sp,
              ),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(12.sp),
              ),
              child: Column(
                children: [
                  Text(
                    'Are you sure you want to exit?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF12203A),
                    ),
                  ),
                  SizedBox(height: 30.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 46.sp,
                        width: Get.width / 3.5,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.sp),
                          color: const Color(0xFFE2E1E1),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'Close',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 48.sp,
                        width: Get.width / 3.5,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.sp),
                          color: const Color(0xFF3388F2),
                        ),
                        child: TextButton(
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          child: Text(
                            'Exit',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // NativeAdsWidget(factoryId: NativeFactoryId.appNativeAdFactoryMedium, isPremium: false)
                ],
              ),
            ));
        return false;
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 60.sp,
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: DisableGlowBehavior(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).padding.top + 20.sp,
                          ),
                          Obx(
                            () => AnimatedSwitcher(
                              duration: const Duration(milliseconds: 100),
                              child: controller.isLoadingWeather.value ? _buildWeatherInfoLoading() : _buildWeatherInfo(context),
                            ),
                          ),
                          SizedBox(
                            height: 30.sp,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 57.sp),
                            child: Row(
                              children: [
                                AppImageWidget.asset(
                                  path: AppImage.icTo,
                                  height: 24.sp,
                                ),
                                SizedBox(
                                  width: 8.sp,
                                ),
                                Expanded(
                                  child: Obx(
                                    () => Text(
                                      controller.dataLocation.value,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: const Color(0xFF202020),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          _buildGroupButton(),
                          SizedBox(
                            height: 90.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildTimeInfo(context),
        ],
      ),
    );
  }
}
