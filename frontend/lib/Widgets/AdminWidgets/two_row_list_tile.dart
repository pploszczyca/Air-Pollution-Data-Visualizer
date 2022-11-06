import 'package:flutter/material.dart';

class TwoRowListTile extends StatelessWidget {
  final Widget leading;
  final Widget trailing;

  const TwoRowListTile(
    this.leading,
    this.trailing, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 60,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [leading, trailing],
            ),
            const Divider(
              thickness: 2,
              color: Colors.black12,
            ),
          ],
        ),
      );
}
