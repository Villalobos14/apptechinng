import 'package:flutter/material.dart';

class PracticeCardData {
  final String titleBig;
  final String? subtitle;
  final String? description;
  final String? counter;
  final Color? counterColor;
  final Color cardColor;
  final Color accentColor;
  final bool isLarge;
  final VoidCallback? onTap;

  PracticeCardData({
    required this.titleBig,
    this.subtitle,
    this.description,
    this.counter,
    this.counterColor,
    required this.cardColor,
    required this.accentColor,
    this.isLarge = false,
    this.onTap,
  });
}

class PracticeCardWidget extends StatelessWidget {
  final PracticeCardData data;

  const PracticeCardWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSmallCard = !data.isLarge;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: data.onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [data.cardColor, data.cardColor.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: data.cardColor.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              _buildBackgroundPattern(),
              Padding(
                // reducimos un poco el bottom-padding para ganar espacio
                padding: EdgeInsets.only(
                  left: isSmallCard ? 16 : 18,
                  top: isSmallCard ? 16 : 18,
                  right: isSmallCard ? 16 : 18,
                  bottom: isSmallCard ? 12 : 18,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (data.subtitle != null) ...[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallCard ? 10 : 12,
                          vertical: isSmallCard ? 4 : 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          data.subtitle!,
                          style: TextStyle(
                            fontSize: isSmallCard ? 9 : 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],

                    // Title sin truncar
                    Text(
                      data.titleBig,
                      style: TextStyle(
                        fontSize: data.isLarge ? 24 : 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.1,
                        letterSpacing: -0.3,
                      ),
                      maxLines: null,
                      overflow: TextOverflow.visible,
                    ),

                    // description o un pequeño spacer
                    if (data.description != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        data.description!,
                        style: TextStyle(
                          fontSize: isSmallCard ? 9 : 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.2,
                        ),
                        maxLines: null,
                        overflow: TextOverflow.visible,
                      ),
                      const SizedBox(height: 8),
                    ] else
                      const SizedBox(height: 6),

                    // bottom row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (data.counter != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallCard ? 8 : 10,
                              vertical: isSmallCard ? 4 : 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              data.counter!,
                              style: TextStyle(
                                fontSize: isSmallCard ? 8 : 9,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        Container(
                          width: isSmallCard ? 28 : 32,
                          height: isSmallCard ? 28 : 32,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '→',
                              style: TextStyle(
                                fontSize: isSmallCard ? 14 : 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundPattern() {
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
                border: Border.all(color: Colors.white.withOpacity(0.2), width: 2),
              ),
            ),
          ),
          Positioned(
            bottom: -15,
            left: -15,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: data.accentColor.withOpacity(0.3),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 15,
            child: Container(
              width: 25,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
          Positioned(
            bottom: 28,
            right: 20,
            child: Container(
              width: 15,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
