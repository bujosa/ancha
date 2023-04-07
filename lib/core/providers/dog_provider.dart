import 'package:ancha/core/models/dog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DogProvider extends ChangeNotifier {
  Stream<List<Dog>> getDogs() => FirebaseFirestore.instance
      .collection('dogs')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Dog.fromJSON(doc.data())).toList());

  Future<void> addDog(Dog dog) async {
    await FirebaseFirestore.instance.collection('dogs').add(dog.toJSON());
  }
}
