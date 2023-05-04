import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'package:stockhauz/src/router/app_router.dart';
import 'package:stockhauz/src/pages/product/product_page.dart';
import 'package:stockhauz/src/pages/product/product_view_page.dart';

class ProductLocation extends BeamLocation<BeamState> {
  ProductLocation(super.routeInformation);

  @override
  List<String> get pathPatterns {
    return [
      AppRouter.productRoute,
      AppRouter.productViewRoute,
    ];
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('product'),
        title: 'Product',
        child: ProductPage(),
        type: BeamPageType.noTransition,
      ),
      if (state.pathPatternSegments.contains('view') &&
          state.pathParameters.containsKey('id')) ...[
        const BeamPage(
          key: ValueKey('product-view'),
          title: 'Product View',
          child: ProductViewPage(),
          type: BeamPageType.slideRightTransition,
        )
      ],
    ];
  }
}
