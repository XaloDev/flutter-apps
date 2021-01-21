import 'package:flutter/material.dart';
import 'package:panos_blessed/commons/custom_drawer/custom_icon_button.dart';
import 'package:panos_blessed/models/item_color.dart';
import 'package:panos_blessed/models/product.dart';
import 'package:panos_blessed/screens/edit_product/components/edit_item_color.dart';

class ColorsForm extends StatelessWidget {

  const ColorsForm(this.product);

  final Product product;


  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemColor>>(
        initialValue: product.colors,
        validator: (colors){
          if(colors.isEmpty){
            return 'Insira uma Cor';
          }else{
            return null;
          }
        },
        builder: (state) {
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
               const Expanded(
                child: Text(
                  'Cores',
                  style:  TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              CustomIconButton(
                iconData: Icons.add,
                color: Colors.black,
                onTap: () {
                  state.value.add(ItemColor());
                  state.didChange(state.value);
                },
              ),
            ],
          ),
          Column(
            children: state.value.map((color) {
              return EditItemColor(
                key: ObjectKey(color),
                color: color,
                onRemove: (){
                    state.value.remove(color);
                    state.didChange(state.value);
                },
                onMoveUp: color != state.value.first ? (){
                  final index = state.value.indexOf(color);
                  state.value.remove(color);
                  state.value.insert(index-1,color);
                  state.didChange(state.value);
                } : null,
                onMoveDown: color != state.value.last ? (){
                  final index = state.value.indexOf(color);
                  state.value.remove(color);
                  state.value.insert(index+1,color);
                  state.didChange(state.value);
                } : null,
              );
            }).toList(),
          ),
          if(state.hasError)
           Container(
            alignment: Alignment.centerLeft,
            child: Text(
          state.errorText,
          style: const TextStyle(
          color: Colors.red,
          fontSize: 12
          ),
          ),
            )

        ],
      );
    });


  }
}
