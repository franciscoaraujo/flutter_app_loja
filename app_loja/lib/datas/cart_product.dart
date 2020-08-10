import 'package:app_loja/datas/product_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartProduct {
  String _cId;
  String _category;
  String _pId;
  int _quantity;
  String _size;
  
  ProductData _productData;
  
  CartProduct(ProductData productData, String size){
    this._pId = productData.getId();
    this._size = size;
    this._quantity = 1;
    this._category = productData.getCategory();
  }

  CartProduct.fromDocument(DocumentSnapshot snapshot) {
    _cId = snapshot.documentID;
    _category = snapshot.data['category'];
    _pId = snapshot.data['pid'];
    _quantity = snapshot.data['quantity'];
    _size = snapshot.data['size'];
  }

  Map<String, dynamic> topMap() {
    return {
      'category': _category,
      'pid': _pId,
      'quantity': _quantity,
      'size': _size,
      //'product': _productData.toResumeMap()
    };
  }

  void setCid(String cId){
    this._cId = cId;
  }

  String getCiD() {
    return this._cId;
  }

  String getCategory() {
    return this._category;
  }

  String getSize(){
    return _size;
  }
  
  String getPid() {
    return this._pId;
  }

  int getQuantity() {
    return this._quantity;
  }


  ProductData getProductData(){
    return this._productData;
  } 

  void setProductData(ProductData productData){
    this._productData = productData;
  } 

  void decrementValue(){
    this._quantity--;
  }

  void incrementValue(){
    this._quantity++;
  }
}
