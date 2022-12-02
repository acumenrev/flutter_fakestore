import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class FSProductThumbnailTile extends StatelessWidget {
  String sampleUrl =
      "https://thumbs.dreamstime.com/b/environment-earth-day-hands-trees-growing-seedlings-bokeh-green-background-female-hand-holding-tree-nature-field-gra-130247647.jpg";
  double _kTILE_RATIO_WIDTH_HEIGHT = 308 / 223;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.0,
          ),
          // Thumbnail
          _buildThumbnail(context, sampleUrl, false),
          SizedBox(
            height: 10.0,
          ),
          // Title & Price
          _buildTitleAndPrice(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed',
              140.35),
          // Rating
          _buildRating(3.4),
          // Desc
          SizedBox(
            height: 10.0,
          ),
          _buildDesc(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolor')
        ],
      ),
    );
  }

  _buildThumbnail(BuildContext ctx, String networkUrl, bool isLiked) {
    double width = MediaQuery.of(ctx).size.width - 40;
    double height = width / _kTILE_RATIO_WIDTH_HEIGHT - 40;

    return Row(
      children: [
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Stack(
            children: [
              // Image
              CachedNetworkImage(
                imageUrl: networkUrl,
                fit: BoxFit.fill,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
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
        SizedBox(
          width: 20.0,
        )
      ],
    );
  }

  _buildTitleAndPrice(String title, double price) {
    return Container(
      height: 60.0,
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
            ),
          ),

          // Price
          Text(
            _formatCurrency(price),
            textAlign: TextAlign.right,
            style: TextStyle(
                color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w400),
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
    return Container();
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
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
      ],
    );
  }
}
