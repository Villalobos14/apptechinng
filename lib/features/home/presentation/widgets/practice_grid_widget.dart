import 'package:flutter/material.dart';
import 'practice_card_widget.dart';

class PracticeGridWidget extends StatelessWidget {
  final List<PracticeCardData> practiceList;

  const PracticeGridWidget({
    super.key,
    required this.practiceList,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: PracticeCardWidget(data: practiceList[0]),
                ),
                const SizedBox(height: 16),
                Expanded(
                  flex: 1,
                  child: PracticeCardWidget(data: practiceList[2]),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  child: PracticeCardWidget(data: practiceList[1]),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: PracticeCardWidget(data: practiceList[3]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}