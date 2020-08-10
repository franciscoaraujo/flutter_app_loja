import 'package:app_loja/models/cart_model.dart';
import 'package:app_loja/models/user_model.dart';
import 'package:app_loja/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(), // posso acessar o usuario de qualquer parte do app
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            return ScopedModel<CartModel>(
              model: CartModel(model), //posso acessar o carrinho de qualquer parte do app
              child: MaterialApp(
                  title: 'Flutter Clothing',
                  theme: ThemeData(
                      primarySwatch: Colors.blue,
                      primaryColor: Color.fromARGB(255, 4, 125, 141)),
                  debugShowCheckedModeBanner: false,
                  home: HomeScreen()),
            );
          },
        ));
  }
}
