import 'package:flutter/material.dart';

class RoundedBoxContainer extends StatelessWidget {
  const RoundedBoxContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.fromLTRB(20,15,20,20),
    this.showBorder = false,
    this.color = Colors.white,
    this.borderColor = const Color(0xFFD9D9D9),
    this.shadowColor = const Color(0xFF000000),
    });

    final Widget? child;
    final double? width;
    final double? height;
    final EdgeInsetsGeometry? margin;
    final EdgeInsetsGeometry? padding;
    final Color color;
    final Color borderColor;
    final bool showBorder;
    final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        border: showBorder
            ? Border.all(
                color: borderColor,
              )
            : null,
        borderRadius: const BorderRadius.all(Radius.circular(15)), 
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.2),
            spreadRadius: -1,
            blurRadius: 5,
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: child,

    );
    
  }
}