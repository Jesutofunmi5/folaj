import 'package:rider_app/Models/nearByCleaners.dart';

class GeoFireAssistant

{
  static List<NearByCleaners> nearbycleanersList = [];

  static void removeCleanerFromList(String key)
  {
     int index = nearbycleanersList.indexWhere((element) => element.key == key);

     nearbycleanersList.removeAt(index);
  }

  static void  updateCleanerNearByLocation( NearByCleaners cleaner)
  {
    int index = nearbycleanersList.indexWhere((element) => element.key == cleaner.key);

    nearbycleanersList[index].latitude = cleaner.latitude;
    nearbycleanersList[index].longitude = cleaner.longitude;


  }
}