import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:travel/app/ui/theme/app_color.dart';
import 'package:travel/app/ui/widget/custom_slidable_action.dart' as csa;

import '../../controller/history_controller.dart';
import '../../res/image/app_image.dart';
import '../widget/app_container.dart';
import '../widget/app_image_widget.dart';
import '../widget/app_touchable2.dart';
import '../widget/item_list.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    return AppContainer(
      showBanner: false,
      backgroundColor: AppColor.white,
      child: Column(
        children: [
          Expanded(
            child: controller.isLoadingList.value
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : Obx(
                    () => controller.list.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppImageWidget.asset(
                                path: AppImage.icNoDataHistory,
                              ),
                              SizedBox(height: 8.0.sp),
                              const Text(
                                'You don\'t have any trip yet?',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF8E8E93),
                                ),
                              ),
                              SizedBox(height: 20.0.sp),
                              AppTouchable2(
                                  onPressed:
                                  controller.onPressWeatherForYourTrip,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 100.sp, vertical: 12.sp),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.sp),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF437AFF),
                                        Color(0xFF67A4FE)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                  child: Text(
                                    "Add now",
                                    style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )),
                            ],
                          )
                        : Obx(
                            () => SlidableAutoCloseBehavior(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: controller.list.length,
                                itemBuilder: (context, index) {
                                  return Slidable(
                                    key: ValueKey(controller.list[index]),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      extentRatio: 0.15,
                                      children: [
                                        csa.SlidableAction(
                                          onPressed: (context) {
                                            controller.onPressDelete(
                                                controller.list.value[index]);
                                          },
                                          // foregroundColor: Colors.red,
                                          backgroundColor: AppColor.red,
                                          icon: AppImage.icDelete,
                                        ),
                                      ],
                                    ),
                                    child: ItemList(
                                      onPressed: () =>
                                          controller.onPressItem(index),
                                      addressFrom:
                                          controller.list[index].addressFrom ??
                                              "",
                                      addressTo:
                                          controller.list[index].addressTo ??
                                              "",
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}
