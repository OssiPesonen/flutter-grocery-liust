import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final List<Widget> children;
  final double width;
  final double height;
  final double borderRadius = 8;

  const CustomDialog({super.key, required this.children, this.width = 340, this.height = 210});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.05), blurRadius: 16),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              width: width,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, children: children),
            ),
          ],
        ),
      ),
    );
  }
}
