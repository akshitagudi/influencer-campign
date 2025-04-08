import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/app_colors.dart';
import 'dashboard_controller.dart';
import 'utils/responsive_widget.dart';

class DashboardPage extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: _buildDashboard(context),
      tablet: _buildDashboard(context),
      desktop: _buildDashboard(context),
    );
  }

  Widget _buildDashboard(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Campaign Dashboard",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Ongoing Campaigns'),
              Tab(text: 'Completed Campaigns'),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: TextField(
                onChanged: controller.updateSearch,
                decoration: InputDecoration(
                  hintText: 'Search campaigns...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(() => _buildCampaignList(
                        controller.ongoingCampaigns,
                        isCompletedTab: false,
                      )),
                  Obx(() => _buildCampaignList(
                        controller.completedCampaigns,
                        isCompletedTab: true,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampaignList(List<Campaign> campaigns,
      {required bool isCompletedTab}) {
    if (campaigns.isEmpty) {
      return Center(child: Text('No campaigns found.'));
    }

    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: campaigns.length,
      itemBuilder: (context, index) {
        final campaign = campaigns[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        campaign.title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Icon Section
                    isCompletedTab
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.check_box_outline_blank,
                              color: AppColors.mainColor,
                            ),
                            onPressed: () {
                              controller.markAsCompleted(campaign);
                            },
                          ),
                  ],
                ),
                SizedBox(height: 8),
                Text("Description: ${campaign.description}"),
                Text("Platform: ${campaign.platform}"),
                Text("Start Date: ${campaign.startDate}"),
                Text("End Date: ${campaign.endDate}"),
                Text("Engagement: ${campaign.engagement}"),
              ],
            ),
          ),
        );
      },
    );
  }
}
