import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StroageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageStroage(stroageName, file, ispost) async {
    String id = Uuid().v1();
    Reference ref = ispost
        ? _storage
            .ref()
            .child(stroageName)
            .child(_auth.currentUser!.uid)
            .child(id)
        : _storage.ref().child(stroageName).child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot sanp = await uploadTask;
    String downloadUrl = await sanp.ref.getDownloadURL();
    return downloadUrl;
  }
}
