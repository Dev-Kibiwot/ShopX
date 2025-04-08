import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirebaseOperations{
  final CollectionReference cart = FirebaseFirestore.instance.collection("cart");
  final Uuid uuid =const Uuid();
  Future addItem(Map item) async{
    QuerySnapshot query = await cart.where("items.id", isEqualTo: item['id']).get();
    String uniqueId = uuid.v4();
    if (query.docs.isNotEmpty) {
      
  } else {
    await cart.doc(uniqueId).set({
      "id": uniqueId,
      "items": item,
      "timestamp": Timestamp.now(),
    });
  }
}

  Stream<QuerySnapshot> getItem(){
    final item = cart.orderBy('timestamp',descending: true).snapshots();
    return item;
   }
  
  Future<void> deleteitem(String docID){
    return cart.doc(docID).delete();
  }
}