import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/future/domain/entities/person_entity.dart';
import 'package:rick_and_morty/future/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/future/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/future/presentation/bloc/search_bloc/search_state.dart';
import 'package:rick_and_morty/future/presentation/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for a char...');

  String _query = '';

  final _suggestions = [
    'Rick',
    'Morty',
    'Beth',
    'Summer',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        return close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<PersonSearchBlock>(context, listen: false)..add(PersonSearch(query));
    return BlocBuilder<PersonSearchBlock, PersonSearchState>(
      builder: (context, state) {
        if (state is PersonLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PersonLoadedState) {
          final persons = state.persons;
          if(persons.isEmpty) {
            return _showErrorText('Characters is not found');
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              PersonEntity result = persons[index];
              return SearchResult(person: result);
            },
            itemCount: persons.length,
          );
        } else if (state is PersonErrorState) {
          return _showErrorText(state.message);
        } else {
          return Center(child: Icon(Icons.now_wallpaper));
        }
      },
    );
  }

  Widget _showErrorText(String message) {
    return Center(child: Text(message));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 0) {
      return Container();
    }
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_suggestions[index]),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(thickness: 0.5);
      },
      itemCount: _suggestions.length,
    );
  }
}
