import 'package:flutter/material.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class TutorHubPage extends StatefulWidget {
  const TutorHubPage({super.key});

  @override
  State<TutorHubPage> createState() => _TutorHubPageState();
}

class _TutorHubPageState extends State<TutorHubPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Tutor Hub',
      body: Column(
        children: [
          // Mode selector tabs
          Container(
            padding: const EdgeInsets.all(AppConstants.spacing4),
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'AI Tutor'),
                Tab(text: 'Human Tutor'),
              ],
            ),
          ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAITutorSection(),
                _buildHumanTutorSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAITutorSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacing4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          AppCard(
            type: AppCardType.outlined,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppConstants.spacing3),
                  decoration: BoxDecoration(
                    color: AppColors.primary100,
                    borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  ),
                  child: const Icon(
                    Icons.psychology,
                    color: AppColors.primary600,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppConstants.spacing3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI-Powered Practice',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Get instant feedback and practice anytime with our AI tutor',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppConstants.spacing6),
          
          Text(
            'Practice Modes',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: AppConstants.spacing4),
          
          // AI practice modes grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: AppConstants.spacing3,
            mainAxisSpacing: AppConstants.spacing3,
            childAspectRatio: 1.1,
            children: [
              _buildAIModeCard(
                'Conversation',
                'Free-form chat with AI',
                Icons.chat_bubble_outline,
                AppColors.primary600,
                () => _startAISession('conversation'),
              ),
              _buildAIModeCard(
                'Story Mode',
                'Interactive storytelling',
                Icons.auto_stories_outlined,
                AppColors.secondary600,
                () => _startAISession('story'),
              ),
              _buildAIModeCard(
                'Reading Practice',
                'Read aloud with feedback',
                Icons.book_outlined,
                AppColors.accent500,
                () => _startAISession('reading'),
              ),
              _buildAIModeCard(
                'PDF Practice',
                'Upload & practice documents',
                Icons.picture_as_pdf_outlined,
                AppColors.info,
                () => _startAISession('pdf'),
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacing6),
          
          // Session history
          _buildSessionHistory(isAI: true),
        ],
      ),
    );
  }

  Widget _buildHumanTutorSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacing4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          AppCard(
            type: AppCardType.outlined,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppConstants.spacing3),
                  decoration: BoxDecoration(
                    color: AppColors.accent100,
                    borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.accent500,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppConstants.spacing3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Human Expert Guidance',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Book live sessions or submit recordings for personalized feedback',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppConstants.spacing6),
          
          // Human tutor options
          Row(
            children: [
              Expanded(
                child: _buildHumanTutorOption(
                  'Book Live Session',
                  'Schedule 1-on-1 time',
                  Icons.videocam_outlined,
                  AppColors.primary600,
                  () => _bookHumanSession(),
                ),
              ),
              const SizedBox(width: AppConstants.spacing3),
              Expanded(
                child: _buildHumanTutorOption(
                  'Submit for Review',
                  'Upload practice recordings',
                  Icons.upload_outlined,
                  AppColors.secondary600,
                  () => _submitToTaskQueue(),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacing6),
          
          // Available tutors
          Text(
            'Featured Tutors',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: AppConstants.spacing4),
          
          ..._tutors.map((tutor) => Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spacing3),
            child: _buildTutorCard(tutor),
          )),
          
          const SizedBox(height: AppConstants.spacing6),
          
          // Session history
          _buildSessionHistory(isAI: false),
        ],
      ),
    );
  }

  Widget _buildAIModeCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return AppCard(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.spacing3),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusL),
            ),
            child: Icon(
              icon,
              size: 32,
              color: color,
            ),
          ),
          
          const SizedBox(height: AppConstants.spacing3),
          
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: AppConstants.spacing1),
          
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHumanTutorOption(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return AppCard(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.spacing3),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusL),
            ),
            child: Icon(
              icon,
              size: 28,
              color: color,
            ),
          ),
          
          const SizedBox(height: AppConstants.spacing3),
          
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: AppConstants.spacing1),
          
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTutorCard(TutorData tutor) {
    return AppCard(
      onTap: () => _viewTutorProfile(tutor.id),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary100,
            child: Text(
              tutor.name.substring(0, 1),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primary600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          const SizedBox(width: AppConstants.spacing3),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tutor.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  tutor.specialties.join(' • '),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: AppColors.accent500,
                    ),
                    const SizedBox(width: AppConstants.spacing1),
                    Text(
                      '${tutor.rating}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: AppConstants.spacing2),
                    Text(
                      '${tutor.sessions} sessions',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          AppButton(
            text: 'Book',
            size: AppButtonSize.small,
            onPressed: () => _bookWithTutor(tutor.id),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionHistory({required bool isAI}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Sessions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        
        const SizedBox(height: AppConstants.spacing4),
        
        if (_recentSessions.isEmpty)
          AppCard(
            type: AppCardType.outlined,
            child: Column(
              children: [
                Icon(
                  isAI ? Icons.psychology_outlined : Icons.person_outline,
                  size: 48,
                  color: AppColors.textDisabled,
                ),
                const SizedBox(height: AppConstants.spacing2),
                Text(
                  isAI ? 'No AI sessions yet' : 'No human sessions yet',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppConstants.spacing3),
                AppButton(
                  text: isAI ? 'Start AI Session' : 'Book Session',
                  size: AppButtonSize.small,
                  onPressed: isAI ? () => _startAISession('conversation') : _bookHumanSession,
                ),
              ],
            ),
          )
        else
          ..._recentSessions.map((session) => Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spacing2),
            child: AppCard(
              type: AppCardType.outlined,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppConstants.spacing2),
                    decoration: BoxDecoration(
                      color: session.isAI ? AppColors.primary100 : AppColors.accent100,
                      borderRadius: BorderRadius.circular(AppConstants.radiusS),
                    ),
                    child: Icon(
                      session.isAI ? Icons.psychology : Icons.person,
                      color: session.isAI ? AppColors.primary600 : AppColors.accent500,
                      size: 16,
                    ),
                  ),
                  
                  const SizedBox(width: AppConstants.spacing3),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          session.title,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          session.date,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const Icon(
                    Icons.chevron_right,
                    color: AppColors.textDisabled,
                  ),
                ],
              ),
            ),
          )),
      ],
    );
  }

  void _startAISession(String mode) {
    // TODO: Navigate to AI session
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Starting AI $mode session')),
    );
  }

  void _bookHumanSession() {
    // TODO: Navigate to booking calendar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening booking calendar')),
    );
  }

  void _submitToTaskQueue() {
    // TODO: Navigate to task submission
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening task submission')),
    );
  }

  void _viewTutorProfile(String tutorId) {
    // TODO: Navigate to tutor profile
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viewing tutor profile: $tutorId')),
    );
  }

  void _bookWithTutor(String tutorId) {
    // TODO: Book with specific tutor
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking with tutor: $tutorId')),
    );
  }

  // Sample data
  final List<TutorData> _tutors = [
    TutorData(
      id: '1',
      name: 'Sarah Ahmed',
      specialties: ['Pronunciation', 'Business English'],
      rating: 4.9,
      sessions: 250,
    ),
    TutorData(
      id: '2',
      name: 'Mohamed Ali',
      specialties: ['Grammar', 'Conversation'],
      rating: 4.8,
      sessions: 180,
    ),
  ];

  final List<SessionData> _recentSessions = [];

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class TutorData {
  final String id;
  final String name;
  final List<String> specialties;
  final double rating;
  final int sessions;

  TutorData({
    required this.id,
    required this.name,
    required this.specialties,
    required this.rating,
    required this.sessions,
  });
}

class SessionData {
  final String title;
  final String date;
  final bool isAI;

  SessionData({
    required this.title,
    required this.date,
    required this.isAI,
  });
}