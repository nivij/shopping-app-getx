import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class TimelineDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Timeline.tileBuilder(
            builder: TimelineTileBuilder.fromStyle(
              itemCount: 8,
              contentsAlign: ContentsAlign.alternating,
              contentsBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Timeline {index + 1}'),
              ),
            ),
          ),
        ),
        );

  }
}