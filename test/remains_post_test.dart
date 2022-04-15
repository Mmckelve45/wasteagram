import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/export.dart';
// import 'package:wasteagram/models/leftover_info_post.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  test(
      'Testing attributes in the RemainsPost model (in leftover_info_post.dart)',
      () {
    final date = Timestamp.fromDate(DateTime.now());
    const latitude = 5.0;
    const longitude = 5.0;
    const quantity = 2;
    const imageURL = "ImageURL";

    RemainsPost remainsPost = RemainsPost(
        date: date,
        latitude: latitude,
        longitude: longitude,
        quantity: quantity,
        imageURL: imageURL);
    expect(remainsPost.date, date);
    expect(remainsPost.latitude, latitude);
    expect(remainsPost.longitude, longitude);
    expect(remainsPost.quantity, quantity);
    expect(remainsPost.imageURL, imageURL);
  });

  test(
      'Testing attributes in the leftOverInfo model (in leftover_info.dart)',
      () {
    final date = Timestamp.fromDate(DateTime.now());
    const latitude = 5.0;
    const longitude = 5.0;
    const quantity = 2;
    const imageURL = "ImageURL";

    LeftOverInfo remains = LeftOverInfo(
        date: date,
        latitude: latitude,
        longitude: longitude,
        quantity: quantity,
        imageURL: imageURL);
    expect(remains.date, date);
    expect(remains.latitude, latitude);
    expect(remains.longitude, longitude);
    expect(remains.quantity, quantity);
    expect(remains.imageURL, imageURL);
  });
}
