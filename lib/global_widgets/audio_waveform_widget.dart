import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:petspeak_ai/app/utils/constants/app_colors.dart';

class AudioWaveformWidget extends StatefulWidget {
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final double height;
  final int barCount;
  final Duration animationDuration;

  const AudioWaveformWidget({
    super.key,
    this.isActive = false,
    this.activeColor = AppColors.primary,
    this.inactiveColor = Colors.grey,
    this.height = 50.0,
    this.barCount = 30,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  State<AudioWaveformWidget> createState() => _AudioWaveformWidgetState();
}

class _AudioWaveformWidgetState extends State<AudioWaveformWidget>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _animations;
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationControllers = List.generate(
      widget.barCount,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: widget.animationDuration.inMilliseconds ~/ 2 +
              _random.nextInt(widget.animationDuration.inMilliseconds ~/ 2),
        ),
      ),
    );

    _animations = _animationControllers.map((controller) {
      return Tween<double>(
        begin: 0.1,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    if (widget.isActive) {
      _startAnimations();
    }
  }

  void _startAnimations() {
    for (var i = 0; i < _animationControllers.length; i++) {
      Future.delayed(
        Duration(milliseconds: _random.nextInt(300)),
        () {
          if (mounted) {
            _animationControllers[i].repeat(reverse: true);
          }
        },
      );
    }
  }

  void _stopAnimations() {
    for (var controller in _animationControllers) {
      controller.stop();
      controller.reset();
    }
  }

  @override
  void didUpdateWidget(AudioWaveformWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _startAnimations();
      } else {
        _stopAnimations();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          widget.barCount,
          (index) => AnimatedBuilder(
            animation: _animationControllers[index],
            builder: (context, child) {
              final double barHeight = widget.isActive
                  ? widget.height * 0.3 +
                      (widget.height * 0.7 * _animations[index].value)
                  : widget.height * 0.2;

              return Container(
                width: 4,
                height: barHeight,
                decoration: BoxDecoration(
                  color: widget.isActive
                      ? widget.activeColor
                      : widget.inactiveColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
