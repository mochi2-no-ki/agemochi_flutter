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

class SwitchComponents extends StatefulWidget {
  const SwitchComponents({super.key});

  @override
  State<SwitchComponents> createState() => _SwitchComponentsState();
}

class _SwitchComponentsState extends State<SwitchComponents> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('リアルタイムルーティーン'),
        // Text('リアルタイムルーティーン ${isSwitched ? 'ON' : 'OFF'}'),
        Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
            });
          },
          activeColor: ColorConst.sw,
          inactiveThumbColor: ColorConst.swout,
        ),
      ],
    ));
  }
}
