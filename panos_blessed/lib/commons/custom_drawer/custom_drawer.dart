import 'package:flutter/material.dart';
import 'package:panos_blessed/commons/custom_drawer/custom_drawer_header.dart';
import 'package:panos_blessed/commons/custom_drawer/drawer_tile.dart';
import 'package:panos_blessed/models/user_manager.dart';
import 'package:provider/provider.dart';



class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget> [
          Container(
            decoration: const BoxDecoration(
              gradient:  LinearGradient(
                colors: [
                  Colors.cyan,
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
          ),
          ListView(
            children: <Widget>[
              CustomDrawerHeader(),
              const Divider(),
              const DrawerTile(iconData: Icons.home, title: 'Início', page: 0,),
              const DrawerTile(iconData: Icons.list, title: 'Produtos', page: 1,),
              const DrawerTile(iconData: Icons.playlist_add_check, title: 'Meus Pedidos', page: 2,),
              const DrawerTile(iconData: Icons.location_on, title: 'Lojas', page: 3,),
              Consumer<UserManager>(
                  builder: (_, userManager, __){
                    if(userManager.adminEnabled){
                      return Column(
                        children: const <Widget>[
                           Divider(),
                           DrawerTile(iconData: Icons.settings, title: 'Usuários', page: 4,),
                           DrawerTile(iconData: Icons.settings, title: 'Pedidos', page: 5,),
                        ],

                      );
                    }else {
                      return Container();
                    }
                  }
              ),
            ],
          ),
        ],
      ),
    );
  }
}
