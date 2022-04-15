import 'package:wasteagram/export.dart';

class LeftOverInfo {
  Timestamp date;
  double latitude;
  double longitude;
  int quantity;
  String imageURL;

  LeftOverInfo(
      {required this.date,
      required this.latitude,
      required this.longitude,
      required this.quantity,
      required this.imageURL});
}
