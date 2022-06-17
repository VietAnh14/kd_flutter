import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.label,
    this.isEnable = false,
    this.onTap
  }) : super(key: key);

  final String label;
  final bool isEnable;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isEnable ? onTap : null,
      style: TextButton.styleFrom(
        minimumSize: Size(double.infinity, 60),
        primary: isEnable ? Colors.blue : Colors.grey,
        backgroundColor: isEnable ? Colors.blue : Colors.grey,
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
