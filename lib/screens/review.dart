import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:review_app_project/models/review_model.dart';
import 'package:review_app_project/models/reviews.dart';
import 'package:review_app_project/widgets/info_card.dart';
import 'package:review_app_project/widgets/review.dart';

// User interface

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final Reviews _reviewsStore = Reviews();
  final TextEditingController _commentController = TextEditingController();
  final List<int> _stars = [1, 2, 3, 4, 5];
  int _selectedStar = 1;
  bool _isElevated = false;

  @override
  void initState() {
    _selectedStar = 1;
    _reviewsStore.initReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Share Your Review', style: TextStyle(color: Colors.brown),),
        backgroundColor: Color(0xFFEADEA6),
      ),
      backgroundColor: Color(0xFFEFE9CC),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: screenWidth * 0.6,
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintText: 'write a review',
                  labelText: 'Write a review',
                  labelStyle: TextStyle(color: Colors.brown),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber),
                  ),
                ),
              ),
            ),
            Container(
              child: DropdownButton<int>(
                hint: Text("Stars"),
                elevation: 0,
                value: _selectedStar,
                items: _stars.map((star) {
                  return DropdownMenuItem<int>(
                    child: Text(star.toString()),
                    value: star,
                  );
                }).toList(),
                onChanged: (int? item) {
                  setState(() {
                    _selectedStar = item!.toInt();
                  });
                 //_selectedStar.toInt();
                },
              ),
            ),
          ],
        ),
              SizedBox(height: 10),
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: 40,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: _isElevated? [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      offset: const Offset(4,4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                     BoxShadow(
                      color: Colors.brown[200]!,
                      offset: const Offset(-4,-4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ]: null,
                ),
                child: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(
                        Icons.done,
                        size: 30.0,
                        color: Colors.brown[800],
                      ),
                      onPressed: () {
                        _isElevated = !_isElevated;
                        if (_selectedStar == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("You can't add a review without star"),
                           duration: Duration(milliseconds: 700),
                            ));
                          } else if (_commentController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Review comment cannot be empty"),
                            duration: Duration(milliseconds: 700),
                          ));
                        } else {
                          _reviewsStore.addReview(ReviewModel(
                            comment: _commentController.text,
                            stars: _selectedStar,
                          ));
                        }
                      }
                    );
                  }
                ),
              ),
              SizedBox(height: 12.0),
              // Average stars & total reviews card
              Observer(
                builder: (_) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InfoCard(
                        infoValue: _reviewsStore.numberOfReviews.toString(),
                        infoLabel: "reviews",
                        cardColor: Colors.deepOrangeAccent,
                        iconData: Icons.comment,
                      ),
                      InfoCard(
                        infoValue: _reviewsStore.averageStars.toStringAsFixed(2),
                        infoLabel: "average stars",
                        cardColor: Colors.amber,
                        iconData: Icons.star,
                        key: Key('avgStar'),
                      ),
                    ],
                  );
                }
              ),
              SizedBox(height: 24.0),
              // Review menu label
              Container(
                color: Colors.brown[300],
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.comment),
                    SizedBox(width: 10.0),
                    Text(
                      "Reviews",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              // Review Form display list of existing reviews
              Expanded(
                child: Container(
                    child: Observer(
                    builder: (_) => _reviewsStore.reviews.isNotEmpty? ListView(
                      children: _reviewsStore.reviews.reversed.map((reviewItem){
                        return Review_Widget(
                          reviewItem: reviewItem,
                        );
                      }).toList(),
                    ):Text("No reviews yet"),
                ),
              ),
              ),
        ],
      ),
    ),
    );
  }
}