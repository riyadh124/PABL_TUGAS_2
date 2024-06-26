import 'package:flutter/material.dart';

class AnimatedBalloonWidget extends StatefulWidget {
  const AnimatedBalloonWidget({super.key});

  @override
  State<AnimatedBalloonWidget> createState() => _AnimatedBalloonWidgetState();
}

class _AnimatedBalloonWidgetState extends State<AnimatedBalloonWidget>
    with TickerProviderStateMixin {
  AnimationController? _controllerFloatUp;
  AnimationController? _controllerGrowSize;
  AnimationController? _animationFloatUp;
  AnimationController? _animationGrowSize;

  @override
  void initState() {
    super.initState();

    _controllerFloatUp =
        AnimationController(duration: Duration(seconds: 4), vsync: this);

    _controllerGrowSize =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
  }

  @override
  void dispose() {
    _controllerFloatUp?.dispose();
    _controllerGrowSize?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _balloonHeight = MediaQuery.sizeOf(context).height / 2;
    double _balloonWidth = MediaQuery.sizeOf(context).height / 3;
    double _balloonBottomLocation =
        MediaQuery.sizeOf(context).height - _balloonHeight;

    _animationFloatUp = Tween(begin: _balloonBottomLocation, end: 0.0).animate(
        CurvedAnimation(
            parent: _controllerFloatUp!.view,
            curve: Curves.fastOutSlowIn)) as AnimationController?;

    _animationGrowSize = Tween(begin: 50.0, end: _balloonWidth).animate(
        CurvedAnimation(
            parent: _controllerGrowSize!.view,
            curve: Curves.elasticInOut)) as AnimationController?;

    _controllerFloatUp?.forward();
    _controllerGrowSize?.forward();
    return AnimatedBuilder(
      animation: _animationFloatUp!.view,
      builder: ((context, child) {
        return Container(
          child: child,
          margin: EdgeInsets.only(top: _animationFloatUp!.value),
          width: _animationGrowSize!.value,
        );
      }),
      child: GestureDetector(
        onTap: () {
          if (_controllerFloatUp!.isCompleted) {
            _controllerFloatUp?.reverse();
            _controllerGrowSize?.reverse();
          } else {
            _controllerFloatUp?.forward();
            _controllerGrowSize?.forward();
          }
        },
        child: Image.asset(
          "assets/gambar/balloon.png",
          height: _balloonHeight,
          width: _balloonWidth,
        ),
      ),
    );
  }
}
