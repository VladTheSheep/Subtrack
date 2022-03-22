import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowUp extends ConsumerStatefulWidget {
  const ShowUp({
    Key? key,
    required this.child,
    required this.stateProvider,
    this.offset = const Offset(0.0, 0.35),
    this.startInstantly = false,
    this.duration = 1000,
  }) : super(key: key);

  final Widget child;
  final StateProvider<double> stateProvider;
  final Offset offset;
  final bool startInstantly;
  final int duration;

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends ConsumerState<ShowUp> with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    final CurvedAnimation curve = CurvedAnimation(parent: _animController, curve: Curves.fastOutSlowIn);

    _animOffset = Tween<Offset>(begin: widget.offset, end: Offset.zero).animate(curve);

    if (widget.startInstantly) {
      _animController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(widget.stateProvider, (k, v) {
      if (_animController.isCompleted) {
        _animController.reverse();
      } else {
        _animController.forward();
      }
    });

    return FadeTransition(
      opacity: _animController,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}
