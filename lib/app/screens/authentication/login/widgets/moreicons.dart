import 'package:flutter/cupertino.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class icons extends StatelessWidget {
  const icons({
    super.key,  required this.onTap, this.child,
  });
  final  child;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Bounceable(
        onTap: onTap,
        child: Container(
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   shape: BoxShape.circle
          // ),
          height: 40,
          child: child,
        ) );
  }
}

