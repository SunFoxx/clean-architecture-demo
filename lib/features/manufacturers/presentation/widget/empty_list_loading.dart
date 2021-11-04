import 'package:flutter/material.dart';

class EmptyListLoading extends StatelessWidget {
  const EmptyListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
