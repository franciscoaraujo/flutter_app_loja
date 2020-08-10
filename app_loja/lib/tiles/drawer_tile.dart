import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final int page;

  final PageController pageController;
  DrawerTile(this.icon, this.text, this.pageController, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          pageController.jumpToPage(page);//vai para a pagina de fato
        },
        
        child: Container(
          height: 60.0,
          child: Row(//adicionando icone e texto no mesma linha
            children: <Widget>[
              Icon(
                icon,
                size: 32.0, //faz controle da cor do icone
                color: pageController.page.round() == page
                    ? Theme.of(context).primaryColor
                    : Colors.grey[700],
              ),
              SizedBox(
                width: 30.0,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: pageController.page.round() == page
                    ? Theme.of(context).primaryColor
                    : Colors.grey[700],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
