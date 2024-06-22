import 'package:flutter/material.dart';
import 'package:my_app/src/features/data/home/car_response.dart';
import 'package:my_app/src/resources/responsive.dart';

class CarDealerFeatured extends StatefulWidget {
  final List<CarResponse>? carResponse;

  const CarDealerFeatured({super.key, this.carResponse});

  @override
  State<CarDealerFeatured> createState() => _CarDealerFeaturedState();
}

class _CarDealerFeaturedState extends State<CarDealerFeatured> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double imageHeight = constraints.maxWidth * (7 / 16);
        return SizedBox(
          height: imageHeight,
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.carResponse?.length ?? 0,
            itemBuilder: (context, index) {
              final car = widget.carResponse?[index];
              final imageUrl =
                  car?.image?['banner'] ?? 'https://via.placeholder.com/150';
              final specificationName = car?.specificationName ?? 'Unknown';
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: Responsive.screenWidth(context) * 0.8,
                      height: double.infinity,
                    ),
                  ),
                  Positioned(
                    bottom: 8.0,
                    left: 8.0,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        specificationName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
