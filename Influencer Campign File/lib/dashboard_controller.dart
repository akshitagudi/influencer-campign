import 'package:get/get.dart';

class Campaign {
  final String title;
  final String description;
  final String platform;
  final String startDate;
  final String endDate;
  final String engagement;
  bool isManuallyCompleted;

  Campaign({
    required this.title,
    required this.description,
    required this.platform,
    required this.startDate,
    required this.endDate,
    required this.engagement,
    this.isManuallyCompleted = false,
  });
}

class DashboardController extends GetxController {
  var campaigns = <Campaign>[
    Campaign(
      title: 'Summer Fashion Promo',
      description: 'Promoting summer outfits.',
      platform: 'Instagram',
      startDate: '01-04-2025',
      endDate: '30-04-2025',
      engagement: '1200 likes',
    ),
    Campaign(
      title: 'Gadget Giveaway',
      description: 'Promoting new gadget launch.',
      platform: 'YouTube',
      startDate: '15-03-2025',
      endDate: '15-04-2025',
      engagement: '5000 views',
    ),
    Campaign(
      title: 'Monsoon Skincare Launch',
      description: 'Showcasing skincare products for the monsoon.',
      platform: 'Instagram',
      startDate: '10-06-2025',
      endDate: '25-06-2025',
      engagement: '2300 likes',
    ),
    Campaign(
      title: 'Back to School Deals',
      description: 'Promoting school supplies and backpacks.',
      platform: 'Facebook',
      startDate: '01-07-2025',
      endDate: '10-07-2025',
      engagement: '1500 shares',
    ),
    Campaign(
      title: 'Diwali Dhamaka Sale',
      description: 'Promoting Diwali discounts on electronics.',
      platform: 'YouTube',
      startDate: '01-10-2025',
      endDate: '20-10-2025',
      engagement: '8000 views',
    ),
    Campaign(
      title: 'Fitness Challenge',
      description: '30-day fitness challenge for influencers.',
      platform: 'Instagram',
      startDate: '01-05-2025',
      endDate: '31-05-2025',
      engagement: '3200 likes',
    ),
    Campaign(
      title: 'Winter Wear Promo',
      description: 'Promoting cozy winter fashion.',
      platform: 'Pinterest',
      startDate: '01-11-2025',
      endDate: '30-11-2025',
      engagement: '1100 pins',
    ),
    Campaign(
      title: 'Raksha Bandhan Gifts',
      description: 'Advertising gifts for Raksha Bandhan.',
      platform: 'Facebook',
      startDate: '10-08-2025',
      endDate: '20-08-2025',
      engagement: '2500 reactions',
    ),
    Campaign(
      title: 'Tech Talk Tuesdays',
      description: 'Weekly tech updates and discussions.',
      platform: 'LinkedIn',
      startDate: '07-01-2025',
      endDate: '25-03-2025',
      engagement: '3200 impressions',
    ),
    Campaign(
      title: 'Organic Food Drive',
      description: 'Awareness campaign on organic food.',
      platform: 'Twitter',
      startDate: '15-04-2025',
      endDate: '30-04-2025',
      engagement: '700 retweets',
    ),
  ].obs;

  var searchText = ''.obs;

  List<Campaign> get ongoingCampaigns => campaigns
      .where((c) =>
          !c.isManuallyCompleted &&
          c.title.toLowerCase().contains(searchText.value.toLowerCase()))
      .toList();

  List<Campaign> get completedCampaigns => campaigns
      .where((c) =>
          c.isManuallyCompleted &&
          c.title.toLowerCase().contains(searchText.value.toLowerCase()))
      .toList();

  void markAsCompleted(Campaign campaign) {
    campaign.isManuallyCompleted = true;
    campaigns.refresh();
  }

  void updateSearch(String text) {
    searchText.value = text;
  }
}
