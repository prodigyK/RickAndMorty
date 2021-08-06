import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/future/domain/entities/person_entity.dart';

abstract class PersonState extends Equatable {
  @override
  List<Object> get props => [];
}

class PersonEmptyState extends PersonState {}

class PersonLoadingState extends PersonState {
  final List<PersonEntity> oldPersons;
  final bool isFirstFetch;

  PersonLoadingState(this.oldPersons, [this.isFirstFetch = false]);

  @override
  List<Object> get props => [oldPersons];
}

class PersonLoadedState extends PersonState {
  final List<PersonEntity> persons;

  PersonLoadedState(this.persons);

  @override
  List<Object> get props => [persons];
}

class PersonErrorState extends PersonState {
  final String message;

  PersonErrorState(this.message);

  @override
  List<Object> get props => [message];
}
