import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hemsirem/firebase/models.dart';

class VeriController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  final Stream<QuerySnapshot> userStream = FirebaseFirestore.instance.collection("user").snapshots();
  late RxList<InsanModel> insanModel;

  @override
  void onInit() {
    super.onInit();
    collectionReference = firebaseFirestore.collection("user");
    insanModel = RxList<InsanModel>([]);
    insanModel.bindStream(getAllInsanModel());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Stream<List<InsanModel>> getAllInsanModel() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => InsanModel.fromMap(item)).toList());
}
