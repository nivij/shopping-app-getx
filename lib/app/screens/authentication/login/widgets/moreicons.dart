import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class icons extends StatelessWidget {
  const icons({
    Key? key,
    required this.onTap,
    this.isLoading = false,
    required this.child,
  }) : super(key: key);
  final  child;
  final bool isLoading;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Bounceable(
        onTap: isLoading ? null : onTap,
        child: Container(
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   shape: BoxShape.circle
          // ),
          height: 40,
          child: Center(
            child: isLoading
                ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
            )
                : child,
          ),

        ) );
  }
}

