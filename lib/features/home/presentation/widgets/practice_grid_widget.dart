// lib/features/home/presentation/widgets/practice_grid_widget.dart
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
    return IntrinsicHeight(
      // IntrinsicHeight mide la altura necesaria de las columnas
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Columna izquierda
          Expanded(
            flex: 1,
            child: Column(
              children: [
                // Tarjeta grande arriba
                Expanded(
                  flex: 2,
                  child: PracticeCardWidget(data: practiceList[0]),
                ),
                const SizedBox(height: 16),
                // Tarjeta pequeña abajo
                Expanded(
                  flex: 1,
                  child: PracticeCardWidget(data: practiceList[2]),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Columna derecha
          Expanded(
            flex: 1,
            child: Column(
              children: [
                // Tarjeta mediana arriba
                Expanded(
                  flex: 1,
                  child: PracticeCardWidget(data: practiceList[1]),
                ),
                const SizedBox(height: 16),
                // Tarjeta mediana abajo
                Expanded(
                  flex: 1,
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
