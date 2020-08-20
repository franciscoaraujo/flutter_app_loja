import 'package:app_loja/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {

final VoidCallback buy;
CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            
            double total = model.getProductsPrice() + model.getShipPrice() + model.getDiscount();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Resumo do pedido',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text('Subtotal'), Text('R\$ ${model.getProductsPrice().toStringAsFixed(2)}')],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text('Desconto'), Text('R\$ ${model.getDiscount().toStringAsFixed(2)}')],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text('Entrega'), Text('R\$ ${ model.getShipPrice().toStringAsFixed(2)}')],
                ),
                Divider(),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text('R\$ ${total.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18.0))
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                RaisedButton(
                  child: Text('Finalizar Pedido'),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: buy,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
