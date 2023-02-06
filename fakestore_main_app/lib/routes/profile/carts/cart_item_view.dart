import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';

class CartItemView extends StatelessWidget {
  const CartItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: _buildContent(context),
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context) {
    List<Widget> list = [];
    list.add(_buildBrandSection(context));
    list.add(_buildLineSeperator());
    list.add(_buildProductsInfo(context));
    list.add(_buildAddDealFromShop(context));
    list.add(_buildPromotionInfo(context));
    return list;
  }

  _buildLineSeperator() {
    return Container(
      color: Colors.black12,
      height: 1,
    );
  }

  _buildBrandSection(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        children: [
          // check box
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: CupertinoButton(
              child: Icon(
                Icons.check_box_outlined,
                size: 24,
                color: ColorConstants.colorE30404,
              ),
              onPressed: () {},
              padding: const EdgeInsets.all(0.0),
            ),
          ),
          // is Favorite
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: Container(
              color: ColorConstants.colorE30404,
              height: 15,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  'Favorite',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 8.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          // brand name
          CupertinoButton(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Brand name",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  // arrow
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.arrow_forward_ios_rounded,
                        size: 12, color: Colors.black.withOpacity(0.5)),
                  ),
                ],
              ),
              onPressed: () {}),
          Expanded(
            child: Container(),
          ),
          // Edit
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CupertinoButton(
              onPressed: () {},
              padding: const EdgeInsets.all(0.0),
              child: Text(
                "Edit",
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0,
                    color: Colors.black.withOpacity(0.5),
                    decoration: TextDecoration.none),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildProductsInfo(BuildContext context) {
    return Container(
      child: Column(
        children: [CartSubItemView()],
      ),
    );
  }

  _buildAddDealFromShop(BuildContext context) {
    return Container();
  }

  _buildPromotionInfo(BuildContext context) {
    return Container();
  }
}

class CartSubItemView extends StatelessWidget {
  const CartSubItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // check box
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: CupertinoButton(
            child: Icon(
              Icons.check_box_outlined,
              size: 24,
              color: ColorConstants.colorE30404,
            ),
            onPressed: () {},
            padding: const EdgeInsets.all(0.0),
          ),
        ),
        // Product Images
        CachedNetworkImage(
            height: 100,
            width: 100,
            imageUrl:
                "https://quod.org.uk/wp-content/uploads/2020/05/cropped-iq5jqMnb_400x400.jpg")
        // info
      ],
    );
  }
}
