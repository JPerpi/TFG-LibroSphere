import 'package:flutter/material.dart';
import 'package:biblioteca_app/model/review.dart';
import 'package:biblioteca_app/repository/reviewRepository.dart';

class ReviewProvider with ChangeNotifier {
  final ReviewRepository reviewRepository = ReviewRepository();

  Future<List<Review>> getReviewsForBook(String bookName) async {
    try {
      return await reviewRepository.getReviewsForBook(bookName);
    } catch (e) {
      print('Error al obtener reseñas: $e');
      return [];
    }
  }

  Future<void> addReview(Review review) async {
    try {
      await reviewRepository.addReview(review);
      notifyListeners();
    } catch (e) {
      print('Error al agregar reseña: $e');
    }
  }
}
