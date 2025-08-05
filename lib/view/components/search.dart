//検索に関するComponent
import 'package:flutter/material.dart';

///cosnt
import '../../const/color.dart';

///model
import '../../model/routine/routine_tag.dart';

///api
import '../../api/search/tag_search.dart';

///検索Field
class SearchBarComponents extends StatefulWidget {
  final void Function(TagModel)? onTagSelected;
  final void Function(String keyword)? onSearch;

  const SearchBarComponents({
    super.key,
    required this.onSearch,
    this.onTagSelected,
  });

  @override
  State<SearchBarComponents> createState() => _SearchBarComponentsState();
}

class _SearchBarComponentsState extends State<SearchBarComponents> {
  final TextEditingController _controller = TextEditingController();
  List<TagModel> _searchResults = [];

  void _onSearch() async {
    final query = _controller.text.trim();
    if (query.isEmpty) return;

    widget.onSearch?.call(query);

    final results = await fetchTagSearch(query);
    for (final tag in results) {
      print('🔍 検索候補: ${tag.tagName}');
    }

    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        if (_searchResults.isNotEmpty)
          SearchResult(
            tags: _searchResults,
            onTap: widget.onTagSelected,
          ),
      ],
    );
  }
}

class SearchResult extends StatelessWidget {
  final List<TagModel> tags;
  final void Function(TagModel)? onTap;

  const SearchResult({
    super.key,
    required this.tags,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        children: tags.take(8).map((tag) {
          return Container(
            width: width * 0.85,
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.deepOrange.shade100),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: InkWell(
              onTap: onTap != null ? () => onTap!(tag) : null,
              borderRadius: BorderRadius.circular(12),
              child: Row(
                children: [
                  const Icon(Icons.local_offer_outlined,
                      color: Colors.deepOrange, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      tag.tagName,
                      style: const TextStyle(
                        fontSize: 14.5,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // const Icon(Icons.add, color: Colors.grey, size: 18),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
