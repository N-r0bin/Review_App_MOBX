import 'dart:async';
import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:review_app_project/models/review_model.dart';
part 'reviews.g.dart';

class Reviews = ReviewsBase with _$Reviews;
abstract class ReviewsBase with Store {
  @observable
  // list of all user reviews
  ObservableList<ReviewModel> reviews = ObservableList.of([]);

  @observable
  // no. of stars computed as observables from all reviews.
  double averageStars = 0;

  // computed value is used bec changes to its value are dependent on the result of an action (updated observable state)
  @computed
  int get numberOfReviews => reviews.length;
// helper parameter that do not directly update state
  int totalStars = 0;

  @action
  // adds new review to list of reviews
  void addReview(ReviewModel newReview) {
    // update list of reviews
    reviews.add(newReview);

    // update average no. of stars
    averageStars = _calculateAverageStars(newReview.stars);

    // update total no. of stars
    totalStars += newReview.stars;

    // helper parameters that do not directly update state.
    // store reviews using shared Preferences
    _persistReview(reviews);
  }

  @action
  // initialize the list of reviews with existing data from shared preferences as action that update the observable states.
  Future<void> initReviews() async {
    // helper parameters that do not directly update state.
    await _getReviews().then((onValue) {
      // list of all user reviews
      reviews = ObservableList.of(onValue);
      for (ReviewModel review in reviews) {
        totalStars += review.stars;
      }
    });
    averageStars = totalStars / reviews.length;
 }

  double _calculateAverageStars(int newStars) {
    return (newStars + totalStars) / numberOfReviews;
  }

  void _persistReview(List<ReviewModel> updatedReviews) async {
    List<String> reviewsStringList = [];
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    for (ReviewModel review in updatedReviews) {
      Map<String, dynamic> reviewMap = review.toJson();
      String reviewString = jsonEncode(ReviewModel.fromJson(reviewMap));
      reviewsStringList.add(reviewString);
    }
    _preferences.setStringList('userReviews', reviewsStringList);
  }

  Future<List<ReviewModel>> _getReviews() async {
    final SharedPreferences _preferences = await SharedPreferences.getInstance();
    final List<String> reviewsStringList = _preferences.getStringList('userReviews') ?? [];
    final List<ReviewModel> retrievedReviews = [];
    for (String reviewString in reviewsStringList) {
      Map<String, dynamic> reviewMap = jsonDecode(reviewString);
      ReviewModel review = ReviewModel.fromJson(reviewMap);
      retrievedReviews.add(review);
    }
    return retrievedReviews;
  }
}
