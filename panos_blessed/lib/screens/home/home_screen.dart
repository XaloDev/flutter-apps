import 'package:flutter/material.dart';
import 'package:panos_blessed/commons/custom_drawer/custom_drawer.dart';
import 'package:panos_blessed/models/home_manager.dart';
import 'package:panos_blessed/models/user_manager.dart';
import 'package:panos_blessed/screens/home/components/add_section_widget.dart';
import 'package:panos_blessed/screens/home/components/section_list.dart';
import 'package:panos_blessed/screens/home/components/section_staggered.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: <Widget>[
         Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors:[
                  Color.fromARGB(255, 50, 50, 50),
                  Color.fromARGB(255, 100, 100, 100)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Panos Blessed'),
                  centerTitle: true,
                ),
                actions: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () => Navigator.of(context).pushNamed('/cart'),
                    color: Colors.white,
                  ),
                  Consumer2<UserManager, HomeManager>(
                    builder: (_, userManager, homeManager, __){
                      if(userManager.adminEnabled && !homeManager.loading) {
                        if(homeManager.editing){
                          return PopupMenuButton(
                              onSelected: (e){
                                if(e == 'Salvar'){
                                  homeManager.saveEditing();
                                } else {
                                  homeManager.discardEditing();
                                }
                              },
                              itemBuilder: (_){
                                return ['Salvar', 'Descartar'].map((e){
                                  return PopupMenuItem(
                                    value: e,
                                    child: Text(e),
                                  );
                                }).toList();
                              }
                          );
                        }else{
                          return IconButton(
                              icon: const  Icon(Icons.edit),
                              onPressed: homeManager.enterEditing,
                          );
                        }

                      } else {
                        return Container();
                      }
                    },
                  )
                ],
              ),
                  Consumer<HomeManager>(
                      builder: (_, homeManager, __){
                        if(homeManager.loading){
                          return const SliverToBoxAdapter(
                            child: LinearProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                              backgroundColor: Colors.transparent,
                            ),
                          );
                        }

                        final List<Widget> children = homeManager.sections.map<Widget>(
                                (section) {
                                  switch(section.type){
                                    case 'List':
                                      return SectionList(section);
                                    case 'Staggered':
                                      return SectionStaggered(section);
                                    default:
                                      return Container();
                                  }
                                }
                                ).toList();

                        if(homeManager.editing){
                          children.add(AddSectionWidget(homeManager));
                        }

                        return SliverList(
                          delegate: SliverChildListDelegate(children),
                        );
                      }

                  )
            ],
          ),
        ],
      ),
    );
  }
}
