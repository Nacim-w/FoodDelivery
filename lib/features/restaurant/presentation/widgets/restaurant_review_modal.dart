import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:legy/core/res/styles/colours.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_cubit.dart';
import 'package:legy/features/restaurant/presentation/app/adapter/restaurant_state.dart';

class RestaurantReviewModal extends StatefulWidget {
  final String restaurantId;

  const RestaurantReviewModal({super.key, required this.restaurantId});

  @override
  State<RestaurantReviewModal> createState() => _RestaurantReviewModalState();
}

class _RestaurantReviewModalState extends State<RestaurantReviewModal> {
  double _rating = 3;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantCubit, RestaurantState>(
      listenWhen: (prev, curr) =>
          prev.reviewSubmittedSuccessfully !=
              curr.reviewSubmittedSuccessfully ||
          prev.submitReviewError != curr.submitReviewError,
      listener: (context, state) {
        if (state.reviewSubmittedSuccessfully) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Avis soumis avec succès !"),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        }

        if (state.submitReviewError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.submitReviewError!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Évaluez ce restaurant",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: state.isSubmittingReview
                        ? null
                        : () {
                            context
                                .read<RestaurantCubit>()
                                .submitRestaurantReview(
                                  restaurantId: widget.restaurantId,
                                  rating: _rating.toInt(),
                                  comment: "",
                                );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colours.lightThemeOrange5,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: state.isSubmittingReview
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text("Envoyer"),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
