import 'package:app_loja/datas/cart_product.dart';
import 'package:app_loja/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;

  List<CartProduct> products = [];

  String couponCode;
  int discountPercentage = 0;

  bool isLoading = false;

  CartModel(this.user){
    if(user.isLoggedIn())
      _loadCartItem();
  }
  //Habilitando o CartModel para acessar de qualquer lugar do aplicativo
  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .add(cartProduct.topMap())
        .then((doc) {
      cartProduct.setCid(doc.documentID);
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(cartProduct.getCiD())
        .delete();

    products.remove(cartProduct);
    notifyListeners();
  }

  void decPrduct(CartProduct cartProduct) {
    cartProduct.decrementValue();
    _atualizaBancoDeDados(cartProduct);
  }

  void incPrduct(CartProduct cartProduct) {
    cartProduct.incrementValue();
    _atualizaBancoDeDados(cartProduct);
  }

  void _atualizaBancoDeDados(CartProduct cartProduct) {
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(cartProduct.getCiD())
        .updateData(cartProduct.topMap());
    notifyListeners();
  }

  void _loadCartItem() async {
    QuerySnapshot query =  await Firestore.instance
          .collection('users').document(user.firebaseUser.uid).collection('cart').getDocuments();

     products = query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

     notifyListeners();
  }

  void setCoupon(String couponCode, int discounPercentage){
    this.couponCode = couponCode;
    this.discountPercentage = discounPercentage;
  }
}
