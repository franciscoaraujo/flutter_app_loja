import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String _category;
  String _id;
  String _title;
  String _description;
  double _price;
  List _images;
  List _sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    _id = snapshot.documentID;
    _title = snapshot.data["title"];
    _description = snapshot.data["description"];
    _price = snapshot.data["price"] + 0.0;
    _images = snapshot.data["images"];
    _sizes = snapshot.data["size"];
  }

  Map<String, dynamic> toResumedMap() {
    return {"title": _title, "description": _description, "price": _price};
  }

  void setCategory(String category){
    this._category = category;
  }
  
  String getCategory() {
    return this._category;
  }

  String getId() {
    return this._id;
  }

  String getTitle() {
    return this._title;
  }

  String getDescription() {
    return this._description;
  }

  double getPrice() {
    return this._price;
  }

  List getImages() {
    return this._images;
  }

  List getSizes() {
    return this._sizes;
  }

  Map<String, dynamic> toResumeMap(){
    return {
      'title': _title,
      'description':_description,
      'price': _price
    };
  }
}
