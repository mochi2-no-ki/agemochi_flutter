import 'package:flutter/material.dart';
import '../../const/color.dart';

class ButtonComponents extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const ButtonComponents({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(ColorConst.bt),
        foregroundColor: WidgetStateProperty.all(ColorConst.btft),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

class SwitchComponents extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchComponents({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('リアルタイムルーティーン'),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: ColorConst.sw,
            inactiveThumbColor: ColorConst.swout,
          ),
        ],
      ),
    );
  }
}
