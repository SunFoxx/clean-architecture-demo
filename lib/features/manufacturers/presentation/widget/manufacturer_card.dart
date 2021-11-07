import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jimmy_test/core/theme/theme.dart';
import 'package:jimmy_test/core/utils/colors.dart';
import 'package:jimmy_test/core/widgets/card.dart';
import 'package:jimmy_test/features/manufacturers/domain/entities/manufacturer.dart';

class ManufacturerCard extends StatelessWidget {
  final Manufacturer manufacturer;
  final VoidCallback? onPressed;

  const ManufacturerCard({
    Key? key,
    required this.manufacturer,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'manufacturer_${manufacturer.id}',
      child: CustomCard(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Transform.rotate(
              angle: -(pi / 180 * 7),
              child: Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: ColorsUtils.generateRandomFromStringSeed(manufacturer.name, 0.2),
                ),
                child: Text(
                  manufacturer.name[0].toUpperCase(),
                  style: AppTheme.typography.mediumLargeDecorative,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(manufacturer.name, style: AppTheme.typography.normal),
                  Text(manufacturer.country, style: AppTheme.typography.weakSmall)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
