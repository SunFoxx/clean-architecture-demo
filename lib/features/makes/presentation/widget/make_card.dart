import 'package:flutter/material.dart';
import 'package:jimmy_test/core/theme/theme.dart';
import 'package:jimmy_test/core/utils/colors.dart';
import 'package:jimmy_test/core/widgets/card.dart';
import 'package:jimmy_test/features/makes/domain/entities/make.dart';

class MakeCard extends StatelessWidget {
  final Make make;

  const MakeCard({Key? key, required this.make}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backgroundColor: ColorsUtils.generateRandomFromStringSeed(make.name, 0.1),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          make.name,
          textAlign: TextAlign.center,
          style: AppTheme.typography.semibold,
        ),
      ),
    );
  }
}
