import 'package:equatable/equatable.dart';
import 'package:legy/features/home/model/home_profile_model.dart';
import 'package:legy/features/home/model/nearby_restaurant_model.dart';
import 'package:legy/features/home/model/story_model.dart';

class HomeState extends Equatable {
  final List<NearbyRestaurantModel>? restaurants;
  final List<StoryItemModel>? stories;
  final HomeProfileModel? profile;
  final bool isLoadingProfile;
  final bool isLoadingRestaurants;
  final bool isLoadingStories;
  final String? profileError;
  final String? restaurantsError;
  final String? storiesError;

  const HomeState({
    this.restaurants,
    this.stories,
    this.profile,
    this.isLoadingRestaurants = false,
    this.isLoadingStories = false,
    this.isLoadingProfile = false,
    this.restaurantsError,
    this.storiesError,
    this.profileError,
  });

  HomeState copyWith({
    List<NearbyRestaurantModel>? restaurants,
    List<StoryItemModel>? stories,
    HomeProfileModel? profile,
    bool? isLoadingRestaurants,
    bool? isLoadingStories,
    bool? isLoadingProfile,
    String? restaurantsError,
    String? storiesError,
    String? profileError,
    bool? clearRestaurantsError,
    bool? clearStoriesError,
    bool? clearProfileError,
  }) {
    return HomeState(
      restaurants: restaurants ?? this.restaurants,
      stories: stories ?? this.stories,
      profile: profile ?? this.profile,
      isLoadingRestaurants: isLoadingRestaurants ?? this.isLoadingRestaurants,
      isLoadingStories: isLoadingStories ?? this.isLoadingStories,
      isLoadingProfile: isLoadingProfile ?? this.isLoadingProfile,
      restaurantsError: clearRestaurantsError == true
          ? null
          : restaurantsError ?? this.restaurantsError,
      storiesError:
          clearStoriesError == true ? null : storiesError ?? this.storiesError,
      profileError:
          clearProfileError == true ? null : profileError ?? this.profileError,
    );
  }

  @override
  List<Object?> get props => [
        restaurants,
        stories,
        profile,
        isLoadingRestaurants,
        isLoadingStories,
        isLoadingProfile,
        restaurantsError,
        storiesError,
        profileError,
      ];
}
