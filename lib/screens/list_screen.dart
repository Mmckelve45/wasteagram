// import 'package:flutter/foundation.dart';
import 'package:wasteagram/export.dart';
// import 'package:wasteagram/models/leftover_info.dart';
import 'package:intl/intl.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late File image;
  final picker = ImagePicker();
  int wastedCount = 0;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewPostScreen(image: image),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData &&
            snapshot.data!.docs != null &&
            snapshot.data!.docs.length > 0) {
          return Scaffold(
            appBar: AppBar(
              title: Center(
                //revist
                child:
                    Text('Wasteagram - ' + wastedQuantity(snapshot).toString()),
              ),
            ),
            body: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var entry = snapshot.data!.docs[index];
                  return ListTile(
                    title: Text(DateFormat.yMd().add_jm().format(entry['date'].toDate())),
                    trailing: Text(entry['quantity'].toString()),
                    onTap: () {
                      LeftOverInfo remains = LeftOverInfo(
                          date: entry['date'],
                          latitude: entry['latitude'],
                          longitude: entry['longitude'],
                          quantity: entry['quantity'],
                          imageURL: entry['imageURL']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LeftOverInfoScreen(remains: remains)),
                      );
                    },
                  );
                }),
                backgroundColor: Colors.amberAccent,
            floatingActionButton: Semantics(
              child: FloatingActionButton(
                onPressed: () => getImage(),
                child: Icon(Icons.camera_front),
              ),
              button: true,
              enabled: true,
              label: 'Camera',
              onTapHint: 'Select an Image',
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        } else {
          return Scaffold(
              appBar: AppBar(),
              body: Center(child: CircularProgressIndicator()), backgroundColor: Colors.amberAccent,
              // new
              floatingActionButton: Semantics(
              child: FloatingActionButton(
                onPressed: () => getImage(),
                child: Icon(Icons.camera_front),
              ),
              button: true,
              enabled: true,
              label: 'Camera',
              onTapHint: 'Select an Image',
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        }
      },
    );
  }

  int wastedQuantity(snapshot) {
    wastedCount = 0;
    for (int i = 0; i < snapshot.data.docs.length; i++) {
      int addQuantity = snapshot.data!.docs[i]['quantity'];
      wastedCount += addQuantity;
    }
    return wastedCount;
  }
}
