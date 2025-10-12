import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/widgets/custom_text.dart';

class HistorySkeleton extends StatelessWidget {
  const HistorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    Color? cardCol = Theme.of(context).cardColor;
    Color? chipCol = Theme.of(context).chipTheme.backgroundColor;
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        padding: EdgeInsets.all(16),
        separatorBuilder: (context, index) => Divider(color: cardCol),
        itemCount: 3,
        itemBuilder: (context, index) => Row(
          spacing: 16,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: chipCol,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8,
                children: [
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: CustomText.normal(
                          'aaaaaaaaaa',
                          isBold: true,
                          context: context,
                        ),
                      ),
                      CustomText.small('aaaaaaaa', context: context),
                    ],
                  ),
                  CustomText.small('aaaaaaaaaaaaaaaaaaaa', context: context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
