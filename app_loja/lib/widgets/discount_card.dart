import 'package:app_loja/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiscountCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          'Cupom de Desconto',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite seu cumpo',
              ),
              initialValue: CartModel.of(context).couponCode ?? '',
              onFieldSubmitted: (text){
                Firestore.instance.collection('coupons').document(text).get().then((docSnap){
                  if(docSnap.data != null){
                    CartModel.of(context).setCoupon(text, docSnap.data['percent']);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Desconto de  ${docSnap.data['percent']}% aplicado!'),
                      backgroundColor: Theme.of(context).primaryColor,));
                  }else{
                      CartModel.of(context).setCoupon(null, 0);
                     Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Cupom não existente'),
                      backgroundColor: Colors.redAccent));
                  }
                });

              },
            ),
          ),
        ],
      ),
    );
  }
}
