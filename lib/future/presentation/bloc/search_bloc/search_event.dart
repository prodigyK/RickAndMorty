import 'package:equatable/equatable.dart';

abstract class PersonSearchEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class PersonSearch extends PersonSearchEvent {
  final String personQuery;

  PersonSearch(this.personQuery);
}
