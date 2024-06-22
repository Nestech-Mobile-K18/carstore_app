import 'package:flutter/material.dart';
import 'package:my_app/src/features/data/home/car_response.dart';
import 'package:my_app/src/resources/colors.dart';
import 'package:my_app/src/resources/media_res.dart';
import 'package:my_app/src/resources/responsive.dart';
import 'package:my_app/src/widgets/common/strings_extention.dart';
import 'package:my_app/src/widgets/custom_text.dart';
import 'package:my_app/src/widgets/image_button.dart';
import 'package:my_app/src/widgets/only/home/video_player_dialog.dart';

class CarDealerRecomment extends StatefulWidget {
  final List<CarResponse>? carResponse;
  final void Function()? onPressedSeeAll;
  const CarDealerRecomment({super.key, this.carResponse, this.onPressedSeeAll});

  @override
  State<CarDealerRecomment> createState() => _CarDealerRecommentState();
}

class _CarDealerRecommentState extends State<CarDealerRecomment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                title: StringsExtention.recomment,
                size: 20,
                color: ColorsGlobal.globalBlack,
                fontWeight: FontWeight.w500,
              ),
              TextButton(
                onPressed: widget.onPressedSeeAll,
                child: const CustomText(
                  title: StringsExtention.seeAll,
                  color: ColorsGlobal.textGrey,
                  size: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 15,
              childAspectRatio: 0.65, // Adjust the aspect ratio as needed
            ),
            itemCount: widget.carResponse?.length ?? 0,
            itemBuilder: (context, index) {
              final car = widget.carResponse?[index];
              final imageUrl =
                  car?.image?['banner'] ?? 'https://via.placeholder.com/150';
              final carName = car?.carName.toString();
              final paymentCurrency = car?.paymentCurrency.toString();
              final price = car?.price.toString();
              final trailer = car?.trailer?['trailers'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: Responsive.blockSizeHeight(context) * 0.22,
                        width: (MediaQuery.of(context).size.width - 50) / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Image.asset(
                          MediaRes.threeHundredSixtyView,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 5,
                        top: -15,
                        child: Container(
                          width: Responsive.screenWidth(context) * 0.09,
                          height: Responsive.screenHeight(context) * 0.09,
                          decoration: const BoxDecoration(
                            color: ColorsGlobal.globalWhite,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border,
                              color: ColorsGlobal.globalBlack,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 5,
                        bottom: 10,
                        child: ImageButton(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  VideoPlayerDialog(
                                videoUrl: trailer,
                              ),
                            );
                          },
                          imagePath: MediaRes.videoPlay,
                        ),
                      ),
                    ],
                  ),
                  CustomText(
                    title: carName,
                    color: ColorsGlobal.globalBlack,
                    size: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        title: '$paymentCurrency.',
                        color: ColorsGlobal.globalBlack,
                        size: 15,
                      ),
                      CustomText(
                        title: price,
                        color: ColorsGlobal.globalBlack,
                        size: 15,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
