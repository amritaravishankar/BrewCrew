import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //collection reference - use this reference to read/write that collection   //Firestore creates the collection for you if it doesn't exist (created behind the scenes)
  final CollectionReference brewCollection = Firestore.instance.collection(
      'Brews'); // 'Brews' is a random name


  Future<void> updateUserData(String name, String sugars, int strength) async
  {
    //use the collection reference 'brew collection' to access a specific document identified using the uid for each specific user
    return await brewCollection.document(uid).setData(
        { //setData since you want to set/update the data
          'Name': name,
          'Sugars': sugars,
          'Strength': strength
        });
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot (QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc){
      return Brew(
          name: doc.data['Name']??" ",
          sugars: doc.data['Sugars']?? '0',
          strength: doc.data['Strength']?? 0);
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) //document snapshot is what is returned to us in that stream
  {
    return UserData(
        uid: uid,
        name: snapshot.data['Name'], //snapshot.data is how we get the data from the snapshot, and the specific data item is given in []
        sugars: snapshot.data['Sugars'],
        strength: snapshot.data['Strength']
    );
  }

  //get brews stream
  Stream<List<Brew>> get brews //snapshot of firestore collection
  {
    //access using the brew collection
    return brewCollection.snapshots().map(_brewListFromSnapshot);
    //OR .map((QuerySnapshot snapshot) => _brewListFromSnapshot(snapshot));
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}

