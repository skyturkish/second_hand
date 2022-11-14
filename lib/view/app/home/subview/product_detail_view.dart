import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/build_context/context_extension.dart';
import 'package:second_hand/core/extensions/build_context/loc.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/models/product/product.dart';
import 'package:second_hand/view/_product/_widgets/button/custom_elevated_button.dart';
import 'package:second_hand/view/_product/_widgets/iconbutton/favorite_icon_button.dart';
import 'package:second_hand/view/_product/_widgets/list_tile/user_information_listtile/user_information_listtile.dart';
import 'package:second_hand/view/_product/_widgets/row/location_information_row.dart';
import 'package:second_hand/view/app/home/subview/product_detail_view_model.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ImagesPageView(product: product),
                PageIndicatorAndCount(product: product),
              ],
            ),
            PriceAndFavoriteButtonRow(product: product),
            const Divider(),
            DescriptionText(description: product.description),
            Padding(
              padding: context.paddingOnlyTopSmall,
              child: LocationInformationRow(product: product),
            ),
            const Divider(),
            UserInformationListtile(userId: product.ownerId),
            const Divider(),
            StartTalkingButton(product: product),
          ],
        ),
      ),
    );
  }
}

class ImagesPageView extends StatelessWidget {
  const ImagesPageView({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'image ${product.productId}',
      child: SizedBox(
        height: context.dynamicHeight(0.33),
        width: context.dynamicWidth(0.90),
        child: PageView.builder(
          allowImplicitScrolling: true,
          itemCount: product.imagesUrl.length,
          itemBuilder: (context, index) {
            final productImage = product.imagesUrl[index];
            return Image.network(
              productImage,
              fit: BoxFit.contain,
            );
          },
          onPageChanged: (index) {
            context.read<ProductDetailViewModelNotifier>().setCurrentPageIndex(
                  index: index,
                );
          },
        ),
      ),
    );
  }
}

class PageIndicatorAndCount extends StatelessWidget {
  const PageIndicatorAndCount({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox.shrink(),
        SizedBox(
          height: 15,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: product.imagesUrl.length,
            itemBuilder: (context, index) {
              return CircleImageCount(
                isSelected: context.watch<ProductDetailViewModelNotifier>().currentPageIndex == index,
              );
            },
          ),
        ),
        Text(
          '${context.watch<ProductDetailViewModelNotifier>().currentPageIndex + 1}'
          '/ ${product.imagesUrl.length}',
        )
      ],
    );
  }
}

class PriceAndFavoriteButtonRow extends StatelessWidget {
  const PriceAndFavoriteButtonRow({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingHorizontalSmall + context.paddingOnlyTopSmall,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '${product.price}' ' \$',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colors.onBackground,
                    ),
              ),
              const SizedBox.shrink(),
              FavoriteIconButton(
                product: product,
              ),
            ],
          ),
          Padding(
            padding: context.paddingOnlyTopSmall,
            child: Text(
              product.title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}

class CircleImageCount extends StatelessWidget {
  const CircleImageCount({super.key, required this.isSelected});
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyLeftSmallX,
      child: CircleAvatar(
        radius: isSelected ? 4 : 3,
        backgroundColor: isSelected ? const Color.fromARGB(255, 208, 87, 87) : const Color.fromARGB(255, 105, 91, 91),
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  const DescriptionText({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingHorizontalSmall,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: context.paddingOnlyTopSmall,
              child: Text(
                context.loc.description,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: context.paddingOnlyTopSmall,
              child: Text(
                description,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StartTalkingButton extends StatelessWidget {
  const StartTalkingButton({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        NavigationService.instance.navigateToPage(
          path: NavigationConstants.CHAT_VIEW,
          data: [
            product.productId,
            product.ownerId,
          ],
        );
      },
      child: Text(context.loc.startTalking),
    );
  }
}
