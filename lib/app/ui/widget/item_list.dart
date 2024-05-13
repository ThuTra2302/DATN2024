import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel/app/ui/theme/app_color.dart';

import '../../res/image/app_image.dart';
import 'app_image_widget.dart';
import 'dot.dart';

class ItemList extends StatelessWidget {
  final String addressTo, addressFrom;
  final Function()? onPressed;

  const ItemList(
      {Key? key,
      required this.addressTo,
      required this.addressFrom,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 16.sp),
        margin: EdgeInsets.symmetric(vertical: 10.0.sp, horizontal: 24.0.sp),
        decoration: BoxDecoration(
            color: AppColor.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(12.sp)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000514).withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 25.0.sp,
                  height: 25.0.sp,
                  padding: const EdgeInsets.all(3),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.gray6,
                  ),
                  child: AppImageWidget.asset(path: AppImage.icFrom),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    addressFrom,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        color: const Color(0xFF333333),
                        fontWeight: FontWeight.w400,
                        fontSize: 13.sp),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 30.sp,
                ),
                Column(
                  children: [
                    Dot(
                        size: 2.sp,
                        margin: EdgeInsets.symmetric(
                            vertical: 1.5, horizontal: 12.5.sp - 2)),
                    Dot(
                        size: 2.sp,
                        margin: EdgeInsets.symmetric(
                            vertical: 1.5, horizontal: 12.5.sp - 2)),
                    Dot(
                        size: 2.sp,
                        margin: EdgeInsets.symmetric(
                            vertical: 1.5, horizontal: 12.5.sp - 2)),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Container(
                  width: 25.0.sp,
                  height: 25.0.sp,
                  padding: const EdgeInsets.all(3),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.gray6,
                  ),
                  child: AppImageWidget.asset(path: AppImage.icTo),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    addressTo,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        color: const Color(0xFF333333),
                        fontWeight: FontWeight.w400,
                        fontSize: 13.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
