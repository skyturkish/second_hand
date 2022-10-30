import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';
import 'package:second_hand/models/product.dart';

class LocationInformationRow extends StatelessWidget {
  const LocationInformationRow({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_pin),
        Padding(
          padding: context.paddingOnlyLeftSmallX,
          child: Text(
            '${product.locateCity},',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        Padding(
          padding: context.paddingOnlyLeftSmallX,
          child: Text(
            product.locateCountry,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        const SizedBox.shrink()
      ],
    );
  }
}
