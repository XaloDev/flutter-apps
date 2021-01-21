import 'package:flutter/material.dart';
import 'package:panos_blessed/commons/custom_drawer/custom_icon_button.dart';
import 'package:panos_blessed/models/item_color.dart';

class EditItemColor extends StatelessWidget {

  const EditItemColor({Key key, this.color, this.onRemove,
    this.onMoveDown, this.onMoveUp}) : super(key: key);

  final ItemColor color;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 35,
          child: TextFormField(
            initialValue: color.name,
            decoration: const InputDecoration(
              labelText: 'Cor',
              isDense: true
            ),
            validator: (name){
              if(name.isEmpty) {
                return 'Preencha o campo';
              }else if(name != 'Branco' && name != 'Preto' && name != 'Rose' ){
                return 'Cor inválida';
              }else{
                return null;
              }
            },
            onChanged: (name) => color.name = name,
          ),
        ),
        const SizedBox(width: 4,),
        Expanded(
          flex: 25,
          child: TextFormField(
            initialValue: color.stock?.toString(),
            decoration: const InputDecoration(
                labelText: 'Estoque',
                isDense: true
            ),
            keyboardType: TextInputType.number,
            validator: (stock){
              if(int.tryParse(stock) == null){
                return 'Valor inválido';
              }else{
                return null;
              }
            },
            onChanged: (stock) => color.stock = int.tryParse(stock),
          ),
        ),
        const SizedBox(width: 4,),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: color.price?.toStringAsFixed(2),
            decoration: const InputDecoration(
                labelText: 'Preço',
                isDense: true,
              prefixText: 'R\$ '
            ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (price){
              if(num.tryParse(price) == null){
                return 'Valor inválido';
              }else{
                return null;
              }
            },
            onChanged: (price) => color.price = num.tryParse(price),
          ),
        ),
         CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
          ),
        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDown,
        ),

      ],
    );
  }
}
