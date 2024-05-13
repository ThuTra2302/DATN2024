import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel/app/ui/widget/app_dialog.dart';

import '../../theme/app_color.dart';

void showDialogAsk(BuildContext context, String ask,Function() onPressYes) {
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
              ask,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.black,
              ),
            ),
            SizedBox(height: 30.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.sp, vertical: 0.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(50.sp),
                    color: Colors.red,
                  ),
                  child: TextButton(
                    onPressed: onPressYes,
                    child: Text(
                      'Yes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.sp,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.sp, vertical: 0.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(40.sp),
                    color: const Color(0xFFE5E5EA),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Cancel',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
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
}
