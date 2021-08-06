import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/future/domain/entities/person_entity.dart';
import 'package:rick_and_morty/future/presentation/bloc/search_cubit/persons_cubit.dart';
import 'package:rick_and_morty/future/presentation/bloc/search_cubit/persons_state.dart';
import 'package:rick_and_morty/future/presentation/widgets/person_card_widget.dart';

class PersonsList extends StatelessWidget {
  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        // BlocProvider.of<PersonCubit>(context).loadPersons();
        // print('== setupScrollController() - atEdge = ${scrollController.position.atEdge}');
        if (scrollController.position.pixels != 0) {
          context.read<PersonCubit>().loadPersons();
          // print('== setupScrollController() - scrollController.position.pixels != 0, pixels = ${scrollController.position.pixels}');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);

    return BlocBuilder<PersonCubit, PersonState>(
      builder: (context, state) {
        print('== BlocBuilder state - ${(state is PersonLoadingState) ? state.oldPersons.length : (state is PersonLoadedState) ? state.persons.length : 0}');
        List<PersonEntity> persons = [];
        bool isLoading = false;
        if (state is PersonLoadingState && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is PersonLoadingState) {
          persons = state.oldPersons;
          isLoading = true;
        } else if (state is PersonLoadedState) {
          persons = state.persons;
        } else if (state is PersonErrorState) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          );
        }
        return ListView.separated(
          controller: scrollController,
          itemBuilder: (_, index) {
            if (index < persons.length) {
              return PersonCard(person: persons[index]);
            } else {
              Timer(Duration(milliseconds: 30), () {
                scrollController.jumpTo(scrollController.position.maxScrollExtent);
              });
              return _loadingIndicator();
            }
          },
          separatorBuilder: (_, index) {
            return Divider(color: Colors.grey.shade400);
          },
          itemCount: persons.length + (isLoading ? 1 : 0),
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
