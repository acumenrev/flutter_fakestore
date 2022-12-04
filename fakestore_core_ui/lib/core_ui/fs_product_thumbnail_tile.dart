import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

class FSProductThumbnailTile extends StatelessWidget {
  late String productImage =
      "https://images.unsplash.com/photo-1669837127740-8234df727cb5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1288&q=80";
  late String title;
  late double price;
  late String productDesc;
  late bool isFavorite;
  late double rating;
  VoidCallback? onTap;

  FSProductThumbnailTile(
      {required this.productImage,
      required this.title,
      required this.price,
      required this.productDesc,
      this.isFavorite = false,
      this.rating = 0.0,
      this.onTap});
  double _kTILE_RATIO_WIDTH_HEIGHT = 308 / 223;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            // Thumbnail
            _buildThumbnail(context, productImage, isFavorite),
            SizedBox(
              height: 10.0,
            ),
            // Title & Price
            _buildTitleAndPrice(title, price),
            SizedBox(height: 5.0),
            // Rating
            _buildRating(rating),
            // Desc
            SizedBox(
              height: 10.0,
            ),
            _buildDesc(productDesc),
            SizedBox(height: 10.0)
          ],
        ),
      ),
    );
  }

  _buildThumbnail(BuildContext ctx, String networkUrl, bool isLiked) {
    double width = MediaQuery.of(ctx).size.width;
    double height = width / _kTILE_RATIO_WIDTH_HEIGHT - 40;
    debugPrint('width: $width \t height: $height');
    return Row(
      children: [
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Stack(
              children: [
                // Image
                CachedNetworkImage(
                  imageUrl: networkUrl,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  progressIndicatorBuilder: (context, url, downloadProgress) {
                    return CircularProgressIndicator(
                        value: downloadProgress.progress);
                  },
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Container(
                  color: Colors.black.withOpacity(0.2),
                  width: width,
                  height: height,
                ),
                // Button Love
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Center(
                      child: FaIcon(
                        isLiked
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        )
      ],
    );
  }

  _buildTitleAndPrice(String title, double price) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20.0,
          ),
          // Title
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Price
          Text(
            _formatCurrency(price),
            textAlign: TextAlign.right,
            style: TextStyle(
                color: Colors.green, fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: 20.0,
          )
        ],
      ),
    );
  }

  _formatCurrency(double value) {
    final currencyFormatter = NumberFormat.currency(
        locale: 'en-us',
        customPattern: '\u00a4#,###',
        symbol: '\$',
        decimalDigits: 2);
    return currencyFormatter.format(value);
  }

  _buildRating(double totalRating) {
    int maxRating = 5;

    return RatingBarIndicator(
      rating: totalRating,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: maxRating,
      itemSize: 50.0,
      direction: Axis.horizontal,
    );
  }

  _buildDesc(String desc) {
    return Row(
      children: [
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
      ],
    );
  }
}
