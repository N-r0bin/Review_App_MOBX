// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Reviews on ReviewsBase, Store {
  Computed<int>? _$numberOfReviewsComputed;

  @override
  int get numberOfReviews =>
      (_$numberOfReviewsComputed ??= Computed<int>(() => super.numberOfReviews,
              name: 'ReviewsBase.numberOfReviews'))
          .value;

  late final _$reviewsAtom =
      Atom(name: 'ReviewsBase.reviews', context: context);

  @override
  ObservableList<ReviewModel> get reviews {
    _$reviewsAtom.reportRead();
    return super.reviews;
  }

  @override
  set reviews(ObservableList<ReviewModel> value) {
    _$reviewsAtom.reportWrite(value, super.reviews, () {
      super.reviews = value;
    });
  }

  late final _$averageStarsAtom =
      Atom(name: 'ReviewsBase.averageStars', context: context);

  @override
  double get averageStars {
    _$averageStarsAtom.reportRead();
    return super.averageStars;
  }

  @override
  set averageStars(double value) {
    _$averageStarsAtom.reportWrite(value, super.averageStars, () {
      super.averageStars = value;
    });
  }

  late final _$initReviewsAsyncAction =
      AsyncAction('ReviewsBase.initReviews', context: context);

  @override
  Future<void> initReviews() {
    return _$initReviewsAsyncAction.run(() => super.initReviews());
  }

  late final _$ReviewsBaseActionController =
      ActionController(name: 'ReviewsBase', context: context);

  @override
  void addReview(ReviewModel newReview) {
    final _$actionInfo = _$ReviewsBaseActionController.startAction(
        name: 'ReviewsBase.addReview');
    try {
      return super.addReview(newReview);
    } finally {
      _$ReviewsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
reviews: ${reviews},
averageStars: ${averageStars},
numberOfReviews: ${numberOfReviews}
    ''';
  }
}
