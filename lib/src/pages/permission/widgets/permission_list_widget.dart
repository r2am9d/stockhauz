import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:stockhauz/src/themes/app_color.dart';

class PermissionListWidget extends StatelessWidget {
  const PermissionListWidget({super.key});

  static const permissionList = <Map<String, dynamic>>[
    {
      'icon': FontAwesomeIcons.solidDatabase,
      'title': 'Storage',
      'description': '',
    },
    {
      'icon': FontAwesomeIcons.solidPhotoFilmMusic,
      'title': 'Camera & Media',
      'description': '',
    },
    {
      'icon': FontAwesomeIcons.solidBellOn,
      'title': 'Notifications',
      'description': 'Will occasionally send notifications.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.separated(
        itemCount: permissionList.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        separatorBuilder: (BuildContext context, int index) {
          return const _PermissionListItemDivider();
        },
        itemBuilder: (BuildContext context, int index) {
          return _PermissionListItem(item: permissionList[index]);
        },
      ),
    );
  }
}

class _PermissionListItem extends StatelessWidget {
  const _PermissionListItem({required this.item});

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    final tD = Theme.of(context);

    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Icon(
            item['icon'] as IconData,
            size: 28.0,
            color: AppColor().primary,
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                item['title'] as String,
                style: tD.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                item['description'] as String,
                style: tD.textTheme.bodyMedium!.copyWith(
                  color: AppColor().black.withOpacity(.30),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PermissionListItemDivider extends StatelessWidget {
  const _PermissionListItemDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: <Widget>[
          const Expanded(
            flex: 3,
            child: SizedBox(),
          ),
          Expanded(
            flex: 7,
            child: Divider(
              height: 1,
              color: AppColor().black.withOpacity(.05),
            ),
          ),
        ],
      ),
    );
  }
}
