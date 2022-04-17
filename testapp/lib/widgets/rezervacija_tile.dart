import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class RezervacijaTile extends StatelessWidget {
  final int ind;
  final int length;
  final TimeOfDay pocetak;
  final TimeOfDay kraj;
  const RezervacijaTile(this.ind, this.length, this.pocetak, this.kraj);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TimelineTile(
          axis: TimelineAxis.horizontal,
          alignment: TimelineAlign.center,
          isFirst: ind == 0 ? true : false,
          isLast: false,
          beforeLineStyle: const LineStyle(
            color: Colors.green,
          ),
          afterLineStyle: const LineStyle(
            color: Colors.red,
          ),
          indicatorStyle: const IndicatorStyle(
            width: 20,
            indicator: Icon(Icons.lock_clock),
            padding: EdgeInsets.all(7.0),
          ),
          endChild: SizedBox(
              width: 35,
              child: Center(
                  child: Text(
                      '${pocetak.hour.toString().padLeft(2, '0')}:${pocetak.minute.toString().padLeft(2, '0')}'))),
        ),
        TimelineTile(
          axis: TimelineAxis.horizontal,
          alignment: TimelineAlign.center,
          isFirst: false,
          isLast: (ind + 1) == length ? true : false,
          afterLineStyle:
              (ind + 1) == length ? null : const LineStyle(color: Colors.green),
          beforeLineStyle: const LineStyle(color: Colors.red),
          indicatorStyle: const IndicatorStyle(
            width: 20,
            indicator: Icon(Icons.lock_open_rounded),
            padding: EdgeInsets.all(7.0),
          ),
          endChild: SizedBox(
              width: 35,
              child: Center(
                  child: Text(
                      '${kraj.hour.toString().padLeft(2, '0')}:${kraj.minute.toString().padLeft(2, '0')}'))),
        )
      ],
    );
  }
}
