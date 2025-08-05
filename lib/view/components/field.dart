import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; //timepicker

//const
import '../../const/color.dart';
import '../../const/dimens.dart';

///テキストField
class TextFieldComponents extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final int maxLines;
  final double fontsize;
  final bool isHashtag;

  const TextFieldComponents({
    super.key,
    this.controller,
    this.hintText,
    this.maxLines = 1,
    this.fontsize = 20,
    this.isHashtag = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: ColorConst.bk,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      style: TextStyle(fontSize: fontsize),
      textAlign: TextAlign.center,
    );
  }
}

///タグField
class TagFieldComponents extends StatefulWidget {
  final String tagname;
  final double fontSize;
  const TagFieldComponents({
    super.key,
    required this.tagname,
    this.fontSize = 15,
  });

  @override
  State<TagFieldComponents> createState() => _TagFieldComponentsState();
}

class _TagFieldComponentsState extends State<TagFieldComponents> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            '#',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.fontSize,
              color: ColorConst.tag,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.tagname,
            style: TextStyle(
              fontSize: widget.fontSize,
            ),
          ),
        ],
      ),
    );
  }
}

///時間ピッカーField
///TODO時間反映させれてない
class TimePickerComponenets extends StatefulWidget {
  final String lavel;
  final IconData icon;

  const TimePickerComponenets({
    super.key,
    required this.lavel,
    required this.icon,
  });

  @override
  State<TimePickerComponenets> createState() => _TimePickerComponenetsState();
}

class _TimePickerComponenetsState extends State<TimePickerComponenets> {
  DateTime selectedTime = DateTime.now();

  void _showCupertinoTimePicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SizedBox(
          height: 250,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: selectedTime,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newTime) {
              setState(() {
                selectedTime = newTime;
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          widget.icon,
          color: ColorConst.icon,
          size: 25,
        ),
        Text(
          widget.lavel,
          style: TextStyle(fontSize: 25),
        ),
        const HorizontalSpacer(ratio: 0.1),
        ElevatedButton(
          onPressed: _showCupertinoTimePicker,
          child: Text(
            '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            elevation: 0,
          ),
        ),
      ],
    ));
  }
}

class GreetingComponent extends StatefulWidget {
  final String greet;
  GreetingComponent({
    super.key,
    required this.greet,
  });

  @override
  State<GreetingComponent> createState() => _GreetingState();
}

class _GreetingState extends State<GreetingComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFD5451B),
          width: 2.0,
        ),
      ),
      color: ColorConst.bk,
      padding: EdgeInsets.all(8.0),
      child: Text(
        widget.greet,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
