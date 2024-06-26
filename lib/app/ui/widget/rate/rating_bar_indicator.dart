import 'package:flutter/material.dart';

class RatingBarIndicator extends StatefulWidget {
  const RatingBarIndicator({
    Key? key,
    required this.itemBuilder,
    this.textDirection,
    this.unratedColor,
    this.direction = Axis.horizontal,
    this.itemCount = 5,
    this.itemPadding = EdgeInsets.zero,
    this.itemSize = 20.0,
    this.physics = const NeverScrollableScrollPhysics(),
    this.rating = 0.0,
  }) : super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final TextDirection? textDirection;
  final Color? unratedColor;
  final Axis direction;
  final int itemCount;
  final EdgeInsets itemPadding;
  final double itemSize;
  final ScrollPhysics physics;
  final double rating;

  @override
  State<RatingBarIndicator> createState() => _RatingBarIndicatorState();
}

class _RatingBarIndicatorState extends State<RatingBarIndicator> {
  double _ratingFraction = 0;
  int _ratingNumber = 0;
  bool _isRTL = false;

  @override
  void initState() {
    super.initState();
    _ratingNumber = widget.rating.truncate() + 1;
    _ratingFraction = widget.rating - _ratingNumber + 1;
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = widget.textDirection ?? Directionality.of(context);
    _isRTL = textDirection == TextDirection.rtl;
    _ratingNumber = widget.rating.truncate() + 1;
    _ratingFraction = widget.rating - _ratingNumber + 1;
    return SingleChildScrollView(
      scrollDirection: widget.direction,
      physics: widget.physics,
      child: widget.direction == Axis.horizontal
          ? Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: textDirection,
              children: _children,
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              textDirection: textDirection,
              children: _children,
            ),
    );
  }

  List<Widget> get _children {
    return List.generate(
      widget.itemCount,
      (index) {
        if (widget.textDirection != null) {
          if (widget.textDirection == TextDirection.rtl && Directionality.of(context) != TextDirection.rtl) {
            return Transform(
              transform: Matrix4.identity()..scale(-1.0, 1, 1),
              alignment: Alignment.center,
              transformHitTests: false,
              child: _buildItems(index),
            );
          }
        }
        return _buildItems(index);
      },
    );
  }

  Widget _buildItems(int index) {
    return Padding(
      padding: widget.itemPadding,
      child: SizedBox(
        width: widget.itemSize,
        height: widget.itemSize,
        child: Stack(
          fit: StackFit.expand,
          children: [
            FittedBox(
              child: index + 1 < _ratingNumber
                  ? widget.itemBuilder(context, index)
                  : ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        widget.unratedColor ?? Theme.of(context).disabledColor,
                        BlendMode.srcIn,
                      ),
                      child: widget.itemBuilder(context, index),
                    ),
            ),
            if (index + 1 == _ratingNumber)
              if (_isRTL)
                FittedBox(
                  child: ClipRect(
                    clipper: _IndicatorClipper(
                      ratingFraction: _ratingFraction,
                      rtlMode: _isRTL,
                    ),
                    child: widget.itemBuilder(context, index),
                  ),
                )
              else
                FittedBox(
                  child: ClipRect(
                    clipper: _IndicatorClipper(
                      ratingFraction: _ratingFraction,
                    ),
                    child: widget.itemBuilder(context, index),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class _IndicatorClipper extends CustomClipper<Rect> {
  _IndicatorClipper({
    required this.ratingFraction,
    this.rtlMode = false,
  });

  final double ratingFraction;
  final bool rtlMode;

  @override
  Rect getClip(Size size) {
    return rtlMode
        ? Rect.fromLTRB(
            size.width - size.width * ratingFraction,
            0,
            size.width,
            size.height,
          )
        : Rect.fromLTRB(
            0,
            0,
            size.width * ratingFraction,
            size.height,
          );
  }

  @override
  bool shouldReclip(_IndicatorClipper oldClipper) {
    return ratingFraction != oldClipper.ratingFraction || rtlMode != oldClipper.rtlMode;
  }
}
