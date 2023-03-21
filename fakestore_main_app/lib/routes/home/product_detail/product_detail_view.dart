import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakestore_main_app/routes/home/product_detail/product_detail_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../app_utils.dart';
import '../../../constants/color_constants.dart';

class ProductDetailView extends StatelessWidget {
  ProductDetailView({super.key, required this.controller});

  late ProductDetailControllerInterface controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: _buildContentView(context)),
    ));
  }

  Widget _buildBackgroundImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: controller.product.image,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.contain,
      alignment: Alignment.center,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return CircularProgressIndicator(value: downloadProgress.progress);
      },
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  List<Widget> _buildContentView(BuildContext context) {
    List<Widget> list = List.empty(growable: true);
    list.add(_buildBackgroundImage(context));
    list.add(Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black.withOpacity(0.01)));
    list.add(_buildBottomDetailSheet(context));
    list.add(_buildButtonClose(context));
    return list;
  }

  Widget _buildButtonClose(BuildContext context) {
    return Align(
      child: IconButton(
        icon: Icon(
          Icons.close,
          size: 30,
          color: Colors.black,
        ),
        onPressed: () {
          _dismissView(context);
        },
      ),
      alignment: Alignment.topRight,
    );
  }

  List<String> animalNames = ['Elephant', 'Tiger', 'Kangaroo'];
  List<String> animalFamily = ['Elephantidae', 'Panthera', 'Macropodidae'];
  List<String> animalLifeSpan = ['60-70', '8-10', '15-20'];
  List<String> animalWeight = ['2700-6000', '90-310', '47-66'];
  int selectedTile = 0;

  _dismissView(BuildContext context) {
    context.pop();
  }
}

extension BottomDetailSheet on ProductDetailView {
  Widget _buildBottomDetailSheet(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .2,
      minChildSize: .2,
      maxChildSize: .3,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: Colors.lightGreen[100]),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            controller: scrollController,
            children: [
              _buildTopDragger(context),
              _buildProductName(context),
              _buildProductPriceAndRating(context),
              _buildLikeAndAddToCartButton(context)
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopDragger(BuildContext context) {
    return Container(
      height: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 5,
            color: Colors.black26,
          )
        ],
      ),
    );
  }

  Widget _buildProductName(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Text(
        controller.product.title,
        maxLines: 3,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildProductPriceAndRating(BuildContext context) {
    int maxRating = 5;
    double totalRating = controller.product.rating?.rate ?? 0.0;
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      height: 60.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // rating
          RatingBarIndicator(
            rating: totalRating,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: maxRating,
            itemSize: 30.0,
            direction: Axis.horizontal,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            '( ${totalRating.toString()} )',
            style: TextStyle(
                color: ColorConstants.colorE30404,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none),
          ),
          // price
          Expanded(child: Container()),
          Text(
            AppUtils.formatCurrency(controller.product.price),
            textAlign: TextAlign.right,
            style: const TextStyle(
                color: Colors.green, fontSize: 18, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  Widget _buildLikeAndAddToCartButton(BuildContext context) {
    debugPrint("liked: ${controller.product.isFavorite ? "true" : "false"}");

    return Container(
      height: 90,
      child: Row(
        children: [
          // like button
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: CupertinoButton(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.black12),
                  child: Icon(
                    controller.product.isFavorite
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    size: 30,
                    color: Colors.black26,
                  ),
                ),
                onPressed: () {}),
          ),
          // add to cart button
          Expanded(
              child: CupertinoButton(
            padding: const EdgeInsets.all(0.0),
            onPressed: () {},
            child: Container(
              height: 50.0,
              child: Center(
                child: Text(
                  "Add to cart",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: ColorConstants.colorE30404),
            ),
          )),
          SizedBox(
            width: 15.0,
          )
        ],
      ),
    );
  }
}
