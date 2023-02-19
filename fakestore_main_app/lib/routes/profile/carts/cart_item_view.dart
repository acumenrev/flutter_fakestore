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
    list.add(_buildAddPromotion(context));
    list.add(_buildLineSeperator());
    list.add(_buildPromotionDeals(context));
    list.add(_buildLineSeperator(height: 20));
    return list;
  }

  _buildLineSeperator({double height = 1}) {
    return Container(
      color: Colors.black12,
      height: height,
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

  Widget _buildAddPromotion(BuildContext context) {
    return Container(
      height: 50.0,
      child: CupertinoButton(
        padding: const EdgeInsets.all(0.0),
        onPressed: () {},
        child: Row(
          children: [
            SizedBox(
              width: 10.0,
            ),
            // icon
            Icon(
              Icons.ac_unit,
              size: 14.0,
              color: ColorConstants.colorE30404,
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                "Deals",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.black.withOpacity(0.5),
                    decoration: TextDecoration.none),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 14.0,
                color: Colors.black.withOpacity(0.5),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionDeals(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10.0,
        ),
        Icon(
          Icons.delivery_dining,
          size: 20.0,
          color: Colors.black45,
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal),
            ),
          ),
        )
      ],
    );
  }
}

class CartSubItemView extends StatelessWidget {
  const CartSubItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
                    "https://quod.org.uk/wp-content/uploads/2020/05/cropped-iq5jqMnb_400x400.jpg"),
            // info
            _buildProductInfo(context)
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        Container(
          height: 1.0,
          color: Colors.black12,
        ),
      ],
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            Text(
              "Title",
              textAlign: TextAlign.left,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  decoration: TextDecoration.none,
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
            // combobox
            CupertinoButton(
                padding: const EdgeInsets.all(.0),
                child: Container(
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Category: Black",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontSize: 11.0),
                        ),
                        // arrow down
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 20.0,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
                onPressed: () {}),
            // promotion
            SizedBox(
              height: 8.0,
            ),
            // deal
            Row(
              children: [
                // real price
                Text(
                  "600.000d",
                  style: TextStyle(
                    color: Colors.black38,
                    decoration: TextDecoration.lineThrough,
                    decorationStyle: TextDecorationStyle.wavy,
                    decorationColor: Colors.red,
                    fontWeight: FontWeight.w300,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                // discounted price
                Text(
                  "300.000d",
                  style: TextStyle(
                    color: ColorConstants.colorE30404,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            // quantity plus
            Container(
              height: 30.0,
              width: 120.0,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.black12)),
              child: Row(
                children: [
                  CupertinoButton(
                      padding: const EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.remove,
                        size: 14.0,
                        color: Colors.black,
                      ),
                      onPressed: () {}),
                  Container(
                    width: 1.0,
                    color: Colors.black12,
                  ),
                  Expanded(
                      child: Text(
                    "123",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal),
                  )),
                  Container(
                    width: 1.0,
                    color: Colors.black12,
                  ),
                  CupertinoButton(
                      padding: const EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.add,
                        size: 14.0,
                        color: Colors.black,
                      ),
                      onPressed: () {}),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
