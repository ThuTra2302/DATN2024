import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel/app/controller/weather_detail_controller.dart';
import 'package:travel/app/extension/int_temp.dart';
import 'package:travel/app/res/string/app_strings.dart';
import 'package:travel/app/ui/widget/app_container.dart';
import 'package:travel/app/ui/widget/app_touchable3.dart';

import '../../controller/app_controller.dart';
import '../../controller/main_controller.dart';
import '../../res/image/app_image.dart';
import '../../util/gradient.dart';
import '../theme/app_color.dart';
import '../widget/app_image_widget.dart';

class WeatherDetailScreen extends GetView<WeatherDetailController> {
  const WeatherDetailScreen({Key? key}) : super(key: key);

  Widget _buildTimeInfo(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm');
    String formattedTime = formatter.format(now);
    return Column(
      key: const ValueKey(1),
      children: [
        Row(
          children: [
            SizedBox(
              width: 20.sp,
            ),
            AppTouchable3(
              onPressed: Get.back,
              outlinedBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0.sp),
              ),
              padding: EdgeInsets.all(8.sp),
              child: AppImageWidget.asset(
                path: AppImage.ic_back,
                color: controller.backColor,
                width: 24.0.sp,
                height: 24.0.sp,
              ),
            ),
            SizedBox(
              width: 16.sp,
            ),
            Text(
              formattedTime,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
            ),
            Container(
              height: 22.sp,
              width: 1.sp,
              margin: EdgeInsets.symmetric(horizontal: 3.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.sp),
                color: const Color(0xFFC7C7CC),
              ),
            ),
            Text(
              DateFormat('EEEE, dd MMMM', Get.find<AppController>().currentLocale.languageCode).format(DateTime.now()),
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColor.white,
                fontSize: 18.0.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 20.sp,
            )
          ],
        ),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 15.sp,
                                ),
                                Expanded(
                                  child: Text(
                                    controller.data.value['weather']?.summary ?? '',
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
                                  width: 15.sp,
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
                              height: 17.sp,
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
                                    int valueInC = (controller.data['weather']?.temperature ?? 0).round();
                                    return Row(
                                      children: [
                                        GradientText(
                                          controller.data['weather']?.temperature == null ? '--' : '${valueInC.toUnit(u)}',
                                          style: TextStyle(
                                            color: AppColor.white,
                                            fontSize: 96.0.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          gradientDirection: GradientDirection.ttb,
                                          colors: [Colors.white, Colors.white.withOpacity(0)],
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
                                Obx(
                                  () => FittedBox(
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
                                        Text(
                                          "${controller.feelLikeTemp} °${Get.find<AppController>().currentUnitTypeTemp.value.name.toUpperCase()}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0.sp,
                                          ),
                                        ),
                                      ],
                                    ),
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
                                          controller.chooseC.value = true;
                                          Get.find<MainController>().onPressUnitTemp(UnitTypeTemp.c);

                                          controller.feelLikeTemp.value = (controller.data["weather"]?.apparentTemperature.round() as int)
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
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.sp,
                                      ),
                                      AppTouchable3(
                                        onPressed: () {
                                          controller.chooseC.value = false;
                                          Get.find<MainController>().onPressUnitTemp(UnitTypeTemp.f);

                                          controller.feelLikeTemp.value = (controller.data["weather"]?.apparentTemperature.round() as int)
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
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
              ],
            ),
          ),
          Positioned(
            top: -80.sp,
            left: 20.sp,
            child: (controller.data.value['weather']?.icon ?? '').isEmpty
                ? const SizedBox.shrink()
                : AppImageWidget.asset(
                    width: Get.width / 2,
                    height: Get.width / 2.5,
                    path: controller.getIcon(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12.0.sp,
      ),
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: Column(
        children: [
          _buildTimeInfo(context),
          SizedBox(
            height: 180.0.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildDetails() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          left: 20.sp,
          top: 170.sp,
          bottom: 20.sp,
          right: 20.sp,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.sp),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 57.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppImageWidget.asset(
                    path: AppImage.icTo,
                    width: 20.0.sp,
                  ),
                  SizedBox(width: 8.0.sp),
                  Obx(
                    () => Expanded(
                      child: Text(
                        controller.data.value['address'] ?? '--',
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: TextStyle(
                          color: const Color(0xFF202020),
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  //
                ],
              ),
            ),
            SizedBox(height: 24.0.sp),
            Text(
              'Detail',
              style: TextStyle(color: const Color(0xFF333333), fontWeight: FontWeight.w500, fontSize: 16.sp),
            ),
            SizedBox(height: 12.0.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: WeatherItemWidget(
                    iconPath: AppImage.ic_item_wind,
                    title: StringConstants.wind.tr,
                    value: '${controller.windSpeed} Km/h',
                    status: controller.d,
                  ),
                ),
                SizedBox(width: 22.sp),
                Expanded(
                  flex: 1,
                  child: WeatherItemWidget(
                    iconPath: AppImage.ic_wind_gust,
                    title: StringConstants.windGust.tr,
                    value: '${controller.windGust} Km/h',
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: WeatherItemWidget(
                    iconPath: AppImage.ic_humidity,
                    title: StringConstants.humidity.tr,
                    value: '${controller.humidity.toStringAsFixed(2)}%',
                  ),
                ),
                SizedBox(width: 22.sp),
                Expanded(
                  flex: 1,
                  child: WeatherItemWidget(
                    iconPath: AppImage.iv_visibility,
                    title: StringConstants.visibility.tr,
                    value: '${controller.visibility.toStringAsFixed(4)} km/h',
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: WeatherItemWidget(
                    iconPath: AppImage.ic_precipitation,
                    title: StringConstants.precipitation.tr,
                    value: '${controller.precipitation} mm',
                  ),
                ),
                SizedBox(width: 22.sp),
                Expanded(
                  flex: 1,
                  child: WeatherItemWidget(
                    iconPath: AppImage.ic_barometer,
                    title: StringConstants.barometer.tr,
                    value: '${controller.barometer} hPa',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80.sp,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return AppContainer(
      backgroundColor: AppColor.white3,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xFF4A8AF4),
            Color(0xFF93E3F4),
          ],
          begin: Alignment.centerRight,
          end: Alignment.topLeft,
          stops: [0.52, 1],
        )),
        child: Column(
          children: [
            buildHeader(context),
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(child: _buildDetails()),
                  Positioned(
                    top: -80.sp,
                    child: _buildWeatherInfo(context),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherItemWidget extends StatelessWidget {
  final String iconPath, title;
  final String value;
  final String? status;

  const WeatherItemWidget({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.value,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: Colors.black,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    );

    TextStyle textStyle1 = TextStyle(
      color: AppColor.grayE93,
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w400,
    );

    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
      decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.white, borderRadius: BorderRadius.circular(12.0.sp), boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0, 8),
          blurRadius: 10,
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppImageWidget.asset(
            path: iconPath,
            height: 28.0.sp,
            width: 28.0.sp,
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              status != null
                  ? Text(
                      "$value | $status",
                      style: textStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  : Text(
                      value,
                      style: textStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
              const SizedBox(height: 6),
              Text(
                title,
                style: textStyle1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
