import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds_hrm/model/branch.dart';
import 'package:ds_hrm/model/division.dart';
import 'package:ds_hrm/model/education.dart';
import 'package:ds_hrm/model/employee.dart';
import 'package:ds_hrm/model/item.dart';
import 'package:ds_hrm/model/sale.dart';
import 'package:ds_hrm/model/user.dart';
import 'package:ds_hrm/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _empCollectionReference =
      FirebaseFirestore.instance.collection(TB_EMPLOYEE);

  final CollectionReference _adminDivisionCollectionReference =
      FirebaseFirestore.instance.collection('division');

  final CollectionReference _gNDivisionCollectionReference =
      FirebaseFirestore.instance.collection('gn_division');

  final CollectionReference _devDivisionCollectionReference =
      FirebaseFirestore.instance.collection('development_division');

  final CollectionReference _branchCollection =
      FirebaseFirestore.instance.collection(TB_BRANCH);

  final CollectionReference _itemsCollection =
      FirebaseFirestore.instance.collection(TB_ITEM);

  final CollectionReference _saleCollection =
      FirebaseFirestore.instance.collection(TB_SALE);

  static const TB_ITEM = 'items';
  static const TB_SALE = 'sale';
  static const TB_BRANCH = 'branch';

  final StreamController<List<Employee>> _empController =
      StreamController<List<Employee>>.broadcast();

  // #6: Create a list that will keep the paged results
  List<List<Employee>> _allPagedResults = [];

  static const int UserLimit = 20;

  DocumentSnapshot? _lastDocument;
  bool _hasMoreUsers = true;

  static const TB_USERS = 'users';
  static const TB_DIVISION = 'division';
  static const TB_GN_DIVISION = 'gn_division';
  static const TB_DEV_DIVISION = 'development_division';
  static const TB_EMPLOYEE = 'employee';

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

  Future<FirebaseResult> createEmployee(
      {required Employee employee,
      required List<Education> qualification}) async {
    try {
      await _empCollectionReference
          .doc(employee.id)
          .set(employee.toJson(), SetOptions(merge: true))
          .then((value) => addQualification(employee.id, qualification));
      return FirebaseResult(data: true);
    } catch (e) {
      if (e is PlatformException) {
        return FirebaseResult.error(errorMessage: e.message!);
      }

      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future addQualification(String docId, List<Education> q) async {
    try {
      List<Map> list = List.generate(q.length, (index) => q[index].toJson());
      await _empCollectionReference
          .doc(docId)
          .update({'education': FieldValue.arrayUnion(list)});
    } catch (e) {
      print('ERROR:$e');
    }
  }

  Future createDivision(Division division) async {
    try {
      await _devDivisionCollectionReference.add(division.toJson());
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future createBranch(Branch branch) async {
    try {
      await _branchCollection.doc(branch.id).set(branch.toJson());
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

  Stream listenToEmployeesRealTime(String searchKey) {
    // Register the handler for when the posts data changes
    _requestMoreEmployees(searchKey);
    return _empController.stream;
  }

  // #1: Move the request posts into it's own function
  void _requestMoreEmployees(String searchKey) {
    // #2: split the query from the actual subscription
    var pagePostsQuery = _empCollectionReference
        // .orderBy('joinedDate', descending: false)
        // #3: Limit the amount of results
        .limit(UserLimit);
    // #5: If we have a document start the query after it
    if (_lastDocument != null) {
      pagePostsQuery = pagePostsQuery.startAfterDocument(_lastDocument!);
    }

    if (!_hasMoreUsers) return;

    // #7: Get and store the page index that the results belong to
    var currentRequestIndex = _allPagedResults.length;

    pagePostsQuery.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.docs.isNotEmpty) {
        var users = postsSnapshot.docs
            .map((snapshot) => Employee.fromSnapshot(snapshot))
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
        var allPosts = _allPagedResults.fold<List<Employee>>(
            [], (initialValue, pageItems) => initialValue..addAll(pageItems));

        // #12: Broadcase all posts
        _empController.add(allPosts);

        // #13: Save the last document from the results only if it's the current last page
        if (currentRequestIndex == _allPagedResults.length - 1) {
          _lastDocument = postsSnapshot.docs.last;
        }

        // #14: Determine if there's more posts to request
        _hasMoreUsers = users.length == UserLimit;
      }
    });
  }

  void requestMoreEmployees(searchKey) => _requestMoreEmployees(searchKey);

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

  Stream<List<Employee>> streamEmployees(String searchKey, SearchType type) {
    Stream<QuerySnapshot> searchSnap;

    ///change query according to search type
    switch (type) {
      case SearchType.name:
        searchSnap = _empCollectionReference
            .where('searchName', isGreaterThanOrEqualTo: searchKey)
            .where('searchName', isLessThan: searchKey + 'z')
            .snapshots();
        break;
      case SearchType.mobile:
        searchSnap = _empCollectionReference
            .where('mobileNumber', isGreaterThanOrEqualTo: searchKey)
            .where('mobileNumber', isLessThan: searchKey + 'z')
            .snapshots();
        break;
      case SearchType.nic:
        searchSnap = _empCollectionReference
            .where('nic', isGreaterThanOrEqualTo: searchKey)
            .where('nic', isLessThan: searchKey + 'z')
            .snapshots();
        break;
      default:
        searchSnap = _empCollectionReference
            .where('searchName', isGreaterThanOrEqualTo: searchKey)
            .where('searchName', isLessThan: searchKey + 'z')
            .snapshots();
        break;
    }

    Stream<QuerySnapshot> snap =
        searchKey.isNotEmpty ? searchSnap : _empCollectionReference.snapshots();

    return snap.map((snapshot) =>
        snapshot.docs.map((doc) => Employee.fromSnapshot(doc)).toList());
  }

  Future<FirebaseResult> getDivisions(String divisionTable) async {
    try {
      var snap = await _firestore.collection(divisionTable).get();
      return FirebaseResult(
          data: snap.docs.map((doc) => Division.fromSnapshot(doc)).toList());
    } catch (e) {
      if (e is PlatformException) {
        return FirebaseResult.error(errorMessage: e.message!);
      }
      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  /// accounts services
  Future<FirebaseResult> createSale(
      {required Sale sale, required List<SaleItem> saleItems}) async {
    try {
      await _saleCollection
          .doc(sale.id)
          .set(sale.toJson(), SetOptions(merge: true))
          .then((value) => addSaleItem(sale.id ?? '', saleItems));
      return FirebaseResult(data: true);
    } catch (e) {
      if (e is PlatformException) {
        return FirebaseResult.error(errorMessage: e.message!);
      }

      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future updateItemOnSale(SaleItem sale) async {
    try {
      await _itemsCollection.doc(sale.id).update({
        'amount': FieldValue.increment(-(int.parse(sale.issuedAmount ?? '0'))),
        'issued_amount':
            FieldValue.increment(int.parse(sale.issuedAmount ?? '0'))
      });
    } catch (e) {}
  }

  Future addSaleItem(String docId, List<SaleItem> q) async {
    try {
      List<Map> list = List.generate(q.length, (index) => q[index].toJson());
      await _saleCollection
          .doc(docId)
          .update({'items': FieldValue.arrayUnion(list)});
      for (var value in q) {
        await updateItemOnSale(value);
      }
    } catch (e) {
      print('ERROR:$e');
    }
  }

  Future createItem(Item items) async {
    try {
      await _itemsCollection.doc(items.id).set(items.toJson());
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future updateItem(Item item) async {
    try {
      await _itemsCollection.doc(item.id).set(item.toJson());
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future removeItem(String id) async {
    try {
      await _itemsCollection.doc(id).delete();
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Stream<List<Item>> searchAllItems({required String searchKey}) {
    Stream<QuerySnapshot> snap = searchKey.isNotEmpty
        ? _itemsCollection
            .where('query', isGreaterThanOrEqualTo: searchKey)
            .where('query', isLessThan: searchKey + 'z')
            .snapshots()
        : _itemsCollection.snapshots();

    return snap.map((snapshot) =>
        snapshot.docs.map((doc) => Item.fromSnapshot(doc)).toList());
  }

  Future<FirebaseResult> getAllItems(String filter) async {
    try {
      var snap = filter.isEmpty
          ? await _itemsCollection.get()
          : await _itemsCollection
              .where('query', isGreaterThanOrEqualTo: filter)
              .where('query', isLessThan: filter + 'z')
              .get();
      return FirebaseResult(
          data: snap.docs.map((doc) => Item.fromSnapshot(doc)).toList());
    } catch (e) {
      if (e is PlatformException) {
        return FirebaseResult.error(errorMessage: e.message!);
      }
      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseResult> getAllBranches(String filter) async {
    try {
      var snap = filter.isEmpty
          ? await _branchCollection.get()
          : await _branchCollection
              .where('query', isGreaterThanOrEqualTo: filter)
              .where('query', isLessThan: filter + 'z')
              .get();
      return FirebaseResult(
          data: snap.docs.map((doc) => Branch.fromSnapshot(doc)).toList());
    } catch (e) {
      if (e is PlatformException) {
        return FirebaseResult.error(errorMessage: e.message!);
      }
      return FirebaseResult.error(errorMessage: e.toString());
    }
  }

  Stream<List<Item>> streamItems() {
    return _firestore
        .collection(TB_ITEM)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return Item.fromSnapshot(doc);
      }).toList();
    });
  }

  Stream<List<Branch>> streamBranches() {
    return _firestore
        .collection(TB_BRANCH)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return Branch.fromSnapshot(doc);
      }).toList();
    });
  }
}
