import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final firestore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
final storage = FirebaseStorage.instance;
final authCurrentUserMail = auth.currentUser!.email;
final authCurrentUserName = auth.currentUser!.displayName;

final userRF = firestore.collection("UserData");
final servicesRF = firestore.collection("Services");
final cartRF = firestore
    .collection("Cart")
    .doc(authCurrentUserMail)
    .collection("services");

final appointmentRF = firestore.collection("Appointment");
final bookingRF = firestore.collection("Booking");
