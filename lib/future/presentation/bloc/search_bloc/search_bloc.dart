import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/future/domain/usecases/search_person.dart';
import 'package:rick_and_morty/future/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/future/presentation/bloc/search_bloc/search_state.dart';

class PersonSearchBlock extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBlock(this.searchPerson) : super(PersonEmpty());

  @override
  Stream<PersonSearchState> mapEventToState(PersonSearchEvent event) async* {
    if (event is PersonSearch) {
      yield PersonLoadingState();

      final failureOrPerson = await searchPerson(SearchPersonParams(query: event.personQuery));
      yield failureOrPerson.fold(
        (failure) => PersonErrorState(_mapFailureToMessage(failure)),
        (persons) => PersonLoadedState(persons),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch(failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unknown Failure';
    }
  }
}
