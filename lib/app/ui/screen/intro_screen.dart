import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel/app/ui/widget/app_container.dart';

import '../../controller/intro_controller.dart';
import '../../res/image/app_image.dart';
import '../theme/app_color.dart';
import '../widget/app_image_widget.dart';
import '../widget/app_touchable2.dart';

class IntroScreen extends GetView<IntroController> {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider(
            items: controller.listImageAsset.map((listItem) {
              return Stack(
                children: [
                  Positioned(
                    top: -5.sp,
                    child: AppImageWidget.asset(
                      path: listItem['image'],
                      width: Get.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              );
            }).toList(),
            carouselController: controller.carouselController,
            options: CarouselOptions(
              height: Get.height,
              viewportFraction: 1,
              onPageChanged: (index, reason) => controller.onPageChanged(index),
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: false,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Positioned(
            top: Get.height / 2 + 30.sp,
            child: Container(
              width: Get.width,
              height: Get.height / 2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AppImage.circle,
                    ),
                    fit: BoxFit.fill),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 20.sp),
                    Obx(
                      () => Text(
                        controller.listImageAsset[controller.currentIndex.value]['title'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.black333,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          controller.listImageAsset[controller.currentIndex.value]['subTitle'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.black333,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 220.sp,
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: Obx(
              () => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 50,
                ),
                child: InkWell(
                  onTap: controller.onPressNext,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Padding(
                          padding: EdgeInsets.all(2.0.sp),
                          child: CustomPaint(
                            painter: GradientCircularProgressPainter(
                              value: (controller.currentIndex.value + 1) / 4,
                              strokeWidth: 4,
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF5552FF),
                                  Color(0xDD9FB4FF),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF3388F2),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 80.sp,
            right: 24.sp,
            child: AppTouchable2(
              onPressed: controller.onPressSkip,
              child: Text(
                'Skip',
                style: TextStyle(
                  color: const Color(0xFF8E8E93),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class GradientCircularProgressPainter extends CustomPainter {
  GradientCircularProgressPainter({
    required this.value,
    required this.strokeWidth,
    required this.gradient,
  });

  final double value;
  final double strokeWidth;
  final Gradient gradient;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Shader gradient = this.gradient.createShader(rect);

    final Paint paint = Paint()
      ..shader = gradient
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; // Bo tròn hai đầu

    const double startAngle = -90.0;
    final double sweepAngle = 360.0 * value;

    final double radius = (size.width - strokeWidth) / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle * (3.14 / 180),
      sweepAngle * (3.14 / 180),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
