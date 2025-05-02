import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'farm_event.dart';
part 'farm_state.dart';

class FarmBloc extends Bloc<FarmEvent, FarmState> {
  FarmBloc() : super(FarmInitial()) {
    on<FarmEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
