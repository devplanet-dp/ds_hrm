import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_hrm/model/division.dart';
import 'package:ds_hrm/model/user.dart';
import 'package:ds_hrm/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _staffCollectionReference =
      FirebaseFirestore.instance.collection('staff');

  final CollectionReference _adminDivisionCollectionReference =
      FirebaseFirestore.instance.collection('division');

  final CollectionReference _gNDivisionCollectionReference =
      FirebaseFirestore.instance.collection('gn_division');
  final CollectionReference _devDivisionCollectionReference =
      FirebaseFirestore.instance.collection('development_division');

  final StreamController<List<UserModel>> _userController =
      StreamController<List<UserModel>>.broadcast();

  // #6: Create a list that will keep the paged results
  List<List<UserModel>> _allPagedResults = [];

  static const int UserLimit = 20;

  late DocumentSnapshot _lastDocument;
  late bool _hasMoreUsers = true;

  static const TB_USERS = 'users';
  static const TB_DIVISION = 'division';
  static const TB_GN_DIVISION = 'gn_division';
  static const TB_DEV_DIVISION = 'dev_division';

  late FirebaseFirestore _firestore;

  FirestoreService() {
    this._firestore = FirebaseFirestore.instance;
  }

  Future createUser(UserModel user) async {
    try {
      await _usersCollectionReference
          .doc(user.userId)
          .set(user.toJson(), SetOptions(merge: true));
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future createDivision(Division division) async {
    try {
      await _adminDivisionCollectionReference.add(division.toJson());
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future updateUserProfile(
      {required String uid, required String profileUri}) async {
    try {
      await _usersCollectionReference
          .doc(uid)
          .update({'profileUrl': profileUri});
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Stream listenToUserslTime(String searchKey) {
    // Register the handler for when the posts data changes
    _requestMoreUsers(searchKey);
    return _userController.stream;
  }

  // #1: Move the request posts into it's own function
  void _requestMoreUsers(String searchKey) {
    // #2: split the query from the actual subscription
    var pagePostsQuery = _usersCollectionReference
        .orderBy('createdDate', descending: true)
        // #3: Limit the amount of results
        .limit(UserLimit);
    // #5: If we have a document start the query after it
    if (_lastDocument != null) {
      pagePostsQuery = pagePostsQuery.startAfterDocument(_lastDocument);
    }

    if (!_hasMoreUsers) return;

    // #7: Get and store the page index that the results belong to
    var currentRequestIndex = _allPagedResults.length;

    pagePostsQuery.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.docs.isNotEmpty) {
        var users = postsSnapshot.docs
            .map((snapshot) => UserModel.fromSnapshot(snapshot))
            .toList();

        // #8: Check if the page exists or not
        var pageExists = currentRequestIndex < _allPagedResults.length;

        // #9: If the page exists update the posts for that page
        if (pageExists) {
          _allPagedResults[currentRequestIndex] = users;
        }
        // #10: If the page doesn't exist add the page data
        else {
          _allPagedResults.add(users);
        }

        // #11: Concatenate the full list to be shown
        var allPosts = _allPagedResults.fold<List<UserModel>>(
            [], (initialValue, pageItems) => initialValue..addAll(pageItems));

        // #12: Broadcase all posts
        _userController.add(allPosts);

        // #13: Save the last document from the results only if it's the current last page
        if (currentRequestIndex == _allPagedResults.length - 1) {
          _lastDocument = postsSnapshot.docs.last;
        }

        // #14: Determine if there's more posts to request
        _hasMoreUsers = users.length == UserLimit;
      }
    });
  }

  void requestMoreUsers(searchKey) => _requestMoreUsers(searchKey);

  Future<FirebaseResult> getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      return FirebaseResult(data: UserModel.fromSnapshot(userData));
    } catch (e) {
      if (e is PlatformException) {
        return FirebaseResult.error(errorMessage: e.message.toString());
      }

      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<UserModel> getUserById(String uid) async {
    var userData = await _usersCollectionReference.doc(uid).get();
    return UserModel.fromSnapshot(userData);
  }

  Stream<List<UserModel>> searchUsers(
      {int limit = 10, required String searchKey, @required currentUid}) {
    Stream<QuerySnapshot> snap = searchKey.isNotEmpty
        ? _usersCollectionReference
            .where('userName', isGreaterThanOrEqualTo: searchKey)
            .where('userName', isLessThan: searchKey + 'z')
            .limit(limit)
            .snapshots()
        : _usersCollectionReference
            .where('userId', isNotEqualTo: currentUid)
            .limit(limit)
            .snapshots();

    return snap.map((snapshot) =>
        snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList());
  }

  Stream<List<UserModel>> searchAllUsers(
      {required String searchKey, @required currentUid}) {
    Stream<QuerySnapshot> snap = searchKey.isNotEmpty
        ? _usersCollectionReference
            .where('userName', isGreaterThanOrEqualTo: searchKey)
            .where('userName', isLessThan: searchKey + 'z')
            .snapshots()
        : _usersCollectionReference
            .where('userId', isNotEqualTo: currentUid)
            .snapshots();

    return snap.map((snapshot) =>
        snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList());
  }

  Stream<List<UserModel>> streamAllUsers(String currentUid) {
    Stream<QuerySnapshot> snap = _usersCollectionReference
        .where('userId', isNotEqualTo: currentUid)
        .snapshots();

    return snap.map((snapshot) =>
        snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList());
  }
}
