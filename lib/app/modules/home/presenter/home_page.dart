import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:rick_morty_triple/app/modules/home/domain/errors/error.dart';
import 'package:rick_morty_triple/app/modules/home/infra/model/character_model.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({this.title = "Home"}) : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //use 'controller' variable to access controller
  HomeController controller = Modular.get()!;
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
        body: ScopedBuilder<HomeController, HomeFailure, List<CharacterModel>>(
            store: controller,

            onError: (context, HomeFailure? error) => Center(
              child: Container(
                    child: Text('${error?.message}'),
                    color: Colors.redAccent,
                  ),
            ),

            onLoading: (context) => Center(
                  child: CircularProgressIndicator(),
                ),

            onState: (_, List state) => Center(
                  // height: MediaQuery.of(context).size.height * 0.86,
                  child: ListView.builder(
                          itemCount: state.length,
                          itemBuilder: (_, index) {
                            CharacterModel item =
                                controller.state[index];
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(item.image!))),
                                  ),
                                ),
                                title: Text(item.name!),
                                subtitle: Text('${item.id}'),
                              ),
                            );
                          }),
                ))
                

    );
  }
}
