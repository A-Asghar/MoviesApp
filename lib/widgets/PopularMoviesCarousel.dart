import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';


class Carousel extends StatelessWidget {
  const Carousel({Key? key,required this.images}) : super(key: key);
  final List images;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Swiper(
        itemBuilder: (context, index) {
          final image = images[index];
          return Image.asset(
            image,
            fit: BoxFit.fill,
          );
        },
        indicatorLayout: PageIndicatorLayout.COLOR,
        autoplay: true,
        itemCount: images.length,
        pagination: const SwiperPagination(),
        control: const SwiperControl(),
      ),
    );
  }
}
