import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FSProductThumbnailTile extends StatelessWidget {
  String sampleUrl =
      "https://thumbs.dreamstime.com/b/environment-earth-day-hands-trees-growing-seedlings-bokeh-green-background-female-hand-holding-tree-nature-field-gra-130247647.jpg";

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Thumbnail
          _buildThumbnail(sampleUrl),
          // Title & Price
          _buildTitleAndPrice(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed',
              140.35),
          // Rating
          _buildRating(3.4),
          // Desc
          _buildDesc('desc')
        ],
      ),
    );
  }

  _buildThumbnail(String networkUrl) {
    return Expanded(
      child: CachedNetworkImage(
        imageUrl: networkUrl,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  _buildTitleAndPrice(String title, double price) {
    return Container(
      height: 60.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
    return Container();
  }
}
