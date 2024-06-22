import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/src/features/data/home/car_response.dart';
import 'package:my_app/src/features/home/bloc/car_dealers_featured/car_dealders_featured_state.dart';
import 'package:my_app/src/features/home/bloc/car_dealers_featured/car_dealers_featured_bloc.dart';
import 'package:my_app/src/features/home/bloc/car_dealers_featured/car_dealers_featured_event.dart';
import 'package:my_app/src/features/home/bloc/car_dealers_recomment/car_dealders_recomment_state.dart';
import 'package:my_app/src/features/home/bloc/car_dealers_recomment/car_dealers_recomment_bloc.dart';
import 'package:my_app/src/features/home/bloc/car_dealers_recomment/car_dealers_recomment_event.dart';
import 'package:my_app/src/pages/home/widgets/car_dealer_featured.dart';
import 'package:my_app/src/pages/home/widgets/car_dealer_recomment.dart';
import 'package:my_app/src/pages/home/widgets/home_appbar.dart';
import 'package:my_app/src/pages/home/widgets/home_search.dart';
import 'package:my_app/src/resources/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _onStartCarDealersFeatured();
    _onStartCarDealersRecomment();
  }

  void _onStartCarDealersFeatured() {
    final state = context.read<CarDealersFeaturedBloc>().state;
    if (state is! CarDealersFeaturedSuccess &&
        state is! CarDealerFeaturedProgress) {
      context.read<CarDealersFeaturedBloc>().add(CarDealersFeaturedStart());
    }
  }

  void _onStartCarDealersRecomment() {
    final state = context.read<CarDealersRecommentBloc>().state;
    if (state is! CarDealersRecommentSuccess &&
        state is! CarDealerRecommentProgress) {
      context.read<CarDealersRecommentBloc>().add(CarDealersRecommentStart());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const HomeAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const HomeSearch(),
              const SizedBox(height: 10),
              BlocBuilder<CarDealersFeaturedBloc, CarDealdersFeaturedState>(
                builder: (context, state) {
                  if (state is CarDealerFeaturedProgress) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CarDealersFeaturedSuccess) {
                    final List<CarResponse> carDealers = state.carDealers;
                    return CarDealerFeatured(
                      carResponse: carDealers,
                    );
                  } else if (state is CarDealersFeaturedFailure) {
                    return const Center(
                        child: Text('Failed to load car dealers'));
                  } else {
                    return const Center(child: Text('No featured cars found'));
                  }
                },
              ),
              BlocBuilder<CarDealersRecommentBloc, CarDealdersRecommentState>(
                builder: (context, state) {
                  if (state is CarDealerRecommentProgress) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CarDealersRecommentSuccess) {
                    final List<CarResponse> carDealers = state.carDealers;
                    return CarDealerRecomment(
                      carResponse: carDealers,
                    );
                  } else if (state is CarDealersRecommentFailure) {
                    return const Center(
                        child: Text('Failed to load car dealers'));
                  } else {
                    return const Center(child: Text('No featured cars found'));
                  }
                },
              ),
              SizedBox(
                height: Responsive.screenHeight(context) * 0.2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
