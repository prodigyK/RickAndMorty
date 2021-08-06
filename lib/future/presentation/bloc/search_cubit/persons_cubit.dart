import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/future/domain/entities/person_entity.dart';
import 'package:rick_and_morty/future/domain/usecases/get_all_persons.dart';
import 'package:rick_and_morty/future/presentation/bloc/search_cubit/persons_state.dart';

class PersonCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;

  PersonCubit(this.getAllPersons) : super(PersonEmptyState());

  int page = 1;

  void loadPersons() async {
    // print('== loadPersons state = $state');
    if (state is PersonLoadingState) {
      return;
    }

    final currentState = state;
    List<PersonEntity> oldPersons = [];
    if (currentState is PersonLoadedState) {
      oldPersons = currentState.persons;
    }

    emit(PersonLoadingState(oldPersons, page == 1));

    final failureOrPersons = await getAllPersons(PagePersonParams(page));
    return failureOrPersons.fold(
      (failure) => emit(PersonErrorState(_getErrorMessage(failure))),
      (persons) {
        page++;
        oldPersons.addAll(persons);
        emit(PersonLoadedState(oldPersons));
      },
    );
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unknown Failure';
    }
  }
}
