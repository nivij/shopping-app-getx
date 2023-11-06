import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class forgotscontainer extends StatelessWidget {
  const forgotscontainer({Key? key,
    required this.Iconn,
    required this.title,
    required this.subtitle, required this.onTap})
      : super(key: key);
  final IconData Iconn;
  final String title, subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Iconn,
                size: 30, color: Theme
                    .of(context)
                    .colorScheme
                    .secondary),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .secondary),
                ),
                Text(
                  subtitle,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .secondary),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}