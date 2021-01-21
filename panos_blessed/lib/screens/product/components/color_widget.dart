import 'package:flutter/material.dart';
import 'package:panos_blessed/models/item_color.dart';
import 'package:panos_blessed/models/product.dart';
import 'package:provider/provider.dart';

class ColorWidget extends StatelessWidget {

  const ColorWidget({this.color});

  final ItemColor color;

  Color colorContainer(String color){
    if (color == 'Preto' || color == 'preto'){
      return Colors.black;
    } else if(color == 'Branco' || color == 'branco') {
      return Colors.white;
    } else {
      return const Color.fromARGB(255, 217, 134, 149);
    }
  }

  @override
  Widget build(BuildContext context) {

    final product = context.watch<Product>();
    final selected = color == product.selectedColor;

    return GestureDetector(
      onTap: (){
        if(color.hasStock){
            if (product.selectedColor == color) {
              product.selectedColor = null;
            } else {
              product.selectedColor = color;
            }
          }
        }
    ,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: !color.hasStock ? Colors.red.withAlpha(50) : Colors.grey
          )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: !color.hasStock ? Colors.red.withAlpha(50)
                      :  colorContainer(color.name),
                border: const Border(right:BorderSide(color: Colors.grey,))
              ),
              height: !selected ? 30 : 40,
              width: !selected ? 30 : 40,

              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),

            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: Text(
                'R\$ ${color.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize:selected ? 20 : 14, color:!color.hasStock ? Colors.red.withAlpha(50)
                    : Colors.black.withAlpha(180),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
