import 'package:wasteagram/export.dart';
// import 'package:wasteagram/models/leftover_info.dart';
import 'package:intl/intl.dart';

class LeftOverInfoScreen extends StatelessWidget {
  final LeftOverInfo remains;
  const LeftOverInfoScreen({Key? key, required this.remains}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var formatDate = DateFormat.yMEd(remains.date);
    // DateTime formattedDate = DateTime.parse(remains.date);
    return Scaffold(
      appBar: AppBar(
        title: Text('LeftOver Details'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Date: ${(DateFormat.yMd().add_jm().format(remains.date.toDate()))}',
                style: TextStyle(fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(remains.imageURL),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Location: (${remains.latitude}, ${remains.longitude})',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(
                'quantity: ${remains.quantity}',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.amberAccent,
    );
  }
}
