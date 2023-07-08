import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../domain/entities/character_entity.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({this.title = "Home"}) : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //use 'store' variable to access store
  HomeStore store = Modular.get()!;

  @override
  void initState() {
    super.initState();
    store.getCharAction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //leading: Icon(Icons.search),
          title: TextFormField(
            onChanged: (value) => store.setlistSearch.value = value,
            decoration: InputDecoration(icon: Icon(Icons.search), hintText: 'Search'),
          ),
        ),
        body: ScopedBuilder<HomeStore, List<CharacterEntity>>(
            store: store,
            onError: (_, error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${error?.message}'),
                backgroundColor: Colors.red[500],
              ));
              return Center(
                child: Icon(
                  Icons.search_off_rounded,
                  size: 150,
                ),
              );
            },

            /* Center(
              child: Container(
                    child: Text('${error?.message}'),
                    color: Colors.redAccent,
                  ),
            ),*/

            onLoading: (_) => Center(
                  child: CircularProgressIndicator(),
                ),
            onState: (_, List state) => Center(
                  // height: MediaQuery.of(context).size.height * 0.86,
                  child: ListView.builder(
                      itemCount: state.length,
                      itemBuilder: (_, index) {
                        CharacterEntity item = store.state[index];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(item.image!))),
                              ),
                            ),
                            title: Text(item.name!),
                            subtitle: Text('${item.id}'),
                          ),
                        );
                      }),
                )));
  }
}
