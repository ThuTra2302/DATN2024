import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/app_controller.dart';
import '../../controller/setting_controller.dart';
import '../../res/image/app_image.dart';
import '../../res/string/app_strings.dart';
import '../../util/disable_glow_behavior.dart';
import '../theme/app_color.dart';
import '../widget/app_container.dart';
import '../widget/app_header.dart';
import '../widget/app_image_widget.dart';
import '../widget/app_touchable3.dart';
import 'sub_screen.dart';

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 16.0.sp),
                child: AppImageWidget.asset(
                  path: imagePath,
                  width: 20.0.sp,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 15.0.sp,
                    color: AppColor.black333,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        haveLine
            ? Container(
                width: Get.width,
                height: 1.5.sp,
                margin: EdgeInsets.only(
                  top: 14.0.sp,
                ),
                decoration: const BoxDecoration(
                  color: AppColor.gray1D6,
                  shape: BoxShape.rectangle,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      backgroundColor: AppColor.grayFF9,
      showBanner: true,
      child: Column(
        children: [
          const AppHeader(
            title: 'Setting',
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: DisableGlowBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(
                      () => Get.find<AppController>().isPremium.value
                          ? const SizedBox.shrink()
                          : AppTouchable3(
                              onPressed: () {
                                Get.to(() => const SubScreen());
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.symmetric(horizontal: 16.0.sp),
                                child: AppImageWidget.asset(
                                  path: AppImage.bannerSetting,
                                ),
                              ),
                            ),
                    ),
                    SizedBox(height: 20.0.sp),
                    Container(
                      width: Get.width - 48.0.sp,
                      padding: EdgeInsets.symmetric(
                        vertical: 20.0.sp,
                        horizontal: 16.0.sp,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.0.sp),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildItemSetting(
                            () => controller.onPressPrivacyPolicy(),
                            AppImage.ic_privacy,
                            StringConstants.privacy.tr,
                          ),
                          SizedBox(height: 20.0.sp),
                          _buildItemSetting(
                            () => controller.onPressTermOfCondition(),
                            AppImage.ic_term,
                            StringConstants.termOfCondition.tr,
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
                    ),
                    SizedBox(height: 20.0.sp),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
