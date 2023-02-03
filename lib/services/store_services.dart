import 'package:emart_seller/const/const.dart';

class StoreServices {
  static getProfile(uil) {
    return firestore.collection(vendorsCollection).where('id', isEqualTo: uil).get();
  }

  static getMessages(uid) {
    return firestore.collection(chatsCollection).where('toId', isEqualTo: uid).snapshots();
  }
  static getOrders(uid) {
    return firestore.collection(ordersCollection).where('vendors', arrayContains: uid).snapshots();
  }
  static getProducts(uid) {
    return firestore.collection(productsCollection).where('vendor_id', isEqualTo: uid).snapshots();
  }
  
  // static getPopularProducts(uid){
  //   return firestore.collection(productsCollection).where('vendor_id', isEqualTo: uid).orderBy('p_wishlist'.length);
  // }
}