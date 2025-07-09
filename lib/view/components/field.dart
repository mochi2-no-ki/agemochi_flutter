import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; //timepicker

//const
import '../../const/color.dart';
import '../../const/dimens.dart';

///model
import '../../model/routine/routine_tag.dart'; //検索

///api
import '../../api/search/tag_search.dart'; //検索

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
    this.fontSize = 20,
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

///検索Field
class SearchBarComponents extends StatefulWidget {
  const SearchBarComponents({super.key});

  @override
  State<SearchBarComponents> createState() => _SearchBarComponentsState();
}

class _SearchBarComponentsState extends State<SearchBarComponents> {
  final TextEditingController _controller = TextEditingController();
  List<TagModel> _searchResults = [];

  void _onSearch() async {
    final query = _controller.text.trim();
    if (query.isEmpty) return;

    final results = await fetchTagSearch(query);
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 検索バー
        Row(
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
                  onSubmitted: (_) => _onSearch(),
                  decoration: const InputDecoration(
                    hintText: ' 検索 ',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _onSearch,
              icon: const Icon(Icons.search, color: ColorConst.bt),
            ),
          ],
        ),

        // 検索結果候補
        if (_searchResults.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(1, 2),
                  blurRadius: 4,
                )
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final tag = _searchResults[index];
                return ListTile(
                  title: Text(tag.tagName),
                  onTap: () {
                    print('選択されたタグ: ${tag.tagName}');
                    // 必要に応じて _controller.text = tag.tagName;
                  },
                );
              },
            ),
          ),
      ],
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
