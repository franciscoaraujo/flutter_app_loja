import 'package:app_loja/models/user_model.dart';
import 'package:app_loja/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Entrar',
          style: TextStyle(fontSize: 18.0),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Criar Conta',
              style: TextStyle(fontSize: 18.0),
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SingupScreen()),
              );
            },
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || !text.contains('@'))
                      return 'E-email inválido!';
                  },
                ),
                SizedBox(
                  height: 16.0,
                ), //apenas colocando um espaco entre o textfield
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                  ),
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return 'Senha inválida';
                  },
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: (){
                      if(_emailController.text.isEmpty){
                        _onFailEmail();
                      }else{
                         model.recoverPass(email: _emailController.text);
                        _onConfirmacaoEmail();
                      }
                    },
                    child: Text(
                      'Esquecei minha senha',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 46.0,
                  child: RaisedButton(
                    child: Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        //todo login

                      }

                      model.signiN(
                          email: _emailController.text,
                          pass: _passController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
     _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text('Falha ao entrar!'),
      duration: Duration(seconds: 2),
    ));
  }

  void _onFailEmail() {
     _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text('Insira um e-mail para recuperação!'),
      duration: Duration(seconds: 2),
    ));
  }

  void _onConfirmacaoEmail() {
     _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor:Theme.of(context).primaryColor,
      content: Text('Confira seu email!'),
      duration: Duration(seconds: 2),
    ));
  }

}
