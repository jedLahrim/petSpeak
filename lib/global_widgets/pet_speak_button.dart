import 'package:flutter/material.dart';
import 'package:petspeak_ai/app/utils/constants/app_colors.dart';

class MicrophoneButton extends StatefulWidget {
  final bool isRecording;
  final VoidCallback onTap;
  final String petType; // 'dog' or 'cat'
  final double size;
  final Color? color;
  final Widget? child;

  const MicrophoneButton({
    super.key,
    required this.isRecording,
    required this.onTap,
    this.petType = 'dog',
    this.size = 80.0,
    this.color,
    this.child,
  });

  @override
  State<MicrophoneButton> createState() => _MicrophoneButtonState();
}

class _MicrophoneButtonState extends State<MicrophoneButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    if (widget.isRecording) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(MicrophoneButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRecording != oldWidget.isRecording) {
      if (widget.isRecording) {
        _animationController.repeat(reverse: true);
      } else {
        _animationController.stop();
        _animationController.reset();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = widget.color ??
        (widget.petType == 'dog' ? AppColors.dogMode : AppColors.catMode);

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: widget.isRecording
                ? _scaleAnimation.value * _pulseAnimation.value
                : 1.0,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: buttonColor,
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.solid,
                    color: buttonColor.withOpacity(0.4),
                    blurRadius: widget.isRecording ? 16.0 : 8.0,
                    spreadRadius: widget.isRecording ? 4.0 : 2.0,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Inner circle
                  Container(
                    width: widget.size * 0.85,
                    height: widget.size * 0.85,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: buttonColor.withOpacity(0.8),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.8),
                        width: 2.0,
                      ),
                    ),
                  ),

                  // Paw print or mic icon
                  widget.child ??
                      Icon(
                        widget.isRecording ? Icons.stop : Icons.mic,
                        color: Colors.white,
                        size: widget.size * 0.4,
                      ),

                  // Animated ring when recording
                  if (widget.isRecording)
                    Container(
                      width: widget.size,
                      height: widget.size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.6),
                          width: 2.0,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
