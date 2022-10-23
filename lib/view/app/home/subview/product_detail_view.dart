import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/core/constants/navigation/navigation_constants.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/core/init/navigation/navigation_service.dart';
import 'package:second_hand/models/product.dart';
import 'package:second_hand/view/_product/_widgets/button/custom_elevated_button.dart';
import 'package:second_hand/view/_product/_widgets/iconbutton/favorite_icon_button.dart';
import 'package:second_hand/view/_product/_widgets/list_tile/user_information_listtile/user_information_listtile.dart';
import 'package:second_hand/view/app/home/subview/product_detail_view_model.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<ProductDetailViewModelNotifier>().resetPageIndex();
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
                Hero(
                  tag: 'image ${widget.product.productId}',
                  child: SizedBox(
                    height: context.dynamicHeight(0.33),
                    width: context.dynamicWidth(0.90),
                    child: PageView.builder(
                      allowImplicitScrolling: true,
                      itemCount: widget.product.imagesUrl.length,
                      itemBuilder: (context, index) {
                        final productImage = widget.product.imagesUrl[index];
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox.shrink(),
                    SizedBox(
                      height: 15,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.product.imagesUrl.length,
                        itemBuilder: (context, index) {
                          return CircleImageCount(
                            isSelected: context.watch<ProductDetailViewModelNotifier>().currentPageIndex == index,
                          );
                        },
                      ),
                    ),
                    Text(
                      '${context.watch<ProductDetailViewModelNotifier>().currentPageIndex + 1}'
                      '/ ${widget.product.imagesUrl.length}',
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: context.paddingHorizontalSmall + context.paddingOnlyTopSmall,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${widget.product.price}' ' \$',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.colors.onBackground,
                            ),
                      ),
                      const SizedBox.shrink(),
                      FavoriteIconButton(
                        product: widget.product,
                      ),
                    ],
                  ),
                  Padding(
                    padding: context.paddingOnlyTopSmall,
                    child: Text(
                      widget.product.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: context.paddingHorizontalSmall,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: context.paddingOnlyTopSmall,
                      child: Text(
                        'Description',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding: context.paddingOnlyTopSmall,
                      child: Text(
                        widget.product.description,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            UserInformationListtile(userId: widget.product.ownerId),
            const Divider(),
            CustomElevatedButton(
              onPressed: () {
                NavigationService.instance.navigateToPage(
                  path: NavigationConstants.CHAT_VIEW,
                  data: [
                    widget.product.productId,
                    widget.product.ownerId,
                  ],
                );
              },
              child: const Text('start talking'),
            ),
          ],
        ),
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
