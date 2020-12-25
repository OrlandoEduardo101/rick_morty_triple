import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rick_morty_triple/app/modules/home/infra/model/character_model.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          onChanged: controller.setlistSearch,
          decoration:
              InputDecoration(icon: Icon(Icons.search), hintText: 'Search'),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [

          Observer(builder: (_) {
              return Center(
               // height: MediaQuery.of(context).size.height * 0.86,
                child: controller.listResult.isNotEmpty
                    ? ListView.builder(
            itemCount: controller.listResult.length,
            itemBuilder: (_, index) {
              CharacterModel item = controller.listResult[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(item.image))),
                    ),
                  ),
                  title: Text(item.name),
                  subtitle: Text('${item.id}'),
                ),
              );
            })
                    : ListView.builder(
            itemCount: controller.listChart.length,
            itemBuilder: (_, index) {
              CharacterModel item = controller.listChart[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(item.image))),
                    ),
                  ),
                  title: Text(item.name),
                  subtitle: Text('${item.id}'),
                ),
              );
            }),
              );
            }),
          
          Observer(builder: (_) {
            if (controller.loading) 
              return Center(
                child: CircularProgressIndicator(),
              ); 
              return Container(); 
          }),

          Observer(builder: (_) {
            if(controller.state == MyState.error){
              /*ScaffoldMessenger.of(context).showSnackBar(
                new SnackBar(content: new Text(controller.error.message)));*/
            return Container(
              child: Text(controller.error.message),
              color: Colors.redAccent,
            );
            }
            return Container();
          }),
        ],
      ),
    );
  }
}
