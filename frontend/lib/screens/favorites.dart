import 'package:flutter/material.dart';
import 'package:namer_app/providers/my_app_state.dart';
import 'package:namer_app/widgets/flutter_dialog.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var favorites = appState.favorites;
    if (favorites.isEmpty) {
      return const Center(
        child: Text('No favorites yet'),
      );
    }
    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.all(8),
            child: Text('You have ${favorites.length} favorites pairs')),
        ...favorites
            .map((pair) => ListTile(
                  leading: const Icon(Icons.favorite),
                  title: Text(pair.asPascalCase),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FlutterDialog(
                            onConfirm: () => {
                              appState.removeFavorite(pair),
                              Navigator.of(context).pop()
                            },
                            title: 'Remove Favorite',
                            content: Text(
                                'Would you like to remove ${pair.asPascalCase} from your favorites?'),
                          );
                        },
                      );
                    },
                  ),
                ))
            .toList(),
      ],
    );
  }
}
