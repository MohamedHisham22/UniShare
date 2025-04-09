import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unishare/screens/tool_details_client_view/cubit/carousel_slider_cubit.dart';
import 'package:unishare/screens/tool_details_client_view/cubit/tool_detailes_client_view_cubit.dart';
import 'package:unishare/screens/tool_details_client_view/widgets/full_screen_image_view.dart';

class CarouselSliderImages extends StatelessWidget {
  const CarouselSliderImages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselSliderCubit, CarousellSliderState>(
      builder: (context, state) {
        final cubit = context.read<CarouselSliderCubit>();
        final detailsCubit = context.read<ToolDetailesClientViewCubit>();
        final imageUrl = detailsCubit.itemDetailes.additionalImageUrls ?? [];
        return Stack(
          alignment: Alignment.center,
          children: [
            CarouselSlider(
              items: List.generate(
                imageUrl.length,
                (index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                FullScreenImageView(imagePath: imageUrl[index]),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      imageUrl[index],
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: 260,
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
              ),
              carouselController: cubit.carouselSliderController,
              options: CarouselOptions(
                height: 260,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: imageUrl.length > 1,
                scrollPhysics:
                    imageUrl.length > 1
                        ? null
                        : const NeverScrollableScrollPhysics(),

                reverse: false,
                autoPlay: false,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  cubit.onPageChanged(index);
                },
              ),
            ),
            if (cubit.currentIndex > 0)
              Positioned(
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    cubit.carouselSliderController.previousPage();
                  },
                  child: Container(
                    height: 60,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(70, 0, 0, 0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                ),
              ),
            if (cubit.currentIndex < imageUrl.length - 1)
              Positioned(
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    cubit.carouselSliderController.nextPage();
                  },
                  child: Container(
                    height: 60,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(70, 0, 0, 0),
                    ),
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
