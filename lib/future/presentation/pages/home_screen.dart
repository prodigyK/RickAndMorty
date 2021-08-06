import 'package:flutter/material.dart';
import 'package:rick_and_morty/future/presentation/widgets/custom_search_delegate.dart';
import 'package:rick_and_morty/future/presentation/widgets/persons_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Characters'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
        ],
      ),
      body: PersonsList(),
    );
  }
}

