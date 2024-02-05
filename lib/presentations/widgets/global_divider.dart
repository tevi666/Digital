import 'package:flutter/material.dart';

import '../../utilities/constants/app_colors.dart';

class GlobalDivider extends StatelessWidget {
  const GlobalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 2,
      color: AppColors.listTileTrailing,
    );
  }
}
