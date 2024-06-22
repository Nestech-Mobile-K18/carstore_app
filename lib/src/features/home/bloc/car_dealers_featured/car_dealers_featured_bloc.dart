import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/src/features/home/bloc/car_dealers_featured/car_dealders_featured_state.dart';
import 'package:my_app/src/features/home/bloc/car_dealers_featured/car_dealers_featured_event.dart';
import 'package:my_app/src/services/api/car_dealers_api.dart';

class CarDealersFeaturedBloc
    extends Bloc<CarDealersFeaturedEvent, CarDealdersFeaturedState> {
  final CarDealersAPI carDealersAPI;

  CarDealersFeaturedBloc(this.carDealersAPI)
      : super(CarDealersFeaturedInitial()) {
    on<CarDealersFeaturedStart>(_onCarDealersStart);
  }

  Future<void> _onCarDealersStart(CarDealersFeaturedStart event,
      Emitter<CarDealdersFeaturedState> emit) async {
    emit(CarDealerFeaturedProgress());

    try {
      final carDealers = await carDealersAPI.carFeaturedResponse();
      emit(CarDealersFeaturedSuccess(carDealers: carDealers));
    } catch (e) {
      print('Bloc error: $e');
      emit(CarDealersFeaturedFailure(error: e.toString()));
    }
  }
}
