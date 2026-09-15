import 'package:flutter/material.dart';

import 'widgets/home_header.dart';
import 'widgets/statistics_section.dart';
import 'widgets/recent_orders_section.dart';
import 'widgets/search_section.dart';
import 'widgets/home_banner.dart';
import 'widgets/services_section.dart';
import 'widgets/technicians_section.dart';
import 'widgets/offers_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: const [
              /// Header
              HomeHeader(),

              SizedBox(height: 25),

              /// Statistics
              StatisticsSection(),

              SizedBox(height: 25),

              /// Recent Orders
              RecentOrdersSection(),

              SizedBox(height: 25),

              /// Search
              SearchSection(),

              SizedBox(height: 25),

              /// Banner
              HomeBanner(),

              SizedBox(height: 30),

              /// Services
              ServicesSection(),

              SizedBox(height: 30),

              /// Technicians
              TechniciansSection(),

              SizedBox(height: 30),

              /// Offers
              OffersSection(),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}