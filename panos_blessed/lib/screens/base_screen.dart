import 'package:flutter/material.dart';
import 'package:panos_blessed/models/page_manager.dart';
import 'package:panos_blessed/models/user_manager.dart';
import 'package:panos_blessed/screens/admin_users/admin_users_screen.dart';
import 'package:panos_blessed/screens/home/home_screen.dart';
import 'package:panos_blessed/screens/products_screen.dart';
import 'file:///C:/Users/icaro/Desktop/Eu/projetosstudio/panos_blessed/lib/commons/custom_drawer/custom_drawer.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {

  final PageController pageController = PageController();



  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __){
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget> [
              HomeScreen(),
              ProductsScreen(),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Linda e gostosa demais cara'),
                ),
              ),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Bixa do bundão, te amo <3'),
                ),
              ),
              if(userManager.adminEnabled)
                ...[
                      AdminUsersScreen(),
                      Scaffold(
                      drawer: CustomDrawer(),
                      appBar: AppBar(
                      title: const Text('Pedidos'),
          ))
                ]
            ],
          );
        }
      ),
    );
  }
}
