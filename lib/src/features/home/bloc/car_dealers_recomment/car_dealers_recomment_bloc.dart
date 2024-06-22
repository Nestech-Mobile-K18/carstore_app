import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/src/features/home/bloc/car_dealers_recomment/car_dealders_recomment_state.dart';
import 'package:my_app/src/features/home/bloc/car_dealers_recomment/car_dealers_recomment_event.dart';
import 'package:my_app/src/services/api/car_dealers_api.dart';

class CarDealersRecommentBloc
    extends Bloc<CarDealersRecommentEvent, CarDealdersRecommentState> {
  final CarDealersAPI carDealersAPI;

  CarDealersRecommentBloc(this.carDealersAPI)
      : super(CarDealersRecommentInitial()) {
    on<CarDealersRecommentStart>(_onCarDealersStart);
  }

  Future<void> _onCarDealersStart(CarDealersRecommentStart event,
      Emitter<CarDealdersRecommentState> emit) async {
    emit(CarDealerRecommentProgress());

    try {
      final carDealers = await carDealersAPI.carRecommentResponse();
      emit(CarDealersRecommentSuccess(carDealers: carDealers));
    } catch (e) {
      print('Bloc error: $e');
      emit(CarDealersRecommentFailure(error: e.toString()));
    }
  }
}
