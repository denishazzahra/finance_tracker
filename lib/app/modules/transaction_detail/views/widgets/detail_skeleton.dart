import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/widgets/custom_text.dart';

class DetailSkeleton extends StatelessWidget {
  const DetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    Color? chipCol = Theme.of(context).chipTheme.backgroundColor;
    return Skeletonizer(
      enabled: true,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Center(
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: chipCol,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
          SizedBox(height: 16),
          CustomText.h2('aaaaaaaaa', context: context, isCenter: true),
          SizedBox(height: 16),
          Divider(color: chipCol),
          SizedBox(height: 8),
          CustomText.normal('aaaaaaaaaa', context: context, isBold: true),
          SizedBox(height: 16),
          detailTemplate(),
          SizedBox(height: 16),
          detailTemplate(),
          SizedBox(height: 16),
          detailTemplate(),
          SizedBox(height: 16),
          detailTemplate(),
          SizedBox(height: 16),
          detailTemplate(),
          SizedBox(height: 16),
          detailTemplate(),
          SizedBox(height: 16),
          detailTemplate(),
          SizedBox(height: 8),
          Divider(color: chipCol),
          SizedBox(height: 8),
          detailTemplate(),
        ],
      ),
    );
  }

  Widget detailTemplate() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Text('aaaaaaaa'), Spacer(), Text('aaaaaaaa')],
    );
  }
}
