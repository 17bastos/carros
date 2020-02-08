import 'package:carros/pages/carro/carro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritoService {

  CollectionReference get _carros => Firestore.instance.collection('carros');
  Stream<QuerySnapshot> get stream => _carros.snapshots();

  Future<bool> favoritar(context, Carro c) async {

    DocumentReference docRef = _carros.document("${c.id}");
    DocumentSnapshot doc = await docRef.get();

    if (doc.exists) {
      docRef.delete();
      return false;
    } else {
      docRef.setData(c.toMap());
      return true;
    }

  }

  Future<bool> isFavorito(Carro c) async {
    DocumentReference docRef = _carros.document("${c.id}");
    DocumentSnapshot doc = await docRef.get();

    return doc.exists;
  }
}