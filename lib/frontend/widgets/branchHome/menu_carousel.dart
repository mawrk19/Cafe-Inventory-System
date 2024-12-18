import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class CoffeeCarousel extends StatefulWidget {
  @override
  _CoffeeCarouselState createState() => _CoffeeCarouselState();
}

class _CoffeeCarouselState extends State<CoffeeCarousel> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  final List<Map<String, String>> _items = [
    {"title": "Espresso", "image": "assets/images/vietnamese.png"},
    {"title": "Vietnamese", "image": "assets/images/vietnamese.png"},
    {"title": "Matcha", "image": "assets/images/vietnamese.png"},
    {"title": "Chocolate", "image": "assets/images/vietnamese.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF753D29),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Stack(
        children: [
          Column(
            children: [
              CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 0.4,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                items: _items.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(
                        children: [
                          Container(
                            width: 160,
                            height: 125,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFF4E6),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                item["image"]!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 14),
                          Text(
                            item["title"]!,
                            style: TextStyle(
                              color: Color(0xFFFFF4E6),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
          Positioned(
            top: 70,
            left: 10,
            child: GestureDetector(
              onTap: () => _controller.previousPage(),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFF0E2C5),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '<',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 70,
            right: 10,
            child: GestureDetector(
              onTap: () => _controller.nextPage(),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFF0E2C5),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '>',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
