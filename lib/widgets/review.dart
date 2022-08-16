import 'package:flutter/material.dart';
import 'package:review_app_project/models/review_model.dart';

// Class will display a single review item

class Review_Widget extends StatelessWidget {
  final ReviewModel reviewItem;

  const Review_Widget({Key? key, required this.reviewItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  reviewItem.comment,
                ),
              ),
             Row(
               children: List.filled(reviewItem.stars, null, growable: false).map((listItem) {
                 return Icon(Icons.star, color: Colors.brown[500]);
                }).toList(),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
          thickness: 0.9,
        ),
      ],
    );
  }
}
