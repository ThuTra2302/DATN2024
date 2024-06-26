import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:travel/app/common/app_log.dart';

import '../ui/screen/sub_screen.dart';
import '../util/app_constant.dart';

class TripDetailController extends GetxController {
  late BuildContext context;

  RxList<Map> listLatLngNode = RxList();

  List<String> listWeatherType = [
    "snow",
    "sleet",
    "rain",
    "partly-cloudy-night",
    "partly-cloudy-day",
    "hail",
    "fog",
    "cloudy",
    "clear-night",
    "clear-day",
    'thunder-showers-day',
    'thunder-rain',
    'showers-day',
    'showers-night'
  ];



  late String from,to;

  @override
  void onInit() {

    listLatLngNode.value = Get.arguments['listLatLngNode'] ?? [];

    super.onInit();
  }

  _getAddress() async {
    for (Map data in listLatLngNode) {
      LatLng latLng = data['latLng'];
      GeocodingResponse geocodingResponse =
          await GoogleMapsGeocoding(apiKey: AppConstant.keyGoogleMap)
              .searchByLocation(
                  Location(lat: latLng.latitude, lng: latLng.longitude));
      if (geocodingResponse.results.isNotEmpty) {
        data['address'] = geocodingResponse.results.first.formattedAddress;
      }
    }
    listLatLngNode.refresh();
  }

  // onPressFavorite() async {
  //   isLoadingFavorite.value = true;
  //
  //   if (data == null) {
  //     HistoryTrip historyTrip = await DatabaseService().getItem(
  //        from ,
  //        to );
  //     isFavorite.value = historyTrip.isFavorite == 1;
  //
  //     if (!isFavorite.value) {
  //       await DatabaseService().updateFavorite(historyTrip);
  //       isFavorite.value = !isFavorite.value;
  //     } else {
  //       await DatabaseService().updateNotFavorite(historyTrip);
  //       isFavorite.value = !isFavorite.value;
  //     }
  //   } else {
  //     isFavorite.value = data!.isFavorite! == 1;
  //
  //     if (!isFavorite.value) {
  //       await DatabaseService().updateFavorite(data!);
  //       isFavorite.value = !isFavorite.value;
  //     } else {
  //       await DatabaseService().updateNotFavorite(data!);
  //       isFavorite.value = !isFavorite.value;
  //     }
  //   }
  //
  //   if (!Get.isRegistered<FavoriteController>()) {
  //     Get.put(FavoriteController());
  //   }
  //
  //   Get.find<FavoriteController>().list.value =
  //       await DatabaseService().getAllFavorite();
  //
  //   isLoadingFavorite.value = false;
  // }

  @override
  Future<void> onReady() async {
    super.onReady();
    _getAddress();
  }

  onPressVip() {
    Get.to(() => const SubScreen());
  }
  String getIcon(Map e) {
    String baseIcon = 'lib/app/res/image/png/';
    DateTime time =
    DateTime.fromMicrosecondsSinceEpoch(e['dateTime'] * 1000);
    AppLog.debug("${time.hour}:  ${time.minute}  : ${time.day}: ${time.month} : ${time.year} ");
    String icon = (e['weather']?.icon ?? '').isEmpty
        ? 'partly-cloudy-day'
        : e['weather']?.icon ?? "";

    int hour = time.hour;
    bool isDaytime = hour >= 6 && hour < 18;

    return '$baseIcon$icon${isDaytime ? '' : '_n'}.png';
  }
}
