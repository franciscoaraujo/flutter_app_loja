import 'package:app_loja/datas/cart_product.dart';
import 'package:app_loja/datas/product_data.dart';
import 'package:app_loja/models/cart_model.dart';
import 'package:app_loja/models/user_model.dart';
import 'package:app_loja/screens/cart_screen.dart';
import 'package:app_loja/screens/login_screen.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;
  String _size;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.getTitle()),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.getImages().map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.getTitle(),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  'R\$ ${product.getPrice().toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Tamanho',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.5),
                    children: product.getSizes().map((s) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _size = s;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                                color: s == _size
                                    ? primaryColor
                                    : Colors.grey[500],
                                width: 3.0),
                          ),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(s),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: _size != null
                        ? () {
                            if (UserModel.of(context).isLoggedIn()) {
                              CartProduct  cartProduct = CartProduct(product, _size);
                              CartModel.of(context).addCartItem(cartProduct);
                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen()));
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            }
                          }
                        : null,
                    child: Text(
                      UserModel.of(context).isLoggedIn() ? 'Adicionar ao Carrinho' 
                      : 'Entre para comprar' ,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                Text(
                  'Descriçâo',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  product.getDescription(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      
    );
    
  }
}
