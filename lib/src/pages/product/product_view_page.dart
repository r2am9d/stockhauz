import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stockhauz/src/utils/log_util.dart';

final productViewProvider =
    ChangeNotifierProvider.autoDispose((ref) => ProductViewNotifier());

class ProductViewNotifier extends ChangeNotifier {
  String _text = '';
  String get text => _text;
  void setText(String text) {
    _text = text;
    notifyListeners();
  }

  late TextEditingController _textCtrl;
  TextEditingController get textCtrl => _textCtrl;
  void setTextCtrl(TextEditingController textCtrl) {
    _textCtrl = textCtrl;
    notifyListeners();
  }
}

class ProductViewPage extends ConsumerWidget {
  const ProductViewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productView = ref.read(productViewProvider);
    productView.setTextCtrl(TextEditingController(text: 'QWEQWEQWE'));

    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductView'),
      ),
      body: const TextChild(),
      bottomNavigationBar: const ButtonChild(),
    );
  }
}

class TextChild extends ConsumerWidget {
  const TextChild({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productView = ref.watch(productViewProvider);

    return TextField(
      controller: productView.textCtrl,
      onChanged: (value) {
        productView.setText(value);
        LogUtil.debug(productView.text);
      },
    );
  }
}

class ButtonChild extends ConsumerWidget {
  const ButtonChild({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productView = ref.watch(productViewProvider);

    return ElevatedButton(
      onPressed: () {},
      child: const Text('Click me!'),
    );
  }
}
