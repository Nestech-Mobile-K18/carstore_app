import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/src/features/application/bloc/application_event.dart';
import 'package:my_app/src/features/application/bloc/application_state.dart';

class ApplicationBlocs extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBlocs() : super(const ApplicationState()) {
    on<TriggerApplicationEvent>((event, emit) {
      emit(ApplicationState(index: event.index));
    });
  }
}
