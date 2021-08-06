import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/future/domain/entities/person_entity.dart';

abstract class PersonSearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class PersonEmpty extends PersonSearchState {}

class PersonLoadingState extends PersonSearchState {}

class PersonLoadedState extends PersonSearchState {
  final List<PersonEntity> persons;

  PersonLoadedState(this.persons);

  @override
  List<Object> get props => [persons];
}

class PersonErrorState extends PersonSearchState {
  final String message;

  PersonErrorState(this.message);

  @override
  List<Object> get props => [message];
}