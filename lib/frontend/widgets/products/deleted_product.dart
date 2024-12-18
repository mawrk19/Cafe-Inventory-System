import 'package:flutter/material.dart';

class DeletedProduct extends StatefulWidget {
  const DeletedProduct({super.key});

  @override
  _DeletedProductState createState() => _DeletedProductState();
}

class _DeletedProductState extends State<DeletedProduct> {
  final List<bool> _selected = List.generate(4, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(4, (index) {
        return Container(
          width: double.infinity, // Take the full available width
          margin: const EdgeInsets.only(top: 11),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF0E2C5),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://cdn.builder.io/api/v1/image/assets/TEMP/fefb0bdea6cf2a11d65740953b154f8897caf5681005915fea951d052cef28f1',
                          width: 81,
                          height: 81,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 24, right: 20),//ons slightly lower
                        child: Row(
                          children: [
                            _buildButton('Add again'),
                            const SizedBox(width: 10),
                            _buildButton('Remove'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Vietnamese Beans',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.12,
                    ),
                  ),
                ],
              ),
              Positioned(
                top: -8,//ve higher
                right: -7,// Move more to the right
                child: Checkbox(
                  value: _selected[index],
                  onChanged: (bool? value) {
                    setState(() {
                      _selected[index] = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Helper method for building buttons
  Widget _buildButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF3B2117),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFFFF4E6),
          fontWeight: FontWeight.w500,
          letterSpacing: 0.12,
        ),
      ),
    );
  }
}