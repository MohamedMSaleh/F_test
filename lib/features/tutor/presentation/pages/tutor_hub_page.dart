import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/tutor_provider.dart';
import '../widgets/ai_tutor_modes.dart';
import '../widgets/human_tutor_section.dart';
import '../widgets/session_history.dart';

class TutorHubPage extends StatefulWidget {
  const TutorHubPage({super.key});

  @override
  State<TutorHubPage> createState() => _TutorHubPageState();
}

class _TutorHubPageState extends State<TutorHubPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TutorProvider>().loadTutorData();
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
                _buildAITutorTab(),
                _buildHumanTutorTab(),
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
          colors: [AppTheme.primary600, Color(0xFF4C63D2)],
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
                  Icons.school,
                  color: Colors.white,
                  size: 32.w,
                ),
                SizedBox(width: AppTheme.spacing12.w),
                Text(
                  'Your Personal Tutor',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: AppTheme.spacing8.h),
            
            Text(
              'Practice with AI or get personalized feedback from expert human tutors',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            
            SizedBox(height: AppTheme.spacing16.h),
            
            Consumer<TutorProvider>(
              builder: (context, provider, child) {
                return Row(
                  children: [
                    _buildStatChip('AI Sessions', '${provider.sessions.where((s) => s.type == TutorSessionType.ai).length}'),
                    SizedBox(width: AppTheme.spacing12.w),
                    _buildStatChip('Human Sessions', '${provider.sessions.where((s) => s.type == TutorSessionType.human).length}'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatChip(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.spacing12.w,
        vertical: AppTheme.spacing8.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppTheme.radiusCircular.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          SizedBox(width: AppTheme.spacing8.w),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacing8.w,
              vertical: AppTheme.spacing4.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
            ),
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.primary600,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
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
          Tab(
            icon: Icon(Icons.smart_toy),
            text: 'AI Tutor',
          ),
          Tab(
            icon: Icon(Icons.person),
            text: 'Human Tutor',
          ),
        ],
      ),
    );
  }
  
  Widget _buildAITutorTab() {
    return Consumer<TutorProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return _buildLoadingState();
        }
        
        return SingleChildScrollView(
          padding: EdgeInsets.all(AppTheme.spacing16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AI Practice Modes',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: AppTheme.spacing8.h),
              
              Text(
                'Choose a practice mode to get instant AI feedback',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              
              SizedBox(height: AppTheme.spacing24.h),
              
              const AITutorModes(),
              
              SizedBox(height: AppTheme.spacing32.h),
              
              Text(
                'Recent AI Sessions',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: AppTheme.spacing16.h),
              
              SessionHistory(
                sessions: provider.sessions
                    .where((s) => s.type == TutorSessionType.ai)
                    .take(3)
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildHumanTutorTab() {
    return Consumer<TutorProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return _buildLoadingState();
        }
        
        return SingleChildScrollView(
          padding: EdgeInsets.all(AppTheme.spacing16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HumanTutorSection(),
              
              SizedBox(height: AppTheme.spacing32.h),
              
              Text(
                'Recent Human Sessions',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: AppTheme.spacing16.h),
              
              SessionHistory(
                sessions: provider.sessions
                    .where((s) => s.type == TutorSessionType.human)
                    .take(3)
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}