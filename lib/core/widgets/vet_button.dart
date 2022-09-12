import 'package:flutter/material.dart';

class VetButton extends StatelessWidget {
  const VetButton({
    Key? key,
    required this.title,
    this.loading = false,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final bool loading;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(400, 55),
      ),
      child: loading
          ? const CircularProgressIndicator()
          : Text(
              title,
            ),
    );
  }
}
