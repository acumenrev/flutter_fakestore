import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakestore_main_app/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // section 1 -- Brannd name & Detail order
            _buildSectionDetailOrder(context),
            // section 3 -- order items count & money
            _buildSectionOrderItems(context),
            // section 4 -- order status
            _buildSectionOrderStatus(context),
            // section 5 -- Ask to review,
            _buildSectionOrderAskToReview(context)
          ],
        ),
      ),
    );
  }

  Widget _buildSectionDetailOrder(BuildContext context) {
    return Container(
      height: 130,
      child: Column(
        children: [
          Container(
            height: 30,
            child: Row(
              children: [
                // is favorite
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none,
                          color: Colors.black),
                    ),
                  ),
                ),
                // order status
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text("Completed",
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          color: ColorConstants.colorE30404)),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  // images
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black12, width: 1)),
                      child: CachedNetworkImage(
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        imageUrl: 'https://picsum.photos/250?image=9',
                        fit: BoxFit.contain,
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                  // info
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Column(
                      children: [
                        // product name
                        Text(
                          "The cached_network_image package allows you to use any widget as a placeholder. In this example, display a spinner while the image loads.",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              decoration: TextDecoration.none,
                              color: Colors.black),
                        ),
                        Container(
                          height: 40.0,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "example, we specify a different border for each side of a box (top, right, bottom, and left) by using the BorderSid",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                      decoration: TextDecoration.none,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                              ),
                              Text(
                                "x1",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    decoration: TextDecoration.none,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 40,
                                child: Text(
                                  "100.000d",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                      decoration: TextDecoration.none,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 1.0,
            color: Colors.black12,
          )
        ],
      ),
    );
  }

  _buildSectionOrderItems(BuildContext context) {
    return Container(
      height: 50,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // product counts
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Text(
                      "1 item",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black.withOpacity(0.8),
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
                // total money
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: RichText(
                      maxLines: 1,
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Total: ',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 13.0,
                                color: Colors.black)),
                        TextSpan(
                            text: '100.000d',
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: ColorConstants.colorE30404))
                      ]),
                    ))
              ],
            ),
          ),
          Container(
            height: 1.0,
            color: Colors.black12,
          )
        ],
      ),
    );
  }

  _buildSectionOrderStatus(BuildContext ctx) {
    return Container(
      height: 50.0,
      child: Column(
        children: [
          CupertinoButton(
            onPressed: () {},
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Icon(
                      Icons.local_shipping_outlined,
                      size: 20,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Your order was shipped",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20.0,
                    color: Colors.black.withOpacity(0.4),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 1.0,
            color: Colors.black12,
          )
        ],
      ),
    );
  }

  _buildSectionOrderAskToReview(BuildContext context) {
    return Container(
      height: 65,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text:
                              'Please share your review before Jan 23th, 2023 \n',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13.0,
                              color: Colors.black)),
                      TextSpan(
                          text: 'Review now and get 200 points',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              color: ColorConstants.colorE30404))
                    ]),
                  ),
                ),
                // Button
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: ColorConstants.colorE30404),
                    child: CupertinoButton(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20.0, top: 10, bottom: 10.0),
                      onPressed: () {},
                      child: Text(
                        "Review",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 15.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              height: 1.0,
              color: Colors.black12,
            ),
          )
        ],
      ),
    );
  }
}
