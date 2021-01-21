import 'package:flutter/material.dart';
import 'package:panos_blessed/login/login_screen.dart';
import 'package:panos_blessed/models/admin_users_manager.dart';
import 'package:panos_blessed/models/cart_manager.dart';
import 'package:panos_blessed/models/home_manager.dart';
import 'package:panos_blessed/models/product.dart';
import 'package:panos_blessed/models/product_manager.dart';
import 'package:panos_blessed/models/user_manager.dart';
import 'package:panos_blessed/screens/address/address_screen.dart';
import 'package:panos_blessed/screens/base_screen.dart';
import 'package:panos_blessed/screens/cart/cart_screen.dart';
import 'package:panos_blessed/screens/edit_product/edit_product_screen.dart';
import 'package:panos_blessed/screens/product/product_screen.dart';
import 'package:panos_blessed/screens/select_product/select_product_screen.dart';
import 'package:panos_blessed/screens/signup_screen.dart';
import 'package:provider/provider.dart';

void main (){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserManager(),
            lazy: false,
          ),
          ChangeNotifierProvider(
            create: (_) => ProductManager(),
            lazy: false,
          ),
          ChangeNotifierProxyProvider<UserManager, CartManager>(
            create: (_) => CartManager(),
            lazy: false,
            update: (_, userManager, cartManager) =>
            cartManager..updateUser(userManager),
          ),
          ChangeNotifierProvider(
            create: (_) => HomeManager(),
            lazy: false,
          ),
          ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
              create: (_) => AdminUsersManager(),
              lazy: false,
              update: (_, userManager, adminUsersManager) =>
            adminUsersManager..updateUser(userManager),
          ),
        ],
      child: MaterialApp(
            title: 'Panos Blessed',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: const Color.fromARGB(255,75,75,75),
              scaffoldBackgroundColor: const Color.fromARGB(255,50,50,50),
              appBarTheme: const AppBarTheme(
                elevation: 0
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            onGenerateRoute: (settings){
              switch(settings.name){
                case '/login':
                  return MaterialPageRoute(
                      builder: (_) => LoginScreen()
                  );
                case '/signup':
                  return MaterialPageRoute(
                      builder: (_) => SingUpScreen()
                  );
                case '/cart':
                  return MaterialPageRoute(
                      builder: (_) => CartScreen()
                  );
                case '/address':
                  return MaterialPageRoute(
                      builder: (_) => AddressScreen()
                  );
                case '/product':
                  return MaterialPageRoute(
                      builder: (_) => ProductScreen(
                        settings.arguments as Product
                      )
                  );
                case '/select_product':
                  return MaterialPageRoute(
                      builder: (_) => SelectProductScreen()
                  );
                case '/edit_product':
                  return MaterialPageRoute(
                      builder: (_) => EditProductScreen(
                        settings.arguments as Product
                      )
                  );
                case '/':
                default:
                return MaterialPageRoute(
                    builder: (_) => BaseScreen()
                );
              }
            }
          ),
    );


  }
}
