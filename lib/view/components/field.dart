import 'package:flutter/material.dart';
import '../../const/color.dart';
import 'package:flutter/cupertino.dart';
import '../../const/dimens.dart';

//テキストField
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

//タグField
class TagFieldComponents extends StatefulWidget {
  final String tagname;
  const TagFieldComponents({
    super.key,
    required this.tagname,
  });

  @override
  State<TagFieldComponents> createState() => _TagFieldComponentsState();
}

class _TagFieldComponentsState extends State<TagFieldComponents> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '#',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: ColorConst.tag,
            ),
          ),
          Text(
            widget.tagname,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}

//検索Field
class SearchBarComponents extends StatefulWidget {
  const SearchBarComponents({super.key});

  @override
  State<SearchBarComponents> createState() => _SearchBarComponentsState();
}

class _SearchBarComponentsState extends State<SearchBarComponents> {
  final TextEditingController _controller = TextEditingController();

  void _onSearch() {
    final query = _controller.text;
    print('検索tag: $query');
    // TODO: 処理追加
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0.5,
                  offset: const Offset(1, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: ' 検索 ',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: _onSearch,
          icon: const Icon(
            Icons.search,
            color: ColorConst.bt,
          ),
        ),
      ],
    );
  }
}

//時間ピッカーField
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
        ),
        Text(widget.lavel),
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
