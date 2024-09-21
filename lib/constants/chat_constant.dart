import 'package:firebase_database/firebase_database.dart';

final DatabaseReference chatGroupRef = FirebaseDatabase.instance.ref().child("GroupChat");
var chatref = FirebaseDatabase.instance.ref().child("PersonalChat");
