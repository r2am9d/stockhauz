import 'package:flutter/material.dart';

class ProductViewPage extends StatelessWidget {
  const ProductViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductView'),
      ),
      body: const Center(
        child: Text('ProductView'),
      ),
    );
  }
}
