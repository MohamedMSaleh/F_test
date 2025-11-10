import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/challenges_provider.dart';
import '../widgets/challenge_card.dart';
import '../widgets/leaderboard_preview.dart';

class ChallengesHubPage extends StatefulWidget {
  const ChallengesHubPage({super.key});

  @override
  State<ChallengesHubPage> createState() => _ChallengesHubPageState();
}

class _ChallengesHubPageState extends State<ChallengesHubPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChallengesProvider>().loadChallenges();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildWeeklyChallenges(),
                _buildMonthlyChallenges(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF59E0B), Color(0xFFEAB308)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.emoji_events,
                  color: Colors.white,
                  size: 32.w,
                ),
                SizedBox(width: AppTheme.spacing12.w),
                Text(
                  'Challenges',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: AppTheme.spacing8.h),
            
            Text(
              'Join challenges to earn coins and compete with other learners!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            
            SizedBox(height: AppTheme.spacing16.h),
            
            Consumer<ChallengesProvider>(
              builder: (context, provider, child) {
                final activeCount = provider.activeChallenges.length;
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.spacing16.w,
                    vertical: AppTheme.spacing8.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppTheme.radiusCircular.r),
                  ),
                  child: Text(
                    'Active Challenges: $activeCount',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTabBar() {
    return Container(
      color: AppTheme.surface,
      child: TabBar(
        controller: _tabController,
        labelColor: AppTheme.primary600,
        unselectedLabelColor: AppTheme.textSecondary,
        indicatorColor: AppTheme.primary600,
        tabs: const [
          Tab(text: 'Weekly'),
          Tab(text: 'Monthly'),
        ],
      ),
    );
  }
  
  Widget _buildWeeklyChallenges() {
    return Consumer<ChallengesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return _buildLoadingState();
        }
        
        final weeklyChallenges = provider.challenges
            .where((c) => c.type == ChallengeType.weekly)
            .toList();
            
        if (weeklyChallenges.isEmpty) {
          return _buildEmptyState('No weekly challenges available');
        }
        
        return RefreshIndicator(
          onRefresh: provider.loadChallenges,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppTheme.spacing16.w),
            child: Column(
              children: [
                // Featured Challenge Banner
                if (weeklyChallenges.isNotEmpty)
                  _buildFeaturedChallenge(weeklyChallenges.first),
                
                SizedBox(height: AppTheme.spacing24.h),
                
                // Challenge Cards
                ...weeklyChallenges.map((challenge) => Padding(
                  padding: EdgeInsets.only(bottom: AppTheme.spacing16.h),
                  child: ChallengeCard(challenge: challenge),
                )),
                
                SizedBox(height: AppTheme.spacing24.h),
                
                // Leaderboard Preview
                const LeaderboardPreview(),
              ],
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildMonthlyChallenges() {
    return Consumer<ChallengesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return _buildLoadingState();
        }
        
        final monthlyChallenges = provider.challenges
            .where((c) => c.type == ChallengeType.monthly)
            .toList();
            
        if (monthlyChallenges.isEmpty) {
          return _buildEmptyState('No monthly challenges available');
        }
        
        return RefreshIndicator(
          onRefresh: provider.loadChallenges,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppTheme.spacing16.w),
            child: Column(
              children: [
                ...monthlyChallenges.map((challenge) => Padding(
                  padding: EdgeInsets.only(bottom: AppTheme.spacing16.h),
                  child: ChallengeCard(challenge: challenge),
                )),
                
                SizedBox(height: AppTheme.spacing24.h),
                
                const LeaderboardPreview(),
              ],
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildFeaturedChallenge(Challenge challenge) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppTheme.spacing20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primary600,
            AppTheme.primary600.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing8.w,
                  vertical: AppTheme.spacing4.h,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.accent500,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                ),
                child: Text(
                  'FEATURED',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.emoji_events,
                color: Colors.white,
                size: 24.w,
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Text(
            challenge.title,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          
          SizedBox(height: AppTheme.spacing8.h),
          
          Text(
            challenge.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          
          SizedBox(height: AppTheme.spacing16.h),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progress: ${challenge.currentProgress}/${challenge.targetProgress}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: AppTheme.spacing8.h),
                    LinearProgressIndicator(
                      value: challenge.progress,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                    ),
                  ],
                ),
              ),
              
              SizedBox(width: AppTheme.spacing16.w),
              
              ElevatedButton(
                onPressed: challenge.isJoined 
                  ? null 
                  : () => _joinChallenge(challenge.id),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.primary600,
                ),
                child: Text(challenge.isJoined ? 'Joined' : 'Join'),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  
  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.emoji_events_outlined,
            size: 80.w,
            color: AppTheme.textDisabled,
          ),
          SizedBox(height: AppTheme.spacing16.h),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
  
  void _joinChallenge(String challengeId) {
    context.read<ChallengesProvider>().joinChallenge(challengeId);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Challenge joined successfully!'),
        backgroundColor: AppTheme.success,
      ),
    );
  }
}