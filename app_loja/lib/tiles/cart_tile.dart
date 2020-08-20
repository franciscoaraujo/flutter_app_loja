import 'package:app_loja/datas/cart_product.dart';
import 'package:app_loja/datas/product_data.dart';
import 'package:app_loja/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  final CartProduct _cartProduct;

  CartTile(this._cartProduct);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: this._cartProduct.getProductData() == null
            ?
            //busca o conteudo do carrinho no banco se caso nao estiver na tela
            FutureBuilder<DocumentSnapshot>(
                future: Firestore.instance
                    .collection('products')
                    .document(this._cartProduct.getCategory())
                    .collection('items')
                    .document(this._cartProduct.getPid())
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    this._cartProduct.setProductData(
                        ProductData.fromDocument(snapshot.data));
                    return _buildContent(context);
                  } else {
                    return Container(
                      height: 70.0,
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    );
                  }
                },
              )
            : _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    
    CartModel.of(context).updatePrice();

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          width: 120.0,
          child: Image.network(
            this._cartProduct.getProductData().getImages()[0],
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  this._cartProduct.getProductData().getTitle(),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                ),
                Text(
                  'Tamanho: ${this._cartProduct.getSize()}',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                Text(
                  'R\$ ${this._cartProduct.getProductData().getPrice().toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      color: Theme.of(context).primaryColor,
                      onPressed:
                          this._cartProduct.getQuantity() > 1 ? () {
                            CartModel.of(context).decPrduct(this._cartProduct);
                          } : null,
                    ),
                    Text(this._cartProduct.getQuantity().toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        CartModel.of(context).incPrduct(this._cartProduct);
                      },
                    ),
                    FlatButton(
                      child: Text('Remover'),
                      textColor: Colors.grey[500],
                      onPressed: () {
                        CartModel.of(context).removeCartItem(this._cartProduct);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
