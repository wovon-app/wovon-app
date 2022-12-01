import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'colors/categories.dart';

class AppState extends Equatable {
  final List<String> activeFilters = [];

  bool isSelected(String filter) {
    return activeFilters.contains(filter);
  }

  AppState toggleFilter(String filter) {
    var newState = copy();
    if (isSelected(filter)) {
      newState.activeFilters.remove(filter);
    } else {
      newState.activeFilters.add(filter);
    }
    return newState;
  }

  AppState copy() {
    var newState = AppState();
    newState.activeFilters.addAll(activeFilters);
    return newState;
  }

  @override
  List<Object?> get props => [activeFilters];
}

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState()) {
    on<ToggleFilterEvent>(
      (event, emit) => emit(
        state.toggleFilter(event.filter),
      ),
    );
  }
}

abstract class AppEvent {}

class ToggleFilterEvent extends AppEvent {
  final String filter;

  ToggleFilterEvent(this.filter);
}
