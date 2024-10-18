import 'package:cloud_firestore/cloud_firestore.dart';

final fi = FirebaseFirestore.instance;

// FR - firestore reference

final stafFR = fi.collection('accounts');
final appbasic = fi.collection('appdata');
