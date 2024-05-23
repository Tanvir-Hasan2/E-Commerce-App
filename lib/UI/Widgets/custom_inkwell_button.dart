import 'package:flutter/material.dart';

class CustomInkWellButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget icon;
  final double size;
  final Color color;
  final double borderRadius;
  final double elevation;

  const CustomInkWellButton({
    required this.onTap,
    required this.icon,
     this.size=50,
     this.color=Colors.white,
     this.borderRadius=50,
     this.elevation=7,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: Ink(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: elevation,
                offset: Offset(0,3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: icon,
          ),
        ),

      ),
    );
  }
}
