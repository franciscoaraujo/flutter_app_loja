import 'package:app_loja/tabs/home_tab.dart';
import 'package:app_loja/tabs/orders_tab.dart';
import 'package:app_loja/tabs/places_tab.dart';
import 'package:app_loja/tabs/products_tab.dart';
import 'package:app_loja/widgets/cart_buttom.dart';
import 'package:app_loja/widgets/cutsom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();
  
  @override
  Widget build(BuildContext context) {
      
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),

        Scaffold(
          appBar: AppBar(
            title: Text('Produtos'),
            centerTitle: true,
          ),
          floatingActionButton: CartButton(),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
        ),

        Scaffold(
          appBar: AppBar(
            title: Text('Lojas'),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: PlacesTab(),
        ),
        
        Scaffold(
          appBar: AppBar(
            title: Text('Meus Pedidos'),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: OrdersTab(),
        )
      ],
    );
  }
}
