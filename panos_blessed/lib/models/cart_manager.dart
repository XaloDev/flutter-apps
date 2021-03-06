import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:panos_blessed/models/address.dart';
import 'package:panos_blessed/models/cart_product.dart';
import 'package:panos_blessed/models/product.dart';
import 'package:panos_blessed/models/user.dart';
import 'package:panos_blessed/models/user_manager.dart';
import 'package:panos_blessed/services/cepaberto_service.dart';

class CartManager extends ChangeNotifier{

  List<CartProduct> items = [];

  User user;
  Address  address;

  num productsPrice = 0.0;

  void updateUser(UserManager userManager){
    user = userManager.user;
    items.clear();


    if(user != null){
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartReference.getDocuments();

    items = cartSnap.documents.map(
            (d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated)
    ).toList();
  }


  void addToCart(Product product){
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    } catch(e){
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      user.cartReference.add(cartProduct.toCartItemMap()).then(
              (doc) => cartProduct.id = doc.documentID);
      _onItemUpdated();
    }
    notifyListeners();
  }

  void removeOfCart(CartProduct cartProduct){
    items.removeWhere((p) => p.id == cartProduct.id);
    user.cartReference.document(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  void _onItemUpdated(){
    productsPrice = 0.0;

    for(int i=0; i< items.length; i++){
      final cartProduct = items[i];

      if(cartProduct.quantity < 1){
        removeOfCart(cartProduct);
        i--;
        continue;
      }
      productsPrice += cartProduct.totalPrice;

      _updateCartProduct(cartProduct);
    }
    notifyListeners();
  }

  void _updateCartProduct(CartProduct cartProduct){
    if(cartProduct.id != null) {
      user.cartReference.document(cartProduct.id)
          .updateData(cartProduct.toCartItemMap());
    }
  }

  bool get isCartValid {
    for(final cartProduct in items){
      if(!cartProduct.hasStock) return false;
    }
    return true;
  }

  Future<void> getAddress(String cep) async {
      final cepAbertoService = CepAbertoService();
      try {
        final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);

        if(cepAbertoAddress != null){
            address = Address(
            street: cepAbertoAddress.logradouro,
            district: cepAbertoAddress.bairro,
            zipCode: cepAbertoAddress.cep,
            city: cepAbertoAddress.cidade.nome,
            state: cepAbertoAddress.estado.sigla,
            lat: cepAbertoAddress.latitude,
            long: cepAbertoAddress.longitude
          );
            notifyListeners();
        }


      } catch (e){
      }
  }

}