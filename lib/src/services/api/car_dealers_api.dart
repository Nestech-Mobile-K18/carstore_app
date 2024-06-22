import 'package:my_app/src/features/data/home/car_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CarDealersAPI {
  final supabase = Supabase.instance.client;

  Future<List<CarResponse>> carFeaturedResponse() async {
    try {
      final response =
          await supabase.from('car_dealers').select().eq('type', 'Featured');

      if (response.isEmpty) {
        print('No data found');
        throw Exception('No featured car dealers found');
      }

      final List<CarResponse> carDealers = (response as List<dynamic>)
          .map((json) => CarResponse.fromJson(json as Map<String, dynamic>))
          .toList();

      return carDealers;
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to load car dealers: $e');
    }
  }

  Future<List<CarResponse>> carRecommentResponse() async {
    try {
      final response =
          await supabase.from('car_dealers').select().eq('type', 'Recommended');

      if (response.isEmpty) {
        print('No data found');
        throw Exception('No featured car dealers found');
      }

      final List<CarResponse> carDealers = (response as List<dynamic>)
          .map((json) => CarResponse.fromJson(json as Map<String, dynamic>))
          .toList();

      return carDealers;
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to load car dealers: $e');
    }
  }
}
