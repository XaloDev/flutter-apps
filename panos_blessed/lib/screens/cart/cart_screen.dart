import 'package:flutter/material.dart';
import 'package:panos_blessed/commons/custom_drawer/price_card.dart';
import 'package:panos_blessed/models/cart_manager.dart';
import 'package:panos_blessed/screens/cart/components/cart_tile.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      centerTitle: true,
      ),
    body: Consumer<CartManager>(
      builder: (_, cartManager, __){
        return ListView(
          children: <Widget>[
            Column(
                children: cartManager.items.map(
                        (cartProduct) => CartTile(cartProduct)).toList(),
            ),
            PriceCard(
              buttonText: 'Continuar para Entrega',
              onPressed: cartManager.isCartValid ?(){
                Navigator.of(context).pushNamed('/address');
              } : null,
            ),
          ]
        );
      }
    ),
    );
  }
}
