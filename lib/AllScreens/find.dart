import 'package:maps_launcher/maps_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(
    double latitude,
    double longitude,
  ) async {
    // // String googleMapUrl =
    // //     "https:/www.google.com/maps/search/?api=1&query=$Latitude,$Longitude";

    // // if (await canLaunch(googleMapUrl)) {
    // //   await launch(googleMapUrl);
    // // } else {
    // //   throw 'Could not open the Map';
    // }
    try {
      MapsLauncher.launchQuery(
          'Folaj Laundry, Johnson Awe St, 200131, Ibadan, Nigeria');
    } catch (e) {
      print(e);
    }
  }
}
