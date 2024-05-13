import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/app_controller.dart';
import '../../controller/main_controller.dart';
import '../../controller/setting_controller.dart';
import '../../res/image/app_image.dart';
import '../../res/string/app_strings.dart';
import '../../util/disable_glow_behavior.dart';
import '../theme/app_color.dart';
import '../widget/app_container.dart';
import '../widget/app_header.dart';
import '../widget/app_image_widget.dart';
import '../widget/app_touchable.dart';
import '../widget/app_touchable3.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  Widget _buildItemSetting(
    Function()? onPressed,
    String imagePath,
    String text, {
    bool haveLine = true,
  }) {
    return Column(
      children: [
        AppTouchable3(
          onPressed: onPressed,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(12.sp),
            boxShadow: [BoxShadow(color: const Color(0xFF000514).withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          padding: EdgeInsets.symmetric(vertical: 18.sp, horizontal: 18.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 16.0.sp),
                child: AppImageWidget.asset(
                  path: imagePath,
                  width: 22.0.sp,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: const Color(0xFF12203A),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      backgroundColor: AppColor.grayFF9,
      showBanner: true,
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
                middleWidget: Text(
                  'Setting',
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0.sp,
                    horizontal: 16.0.sp,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40.sp)),
                    shape: BoxShape.rectangle,
                  ),
                  child: ScrollConfiguration(
                    behavior: DisableGlowBehavior(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 20.0.sp),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: Get.width,
                                padding: EdgeInsets.symmetric(
                                  vertical: 18.0.sp,
                                  horizontal: 18.0.sp,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24.0.sp),
                                  shape: BoxShape.rectangle,
                                  boxShadow: [BoxShadow(color: const Color(0xFF000514).withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
                                ),
                                child: Row(
                                  children: [
                                    AppImageWidget.asset(
                                      path: AppImage.icThermometer,
                                      width: 20.0.sp,
                                    ),
                                    SizedBox(width: 8.0.sp),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Temperature",
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                              fontSize: 14.0.sp,
                                              color: const Color(0xFF12203A),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(4.0.sp),
                                      ),
                                      child: Row(
                                        children: [
                                          Obx(
                                            () => GestureDetector(
                                              onTap: () => Get.find<MainController>().onPressUnitTemp(UnitTypeTemp.c),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(vertical: 4.0.sp, horizontal: 8.sp),
                                                decoration: BoxDecoration(
                                                  color: Get.find<AppController>().currentUnitTypeTemp.value == UnitTypeTemp.c
                                                      ? const Color(0xFF0A2958)
                                                      : null,
                                                  shape: BoxShape.rectangle,
                                                  borderRadius: BorderRadius.circular(8.0.sp),
                                                ),
                                                child: Text(
                                                  "°C",
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                    color: (Get.find<AppController>().currentUnitTypeTemp.value == UnitTypeTemp.c)
                                                        ? AppColor.white
                                                        : const Color(0xFF0A2958),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20.0.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.sp,
                                          ),
                                          Obx(
                                            () => GestureDetector(
                                              onTap: () => Get.find<MainController>().onPressUnitTemp(UnitTypeTemp.f),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(vertical: 4.0.sp, horizontal: 8.sp),
                                                decoration: BoxDecoration(
                                                  color: Get.find<AppController>().currentUnitTypeTemp.value == UnitTypeTemp.f
                                                      ? const Color(0xFF0A2958)
                                                      : null,
                                                  shape: BoxShape.rectangle,
                                                  borderRadius: BorderRadius.circular(8.0.sp),
                                                ),
                                                child: Text(
                                                  "°F",
                                                  textScaleFactor: 1,
                                                  style: TextStyle(
                                                    color: (Get.find<AppController>().currentUnitTypeTemp.value == UnitTypeTemp.f)
                                                        ? AppColor.white
                                                        : const Color(0xFF0A2958),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20.0.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.0.sp),
                              _buildItemSetting(
                                () => controller.onPressTermOfCondition(),
                                AppImage.ic_term,
                                StringConstants.termOfCondition.tr,
                              ),
                              SizedBox(height: 20.0.sp),
                              _buildItemSetting(
                                () => controller.onPressPrivacyPolicy(),
                                AppImage.ic_privacy,
                                StringConstants.privacy.tr,
                              ),
                              SizedBox(height: 20.0.sp),
                              _buildItemSetting(
                                () => controller.onPressContactUs(),
                                AppImage.ic_contact_us,
                                StringConstants.contactUs.tr,
                              ),
                              SizedBox(height: 20.0.sp),
                              _buildItemSetting(
                                () => controller.onPressShareApp(),
                                AppImage.ic_share_app,
                                StringConstants.shareApp.tr,
                                haveLine: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
