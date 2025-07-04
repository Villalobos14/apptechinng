// lib/shared/pages/gamification_results_page.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GamificationResultsPage extends StatefulWidget {
  final int initialPoints;
  final int pointsEarned;
  final int currentLevel;
  final int pointsToNextLevel;
  final String skillName;

  const GamificationResultsPage({
    super.key,
    required this.initialPoints,
    required this.pointsEarned,
    required this.currentLevel,
    required this.pointsToNextLevel,
    required this.skillName,
  });

  @override
  State<GamificationResultsPage> createState() => _GamificationResultsPageState();
}

class _GamificationResultsPageState extends State<GamificationResultsPage>
    with TickerProviderStateMixin {
  
  late AnimationController _progressController;
  late AnimationController _pointsController;
  late AnimationController _scaleController;
  
  late Animation<double> _progressAnimation;
  late Animation<int> _pointsAnimation;
  late Animation<double> _scaleAnimation;

  int _currentDisplayPoints = 0;
  int _finalPoints = 0;
  double _initialProgress = 0.0;
  double _finalProgress = 0.0;
  
  int _animationPhase = 0; 

  @override
  void initState() {
    super.initState();
    
    _finalPoints = widget.initialPoints + widget.pointsEarned;
    _currentDisplayPoints = widget.initialPoints;
    
 
    final totalPointsForCurrentLevel = widget.pointsToNextLevel + widget.initialPoints;
    _initialProgress = widget.initialPoints / totalPointsForCurrentLevel;
    _finalProgress = _finalPoints / totalPointsForCurrentLevel;
    
    
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _pointsController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Configurar animaciones
    _progressAnimation = Tween<double>(
      begin: _initialProgress,
      end: _finalProgress,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    _pointsAnimation = IntTween(
      begin: widget.initialPoints,
      end: _finalPoints,
    ).animate(CurvedAnimation(
      parent: _pointsController,
      curve: Curves.easeOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    // Listener para actualizar puntos mostrados
    _pointsAnimation.addListener(() {
      setState(() {
        _currentDisplayPoints = _pointsAnimation.value;
      });
    });

    // Iniciar secuencia de animación
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // Fase 0: Mostrar estado inicial (1 segundo)
    await Future.delayed(const Duration(milliseconds: 1000));
    
    // Fase 1: Mostrar puntos ganados y animar mascota
    setState(() {
      _animationPhase = 1;
    });
    
    _scaleController.forward().then((_) {
      _scaleController.reverse();
    });
    
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Fase 2: Animar progreso y puntos
    setState(() {
      _animationPhase = 2;
    });
    
    _pointsController.forward();
    _progressController.forward();
    
    await Future.delayed(const Duration(milliseconds: 2500));
    
    // Animación de celebración final
    _scaleController.forward().then((_) {
      _scaleController.reverse();
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pointsController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8E8E8), // Rosa claro como en el diseño
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              
              // Mascota Lottie
              AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Lottie.asset(
                        'assets/lottie/fire.json',
                        fit: BoxFit.contain,
                        repeat: true,
                        // Si no tienes el archivo Lottie, usamos un placeholder
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.pets,
                              size: 80,
                              color: Colors.orange,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 40),
              
              // Título
              const Text(
                'Completed a task!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Puntos Display
              _buildPointsDisplay(),
              
              const SizedBox(height: 40),
              
              // Barra de progreso
              _buildProgressBar(),
              
              const SizedBox(height: 20),
              
              // Mensaje de progreso
              if (_animationPhase >= 1)
                Text(
                  'You need ${widget.pointsToNextLevel - (_currentDisplayPoints - (widget.currentLevel * 100))} more points to level up, keep it up!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              
              const Spacer(),
              
              // Botón Finish
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _animationPhase >= 2 ? () {
                    Navigator.of(context).pop();
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A5D3A), // Verde como en el diseño
                    disabledBackgroundColor: const Color(0xFF4A5D3A).withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Finish',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPointsDisplay() {
    return Column(
      children: [
        // Puntos principales
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Puntos actuales/finales
            Text(
              '${_currentDisplayPoints}',
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.w800,
                color: Color(0xFF4A7C3C), // Verde
                height: 1.0,
              ),
            ),
            const Text(
              'pts',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A7C3C),
                height: 1.0,
              ),
            ),
            
            // Mostrar puntos ganados durante fase 1
            if (_animationPhase == 1)
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16),
                child: Text(
                  '+${widget.pointsEarned}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4A7C3C),
                  ),
                ),
              ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        // Descripción de puntos
        Text(
          _getPointsDescription(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  String _getPointsDescription() {
    switch (_animationPhase) {
      case 0:
        return 'My points';
      case 1:
        return 'Points received';
      case 2:
        return 'Your points currently';
      default:
        return 'My points';
    }
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        // Labels de nivel
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Level ${widget.currentLevel}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF666666),
              ),
            ),
            Text(
              'Level ${widget.currentLevel + 1}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF666666),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        // Barra de progreso animada
        AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            return Container(
              width: double.infinity,
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E5E5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _progressAnimation.value.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A7C3C), // Verde
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}