import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Product'),
            ElevatedButton(
              onPressed: () {
                context.beamToNamed('/product/view/1');
              },
              child: const Text('Click me'),
            )
          ],
        ),
      ),
    );
  }
}
