import 'package:flutter/material.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Example widget',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
