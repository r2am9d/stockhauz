import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:stockhauz/src/themes/app_color.dart';
import 'package:stockhauz/src/providers/permission_provider.dart';
import 'package:stockhauz/src/pages/permission/widgets/permission_list_widget.dart';

class PermissionPage extends HookConsumerWidget {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tD = Theme.of(context);
    final mQ = MediaQuery.of(context);
    final permissionStatus = ref.watch(permStatusProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kToolbarHeight + 32.0,
        ),
        width: mQ.size.width,
        decoration: BoxDecoration(
          color: AppColor().dirtyWhite,
        ),
        child: Column(
          children: <Widget>[
            Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Stockhauz',
                    style: tD.textTheme.headlineLarge!.copyWith(
                      fontSize: 28,
                      color: AppColor().primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' needs access!',
                    style: tD.textTheme.headlineMedium!.copyWith(
                      fontSize: 24,
                      color: AppColor().black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: mQ.size.height * .10),
            const PermissionListWidget()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          color: AppColor().dirtyWhite,
        ),
        child: ElevatedButton(
          onPressed: () async {
            await ref.read(permStatusProvider.notifier).requestPermission();
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColor().dirtyWhite,
            backgroundColor: AppColor().primary,
            padding: const EdgeInsets.all(24.0),
          ),
          child: const Text('Allow Access'),
        ),
      ),
    );
  }
}
