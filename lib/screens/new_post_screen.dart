// import 'package:location/location.dart';
// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
import 'package:wasteagram/export.dart';
// import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({Key? key, required this.image}) : super(key: key);
  final File image;

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  // final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  var url;
  var date;
  final remainsPost = RemainsPost();

  final numberController = TextEditingController();
  late LocationData locationData;
  // late Timestamp date;
  bool check = false;

  getimage() async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child(path.basename(widget.image.path));
    await storageReference.putFile(widget.image);
    url = await storageReference.getDownloadURL();
    check = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    date = Timestamp.fromDate(DateTime.now());
    retrieveLocation();
  }

  void retrieveLocation() async {
    locationData = await Location().getLocation();
    remainsPost.longitude = locationData.longitude;
    remainsPost.latitude = locationData.latitude;
    setState(() {});
  }

  Widget build(BuildContext context) {
    if (check == false) {
      getimage();
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Post"),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: photoWidget(),
        backgroundColor: Colors.amberAccent,);
  }

  Widget photoWidget() {
    if (url == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.network(url),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Semantics(
                  child: TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        labelText: 'Quantity of Items',
                        border: OutlineInputBorder()),
                    controller: numberController,
                    validator: (value) {
                      if (value!.isEmpty || value == null || int.parse(value) < 1) {
                        return 'Please enter a number greater than 0';
                      } else {
                        return null;
                      }
                    },
                  ),
                  enabled: true,
                  label: 'Quantity of Items',
                  onTapHint: 'Please Input the Number of Items',
                ),
              ),
            ),
            Expanded(
                child: Semantics(
              enabled: true,
              label: 'Submit',
              onTapHint: 'Upload the Image and Number of Items',
              child: InkWell(
                child: Icon(Icons.cloud_upload_outlined, size: 110),
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    final parser = int.parse(numberController.text);
                    remainsPost.quantity = parser;
                    remainsPost.imageURL = url;
                    remainsPost.date = date;
                    FirebaseFirestore.instance.collection('posts').add({
                      'date': remainsPost.date,
                      'latitude': remainsPost.latitude,
                      'longitude': remainsPost.longitude,
                      'imageURL': remainsPost.imageURL,
                      'quantity': remainsPost.quantity,
                    });
                    Navigator.pop(context);
                  }
                  
                },
              ),
            ))
          ],
        ),
      );
    }
  }
}
