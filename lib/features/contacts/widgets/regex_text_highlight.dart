import 'package:flutter/material.dart';

class RegexTextHighlight extends StatelessWidget {
  final String text;
  final RegExp highlightRegex;
  final TextStyle highlightStyle;
  final TextStyle? nonHighlightStyle;
  final int maxLines;
  final TextOverflow overflow;

  const RegexTextHighlight({
    super.key,
    required this.text,
    required this.highlightRegex,
    required this.highlightStyle,
    this.nonHighlightStyle,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return Text("",
          style: nonHighlightStyle ?? DefaultTextStyle.of(context).style);
    }

    List<TextSpan> spans = [];
    int start = 0;
    while (true) {
      final String highlight =
          highlightRegex.stringMatch(text.substring(start)) ?? '';
      if (highlight == '') {
        // no highlight
        spans.add(_normalSpan(text.substring(start)));
        break;
      }

      final int indexOfHighlight = text.indexOf(highlight, start);

      if (indexOfHighlight == start) {
        // starts with highlight
        spans.add(_highlightSpan(highlight));
        start += highlight.length;
      } else {
        // normal + highlight
        spans.add(_normalSpan(text.substring(start, indexOfHighlight)));
        spans.add(_highlightSpan(highlight));
        start = indexOfHighlight + highlight.length;
      }
    }

    return RichText(
      overflow: overflow,
      maxLines: maxLines,
      text: TextSpan(
        style: nonHighlightStyle ?? DefaultTextStyle.of(context).style,
        children: spans,
      ),
    );
  }

  TextSpan _highlightSpan(String content) {
    return TextSpan(text: content, style: highlightStyle);
  }

  TextSpan _normalSpan(String content) {
    return TextSpan(text: content);
  }
}
