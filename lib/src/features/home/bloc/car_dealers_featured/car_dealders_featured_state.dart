import 'package:my_app/src/features/data/home/car_response.dart';

sealed class CarDealdersFeaturedState {}

class CarDealersFeaturedInitial extends CarDealdersFeaturedState {}

class CarDealerFeaturedProgress extends CarDealdersFeaturedState {
  final bool loading;

  CarDealerFeaturedProgress({this.loading = true});
}

class CarDealersFeaturedSuccess extends CarDealdersFeaturedState {
  final List<CarResponse> carDealers;

  CarDealersFeaturedSuccess({required this.carDealers});
}

class CarDealersFeaturedFailure extends CarDealdersFeaturedState {
  final String error;

  CarDealersFeaturedFailure({required this.error});
}

class CarDealersFeaturedReset extends CarDealdersFeaturedState {}
