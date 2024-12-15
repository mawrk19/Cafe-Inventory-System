import 'package:flutter/material.dart';

class NumberPad extends StatelessWidget {
  final Function(String) onKeyPressed;
  final VoidCallback onBackspace;

  const NumberPad({
    super.key,
    required this.onKeyPressed,
    required this.onBackspace,
  });

  Widget _buildNumberButton(String number) {
    return Container(
      width: 75,
      height: 75,
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () => onKeyPressed(number),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF0E2C5),
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          number,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Color(0xFF3B2117),
            letterSpacing: 0.32,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNumberButton('1'),
            _buildNumberButton('2'),
            _buildNumberButton('3'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNumberButton('4'),
            _buildNumberButton('5'),
            _buildNumberButton('6'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNumberButton('7'),
            _buildNumberButton('8'),
            _buildNumberButton('9'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 95),
            _buildNumberButton('0'),
            Container(
              width: 75,
              height: 75,
              margin: const EdgeInsets.all(10),
              child: IconButton(
                onPressed: onBackspace,
                icon: const Icon(
                  Icons.backspace,
                  size: 32,
                  color: Color(0xFF3B2117),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}