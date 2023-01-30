import 'dart:developer';

import 'package:contactos_app/contacts/models/contact_listItem_model.dart';
import 'package:contactos_app/contacts/utils/contacts_utils.dart';
import 'package:flutter/material.dart';

class DraggableScrollbar extends StatefulWidget {
  final double heightScrollThumb;
  final Widget child;
  final Widget? labelBubble;
  final ScrollController controller;
  final List<ContactListItemModel> contactsModels;

  const DraggableScrollbar(
      {super.key,
      required this.heightScrollThumb,
      required this.child,
      required this.controller,
      this.labelBubble,
      required this.contactsModels});

  @override
  DraggableScrollbarState createState() => DraggableScrollbarState();
}

class DraggableScrollbarState extends State<DraggableScrollbar> {
  //this counts offset for scroll thumb in Vertical axis
  late double _barOffset;
  //this counts offset for list in Vertical axis
  late double _viewOffset;
  //variable to track when scrollbar is dragged
  late bool _isDragInProcess;

  late String _letter;

  @override
  void initState() {
    super.initState();
    _barOffset = 0.0;
    _viewOffset = 0.0;
    _isDragInProcess = false;
    _letter = '';
  }

  //if list takes 300.0 pixels of height on screen and scrollthumb height is 40.0
  //then max bar offset is 260.0
  double get barMaxScrollExtent =>
      context.size!.height - widget.heightScrollThumb;
  double get barMinScrollExtent => 0.0;

  //this is usually lenght (in pixels) of list
  //if list has 1000 items of 100.0 pixels each, maxScrollExtent is 100,000.0 pixels
  double get viewMaxScrollExtent => widget.controller.position.maxScrollExtent;
  //this is usually 0.0
  double get viewMinScrollExtent => widget.controller.position.minScrollExtent;

  double getScrollViewDelta(
    double barDelta,
    double barMaxScrollExtent,
    double viewMaxScrollExtent,
  ) {
    //propotion
    return barDelta * viewMaxScrollExtent / barMaxScrollExtent;
  }

  double getBarDelta(
    double scrollViewDelta,
    double barMaxScrollExtent,
    double viewMaxScrollExtent,
  ) {
    //propotion
    return scrollViewDelta * barMaxScrollExtent / viewMaxScrollExtent;
  }

  void _onVerticalDragStart(DragStartDetails details) {
    setState(() {
      _isDragInProcess = true;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      _isDragInProcess = false;
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _barOffset += details.delta.dy;

      if (_barOffset < barMinScrollExtent) {
        _barOffset = barMinScrollExtent;
      }
      if (_barOffset > barMaxScrollExtent) {
        _barOffset = barMaxScrollExtent;
      }

      double viewDelta = getScrollViewDelta(
          details.delta.dy, barMaxScrollExtent, viewMaxScrollExtent);

      _viewOffset = widget.controller.position.pixels + viewDelta;
      if (_viewOffset < widget.controller.position.minScrollExtent) {
        _viewOffset = widget.controller.position.minScrollExtent;
      }
      if (_viewOffset > viewMaxScrollExtent) {
        _viewOffset = viewMaxScrollExtent;
      }

      widget.controller.jumpTo(_viewOffset);
      getLetter(_viewOffset);
    });
  }

  void getLetter(double viewOffset) {
    double headerHeight = 20.0;
    List<ContactListScrollModel> scrollModels =
        ContactsUtils.getScrollModelContacts(
            widget.contactsModels,
            headerHeight,
            viewMaxScrollExtent,
            ContactsUtils.getContactsHeight(
                widget.contactsModels, viewMaxScrollExtent - headerHeight));

    String currentLetter =
        ContactsUtils.getScrollbarLetter(scrollModels, viewOffset);
    setState(() {
      _letter = currentLetter;
    });
  }

  void changePosition(ScrollNotification notification) {
    if (_isDragInProcess) {
      return;
    }

    setState(() {
      if (notification is ScrollUpdateNotification) {
        _barOffset += getBarDelta(
          notification.scrollDelta!,
          barMaxScrollExtent,
          viewMaxScrollExtent,
        );

        if (_barOffset < barMinScrollExtent) {
          _barOffset = barMinScrollExtent;
        }
        if (_barOffset > barMaxScrollExtent) {
          _barOffset = barMaxScrollExtent;
        }

        _viewOffset += notification.scrollDelta!;
        if (_viewOffset < widget.controller.position.minScrollExtent) {
          _viewOffset = widget.controller.position.minScrollExtent;
        }
        if (_viewOffset > viewMaxScrollExtent) {
          _viewOffset = viewMaxScrollExtent;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        changePosition(notification);
        return true;
      },
      child: Stack(children: <Widget>[
        widget.child,
        const _TrackPathScrollbar(),
        GestureDetector(
            onVerticalDragStart: _onVerticalDragStart,
            onVerticalDragUpdate: _onVerticalDragUpdate,
            onVerticalDragEnd: _onVerticalDragEnd,
            child: Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: _barOffset),
                child: CustomScrollbarBubble(
                  letter: _letter,
                  heightScrollThumb: widget.heightScrollThumb,
                  dragInProcess: _isDragInProcess,
                ))),
      ]),
    );
  }
}

class CustomScrollbarBubble extends StatelessWidget {
  final String letter;
  final double heightScrollThumb;
  final bool dragInProcess;
  const CustomScrollbarBubble(
      {required this.heightScrollThumb,
      this.dragInProcess = false,
      this.letter = '',
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightScrollThumb,
      width: 100.0,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          dragInProcess && letter.isNotEmpty
              ? _BubblePopupLetter(
                  letter: letter,
                )
              : const SizedBox(),
          Container(
            width: 8,
            color: dragInProcess ? Colors.blue : Colors.black45,
          ),
        ],
      ),
    );
  }
}

class _BubblePopupLetter extends StatelessWidget {
  final String letter;
  const _BubblePopupLetter({
    Key? key,
    required this.letter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 21.0),
        child: Stack(children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: CustomPaint(
              painter: _TrianglePainter(
                strokeColor: Colors.blue,
                strokeWidth: 10,
                paintingStyle: PaintingStyle.fill,
              ),
              child: const SizedBox(
                height: 75,
                width: 70,
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.blue,
            maxRadius: 40,
            child: Text(
              letter,
              style: const TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }
}

class _TrackPathScrollbar extends StatelessWidget {
  const _TrackPathScrollbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topRight,
        margin: const EdgeInsets.only(top: 0),
        child: Container(
          width: 8,
          color: Colors.black12,
        ));
  }
}

class _TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  _TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(x, y)
      ..lineTo(x / 2, y)
      ..lineTo(x, y / 2);
  }

  @override
  bool shouldRepaint(_TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
