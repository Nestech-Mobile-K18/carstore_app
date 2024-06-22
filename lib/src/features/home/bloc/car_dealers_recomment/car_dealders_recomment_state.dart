import 'package:my_app/src/features/data/home/car_response.dart';

sealed class CarDealdersRecommentState {}

class CarDealersRecommentInitial extends CarDealdersRecommentState {}

class CarDealerRecommentProgress extends CarDealdersRecommentState {
  final bool loading;

  CarDealerRecommentProgress({this.loading = true});
}

class CarDealersRecommentSuccess extends CarDealdersRecommentState {
  final List<CarResponse> carDealers;

  CarDealersRecommentSuccess({required this.carDealers});
}

class CarDealersRecommentFailure extends CarDealdersRecommentState {
  final String error;

  CarDealersRecommentFailure({required this.error});
}

class CarDealersRecommentReset extends CarDealdersRecommentState {}
