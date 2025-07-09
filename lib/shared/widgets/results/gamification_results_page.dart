// lib/shared/pages/gamification_results_page.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GamificationResultsPage extends StatefulWidget {
  final int previousStreak;
  final int newStreak;
  final double weekProgress; // 0.0 to 1.0 para la semana
  final String motivationalMessage;
  final String skillName;

  const GamificationResultsPage({
    super.key,
    required this.previousStreak,
    required this.newStreak,
    required this.weekProgress,
    required this.skillName,
    this.motivationalMessage = "You're on fire! Keep the flame lit every day!",
  });

  @override
  State<GamificationResultsPage> createState() => _GamificationResultsPageState();
}

class _GamificationResultsPageState extends State<GamificationResultsPage>
    with TickerProviderStateMixin {

  // Animation Controllers
  late AnimationController _flameController;
  late AnimationController _numberController;
  late AnimationController _streakTextController;
  late AnimationController _progressController;
  late AnimationController _messageController;
  late AnimationController _buttonController;

  // Animations
  late Animation<double> _flameScaleAnimation;
  late Animation<Offset> _oldNumberSlideAnimation;
  late Animation<Offset> _newNumberSlideAnimation;
  late Animation<double> _numberOpacityAnimation;
  late Animation<double> _streakTextFadeAnimation;
  late Animation<double> _progressBarAnimation;
  late Animation<double> _messageFadeAnimation;
  late Animation<double> _buttonScaleAnimation;

  // State variables
  bool _showOldNumber = true;
  bool _showStreakText = false;
  bool _showProgressBar = false;
  bool _showMessage = false;
  bool _showButton = false;
  bool _isLayoutReady = false; // ← Nueva variable para controlar el layout

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    
    // ✅ Esperar a que el layout esté listo antes de animar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isLayoutReady = true;
        });
        _startAnimationSequence();
      }
    });
  }

  void _setupAnimations() {
    // 1. Flame animation (continua)
    _flameController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _flameScaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _flameController,
      curve: Curves.easeInOut,
    ));

    // 2. Number flip animation - ✅ Duración más larga para mejor efecto
    _numberController = AnimationController(
      duration: const Duration(milliseconds: 1200), // ← Más tiempo para rebote
      vsync: this,
    );

    _oldNumberSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1.2), // ← Slide más lejos para mejor efecto
    ).animate(CurvedAnimation(
      parent: _numberController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeInBack), // ← Back curve para más dinamismo
    ));

    _newNumberSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.2), // ← Start más lejos
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _numberController,
      curve: const Interval(0.3, 0.9, curve: Curves.elasticOut), // ← Rebote elástico!
    ));

    _numberOpacityAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _numberController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    ));

    // 3. Streak text animation
    _streakTextController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _streakTextFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _streakTextController,
      curve: Curves.easeOut,
    ));

    // 4. Progress bar animation
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _progressBarAnimation = Tween<double>(
      begin: 0.0,
      end: widget.weekProgress,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    // 5. Message animation
    _messageController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _messageFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _messageController,
      curve: Curves.easeOut,
    ));

    // 6. Button animation
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _buttonScaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.elasticOut,
    ));
  }

  Future<void> _startAnimationSequence() async {
    // ✅ Delay más largo para asegurar que Lottie esté cargado
    await Future.delayed(const Duration(milliseconds: 800));

    // 1. Comenzar animación de números (flip effect)
    if (mounted) _numberController.forward();
    
    // Cambiar el estado a la mitad de la animación
    await Future.delayed(const Duration(milliseconds: 400));
    if (mounted) {
      setState(() {
        _showOldNumber = false;
      });
    }

    // 2. Mostrar "day streak" text
    await Future.delayed(const Duration(milliseconds: 400));
    if (mounted) {
      setState(() {
        _showStreakText = true;
      });
      _streakTextController.forward();
    }

    // 3. Mostrar progress bar
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        _showProgressBar = true;
      });
      _progressController.forward();
    }


    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() {
        _showMessage = true;
      });
      _messageController.forward();
    }

  
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        _showButton = true;
      });
      _buttonController.forward();
    }
  }

  @override
  void dispose() {
    _flameController.dispose();
    _numberController.dispose();
    _streakTextController.dispose();
    _progressController.dispose();
    _messageController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  Widget _buildFlameIcon() {
    return Center( 
      child: AnimatedBuilder(
        animation: _flameScaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _flameScaleAnimation.value,
            child: SizedBox(
              width: 150,
              height: 150,
              child: _isLayoutReady 
                  ? Lottie.asset(
                      'assets/lottie/fire2.json',
                      fit: BoxFit.contain,
                      repeat: true,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildFallbackFlame();
                      },
                    )
                  : _buildFallbackFlame(), 
            ),
          );
        },
      ),
    );
  }

  Widget _buildFallbackFlame() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFB800), // Amarillo-naranja
            const Color(0xFFFF8C00), // Naranja
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFB800).withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Icon(
        Icons.local_fire_department,
        color: Colors.white,
        size: 75,
      ),
    );
  }

  Widget _buildStreakNumber() {
    return Center(
      child: SizedBox(
        height: 100,
        child: _buildDigitByDigitAnimation(),
      ),
    );
  }

  Widget _buildDigitByDigitAnimation() {
    final previousStr = '${widget.previousStreak}';
    final newStr = '${widget.newStreak}';
    
    // Calcular cuántos dígitos tienen los números
    final maxLength = previousStr.length > newStr.length ? previousStr.length : newStr.length;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(maxLength, (index) {
        // Obtener dígitos desde la derecha (unidades, decenas, etc.)
        final previousDigit = index < previousStr.length 
            ? previousStr[previousStr.length - 1 - index]
            : '';
        final newDigit = index < newStr.length 
            ? newStr[newStr.length - 1 - index] 
            : '';
        
        // ✅ Si los dígitos son iguales, mostrar en GRIS inicialmente, luego naranja
        if (previousDigit == newDigit && previousDigit.isNotEmpty) {
          return AnimatedBuilder(
            animation: _numberController,
            builder: (context, child) {
              // Cambiar color gradualmente durante la animación
              final colorProgress = _numberController.value;
              final currentColor = Color.lerp(
                const Color(0xFFBBBBBB), // Gris inicial
                const Color(0xFFFFB800), // Naranja final
                colorProgress,
              )!;
              
              // Agregar un sutil efecto de escala para dinamismo - asegurar que termine en 1.0
              final scale = colorProgress < 1.0
                  ? 1.0 + (0.05 * colorProgress * (1 - colorProgress) * 4) // Rebote sutil durante animación
                  : 1.0; // Asegurar que termine exactamente en 1.0
              
              return Transform.scale(
                scale: scale,
                child: Text(
                  previousDigit,
                  style: TextStyle(
                    fontSize: 84,
                    fontWeight: FontWeight.w800,
                    color: currentColor,
                    height: 1.0,
                  ),
                ),
              );
            },
          );
        }
        
        // ✅ Si son diferentes, animar con rebote
        return SizedBox(
          width: 50, // Ancho fijo para cada dígito
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Dígito anterior (baja con rebote)
              if (_showOldNumber && previousDigit.isNotEmpty)
                AnimatedBuilder(
                  animation: _oldNumberSlideAnimation,
                  builder: (context, child) {
                    // Agregar rotación sutil para más dinamismo
                    final rotation = (_oldNumberSlideAnimation.value.dy) * 0.1;
                    
                    return Transform.translate(
                      offset: _oldNumberSlideAnimation.value * 100,
                      child: Transform.rotate(
                        angle: rotation,
                        child: Text(
                          previousDigit,
                          style: const TextStyle(
                            fontSize: 84,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFBBBBBB), // Gris para número anterior
                            height: 1.0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              
              // Dígito nuevo (sube con rebote elástico)
              if (!_showOldNumber && newDigit.isNotEmpty)
                AnimatedBuilder(
                  animation: Listenable.merge([
                    _newNumberSlideAnimation,
                    _numberOpacityAnimation,
                  ]),
                  builder: (context, child) {
                    // Calcular escala para efecto de rebote más pronunciado
                    final slideProgress = (_numberController.value - 0.3).clamp(0.0, 1.0) / 0.6; // Mapear y clamp al intervalo del slide
                    
                    // Rebote que termina en 1.0 exactamente
                    final bounceScale = slideProgress < 1.0 
                        ? 1.0 + (0.2 * slideProgress * (1 - slideProgress) * 4) // Rebote durante animación
                        : 1.0; // Asegurar que termine en 1.0
                    
                    // Rotación en dirección opuesta para contrastar
                    final rotation = (_newNumberSlideAnimation.value.dy) * -0.05;
                    
                    return Transform.translate(
                      offset: _newNumberSlideAnimation.value * 100,
                      child: Transform.scale(
                        scale: bounceScale,
                        child: Transform.rotate(
                          angle: rotation,
                          child: Opacity(
                            opacity: _numberOpacityAnimation.value,
                            child: Text(
                              newDigit,
                              style: const TextStyle(
                                fontSize: 84,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFFFB800), // Naranja para número nuevo
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      }).reversed.toList(), // Revertir para mostrar de izquierda a derecha
    );
  }

  Widget _buildStreakText() {
    return Container(
      height: 32, // ✅ Altura fija reservada siempre
      alignment: Alignment.center,
      child: _showStreakText
          ? AnimatedBuilder(
              animation: _streakTextFadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _streakTextFadeAnimation.value,
                  child: const Text(
                    'day streak',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFFFB800), // Mismo color que el número
                      letterSpacing: 0.5,
                    ),
                  ),
                );
              },
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildWeeklyProgress() {
    const weekDays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    
    return Container(
      height: 80, // ✅ Altura fija siempre reservada
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          // Day labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekDays.map((day) {
              return SizedBox(
                width: 32,
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF999999),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 12),
          
          // Barra de progreso continua
          _showProgressBar
              ? AnimatedBuilder(
                  animation: _progressBarAnimation,
                  builder: (context, child) {
                    return Container(
                      width: double.infinity,
                      height: 24, // Altura de la barra
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0), // Fondo gris
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: _progressBarAnimation.value.clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFB800), // Naranja-amarillo
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  width: double.infinity,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildMotivationalMessage() {
    return Container(
      height: 60, // ✅ Altura fija siempre reservada
      padding: const EdgeInsets.symmetric(horizontal: 40),
      alignment: Alignment.center,
      child: _showMessage
          ? AnimatedBuilder(
              animation: _messageFadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _messageFadeAnimation.value,
                  child: Text(
                    widget.motivationalMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                );
              },
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      height: 56, // ✅ Altura fija siempre reservada
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: _showButton
          ? AnimatedBuilder(
              animation: _buttonScaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _buttonScaleAnimation.value,
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4FC3F7), 
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 6,
                      ),
                      child: const Text(
                        'CONTINUE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder( // ✅ Forzar recálculo de layout
        builder: (context, constraints) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Flame Lottie animation
                      _buildFlameIcon(),
                      
                      const SizedBox(height: 24),
                      
                      // Streak number with flip animation
                      _buildStreakNumber(),
                      
                      const SizedBox(height: 8),
                      
                      // "day streak" text
                      _buildStreakText(),
                      
                      const SizedBox(height: 40),
                      
                      // Weekly progress
                      _buildWeeklyProgress(),
                      
                      const SizedBox(height: 24),
                      
                      // Motivational message
                      _buildMotivationalMessage(),
                    ],
                  ),
                ),
                
                // Continue button
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: _buildContinueButton(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Modelo para los datos de gamificación
class GamificationData {
  final int previousStreak;
  final int newStreak;
  final double weekProgress;
  final String motivationalMessage;
  final String skillName;

  const GamificationData({
    required this.previousStreak,
    required this.newStreak,
    required this.weekProgress,
    required this.motivationalMessage,
    required this.skillName,
  });

  factory GamificationData.fromExerciseResult({
    required int currentStreak,
    required bool streakIncreased,
    required double weeklyProgress,
    required String skillName,
  }) {
    final previous = streakIncreased ? currentStreak - 1 : currentStreak;
    final motivationalMessages = [
      "You're on fire! Keep the flame lit every day!",
      "Amazing streak! Don't break the chain!",
      "Consistency is key! Keep going strong!",
      "Your dedication is inspiring! Stay focused!",
      "Building habits, one day at a time!",
    ];
    
    return GamificationData(
      previousStreak: previous,
      newStreak: currentStreak,
      weekProgress: weeklyProgress,
      motivationalMessage: motivationalMessages[currentStreak % motivationalMessages.length],
      skillName: skillName,
    );
  }
}