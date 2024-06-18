import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SegmentedSlidingCard extends StatefulWidget {
  final List<Widget> children;
  final Function(int?) onValueChanged;
  const SegmentedSlidingCard({
    super.key,
    required this.children,
    required this.onValueChanged,
  });

  @override
  createState() => _SegmentedSlidingCardState();
}

class _SegmentedSlidingCardState extends State<SegmentedSlidingCard> {
  int? groupValue = 0;

  @override
  Widget build(BuildContext context) => Material(
        elevation: 5,
        borderRadius: context.radius.all.medium,
        child: ClipRect(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: context.radius.all.medium,
            ),
            child: CupertinoSlidingSegmentedControl<int>(
              backgroundColor: Colors.transparent,
              thumbColor: Colors.white,
              groupValue: groupValue,
              padding: EdgeInsets.zero,
              children: widget.children.asMap(),
              onValueChanged: (value) {
                if (groupValue != value) {
                  widget.onValueChanged(value);
                }
                setState(() {
                  groupValue = value;
                });
              },
            ),
          ),
        ),
      );
}
