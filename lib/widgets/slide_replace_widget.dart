import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SlideReplaceWidget extends ConsumerStatefulWidget {
  const SlideReplaceWidget({
    Key? key,
    required this.child1,
    required this.child2,
    required this.stateProvider,
    this.duration = 1000,
  }) : super(key: key);

  final Widget child1;
  final Widget child2;
  final FutureProvider<bool> stateProvider;
  final int duration;

  @override
  _SlideReplaceWidgetState createState() => _SlideReplaceWidgetState();
}

class _SlideReplaceWidgetState extends ConsumerState<SlideReplaceWidget> with TickerProviderStateMixin {
  late AnimationController _animController1;
  late AnimationController _animController2;
  late CurvedAnimation curve1;
  late CurvedAnimation curve2;
  late Animation<Offset> _animOffsetIn;
  late Animation<Offset> _animOffsetOut;
  bool visible = true;

  @override
  void initState() {
    super.initState();

    _animController1 = AnimationController(
      vsync: this,
      value: 1.0,
      duration: Duration(milliseconds: widget.duration),
    );

    _animController2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    curve1 = CurvedAnimation(parent: _animController1, curve: Curves.fastOutSlowIn);
    curve2 = CurvedAnimation(parent: _animController2, curve: Curves.fastOutSlowIn);

    _animOffsetIn = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(curve1);
    _animOffsetOut = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(curve2);
  }

  @override
  void dispose() {
    _animController1.dispose();
    _animController2.dispose();
    curve1.dispose();
    curve2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(widget.stateProvider, (_, AsyncValue<bool> after) {
      after.whenOrNull(
        data: (val) {
          if (val) {
            _animController1.reverse();
            _animController2.forward();
          } else {
            _animController1.forward();
            _animController2.reverse();
          }

          setState(() {
            visible = !val;
          });
        },
      );
    });

    return AnimatedSwitcher(
      duration: Duration(milliseconds: widget.duration),
      switchInCurve: Curves.fastOutSlowIn,
      switchOutCurve: Curves.fastOutSlowIn,
      child: visible ? widget.child1 : widget.child2,
      transitionBuilder: (Widget child, Animation<double> animation) {
        if (child.key == const ValueKey("child_1")) {
          return ClipRect(
            child: FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: _animOffsetIn,
                child: SizedBox(
                  width: double.infinity,
                  child: child,
                ),
              ),
            ),
          );
        } else {
          return ClipRect(
            child: FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: _animOffsetOut,
                child: SizedBox(
                  width: double.infinity,
                  child: child,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
