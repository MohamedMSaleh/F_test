import 'package:flutter/material.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class NotificationsCenterPage extends StatefulWidget {
  const NotificationsCenterPage({super.key});

  @override
  State<NotificationsCenterPage> createState() => _NotificationsCenterPageState();
}

class _NotificationsCenterPageState extends State<NotificationsCenterPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Notifications',
      showBackButton: true,
      actions: [
        PopupMenuButton<String>(
          onSelected: _handleBulkAction,
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: 'mark_all_read',
              child: Text('Mark all as read'),
            ),
            PopupMenuItem(
              value: 'clear_all',
              child: Text('Clear all'),
            ),
            PopupMenuItem(
              value: 'settings',
              child: Text('Settings'),
            ),
          ],
        ),
      ],
      body: Column(
        children: [
          // Filter tabs
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Learning'),
              Tab(text: 'Tutor'),
              Tab(text: 'Challenges'),
              Tab(text: 'Offers'),
              Tab(text: 'System'),
            ],
          ),
          
          // Notifications list
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildNotificationsList(_allNotifications),
                _buildNotificationsList(_allNotifications.where((n) => n.type == NotificationType.learning).toList()),
                _buildNotificationsList(_allNotifications.where((n) => n.type == NotificationType.tutor).toList()),
                _buildNotificationsList(_allNotifications.where((n) => n.type == NotificationType.challenges).toList()),
                _buildNotificationsList(_allNotifications.where((n) => n.type == NotificationType.offers).toList()),
                _buildNotificationsList(_allNotifications.where((n) => n.type == NotificationType.system).toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList(List<NotificationData> notifications) {
    if (notifications.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppConstants.spacing4),
      itemCount: notifications.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppConstants.spacing2),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationItem(notification);
      },
    );
  }

  Widget _buildNotificationItem(NotificationData notification) {
    return AppCard(
      type: AppCardType.outlined,
      onTap: () => _handleNotificationTap(notification),
      child: Container(
        decoration: BoxDecoration(
          color: notification.isRead ? Colors.transparent : AppColors.primary50,
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
        ),
        padding: const EdgeInsets.all(AppConstants.spacing3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification icon
            Container(
              padding: const EdgeInsets.all(AppConstants.spacing2),
              decoration: BoxDecoration(
                color: notification.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusS),
              ),
              child: Icon(
                notification.icon,
                color: notification.color,
                size: 20,
              ),
            ),
            
            const SizedBox(width: AppConstants.spacing3),
            
            // Notification content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: notification.isRead ? FontWeight.w500 : FontWeight.w600,
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary600,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: AppConstants.spacing1),
                  
                  Text(
                    notification.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing2),
                  
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.spacing2,
                          vertical: AppConstants.spacing1,
                        ),
                        decoration: BoxDecoration(
                          color: notification.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppConstants.radiusXS),
                        ),
                        child: Text(
                          notification.source,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: notification.color,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      
                      const Spacer(),
                      
                      Text(
                        notification.timestamp,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textDisabled,
                        ),
                      ),
                    ],
                  ),
                  
                  if (notification.actionText != null) ...[
                    const SizedBox(height: AppConstants.spacing3),
                    TextButton(
                      onPressed: () => _handleNotificationAction(notification),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.spacing3,
                          vertical: AppConstants.spacing1,
                        ),
                        minimumSize: Size.zero,
                      ),
                      child: Text(
                        notification.actionText!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primary600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none_outlined,
            size: 64,
            color: AppColors.textDisabled,
          ),
          const SizedBox(height: AppConstants.spacing4),
          Text(
            'You\'re all caught up!',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppConstants.spacing2),
          Text(
            'No new notifications at the moment',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppConstants.spacing6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pushNamed(AppConstants.routeHome),
                icon: const Icon(Icons.home),
                label: const Text('Practice'),
              ),
              OutlinedButton.icon(
                onPressed: () => Navigator.of(context).pushNamed(AppConstants.routeChallenges),
                icon: const Icon(Icons.emoji_events),
                label: const Text('Challenges'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleNotificationTap(NotificationData notification) {
    // Mark as read
    setState(() {
      notification.isRead = true;
    });

    // Navigate based on notification type
    switch (notification.type) {
      case NotificationType.learning:
        Navigator.of(context).pushNamed(AppConstants.routeLearningJourney);
        break;
      case NotificationType.tutor:
        Navigator.of(context).pushNamed(AppConstants.routeTutor);
        break;
      case NotificationType.challenges:
        Navigator.of(context).pushNamed(AppConstants.routeChallenges);
        break;
      case NotificationType.offers:
        // TODO: Navigate to job offers
        break;
      case NotificationType.system:
        // TODO: Navigate to settings or help
        break;
    }
  }

  void _handleNotificationAction(NotificationData notification) {
    _handleNotificationTap(notification);
  }

  void _handleBulkAction(String action) {
    switch (action) {
      case 'mark_all_read':
        setState(() {
          for (var notification in _allNotifications) {
            notification.isRead = true;
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All notifications marked as read')),
        );
        break;
      case 'clear_all':
        setState(() {
          _allNotifications.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All notifications cleared')),
        );
        break;
      case 'settings':
        // TODO: Navigate to notification settings
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification settings coming soon')),
        );
        break;
    }
  }

  // Sample data
  final List<NotificationData> _allNotifications = [
    NotificationData(
      id: '1',
      title: 'Assessment completed!',
      description: 'Your pronunciation assessment shows great improvement in /th/ sounds.',
      timestamp: '5 min ago',
      isRead: false,
      type: NotificationType.learning,
      source: 'Assessment',
      icon: Icons.assessment_outlined,
      color: AppColors.primary600,
      actionText: 'View Report',
    ),
    NotificationData(
      id: '2',
      title: 'Tutor feedback ready',
      description: 'Sarah Ahmed has reviewed your speaking exercise submission.',
      timestamp: '1 hour ago',
      isRead: false,
      type: NotificationType.tutor,
      source: 'Human Tutor',
      icon: Icons.person_outlined,
      color: AppColors.accent500,
      actionText: 'Read Feedback',
    ),
    NotificationData(
      id: '3',
      title: 'Challenge milestone reached!',
      description: 'You\'ve completed 3 days of the Pronunciation Master challenge.',
      timestamp: '2 hours ago',
      isRead: true,
      type: NotificationType.challenges,
      source: 'Challenges',
      icon: Icons.emoji_events_outlined,
      color: AppColors.secondary600,
    ),
    NotificationData(
      id: '4',
      title: 'New job match found',
      description: 'A Customer Service role at TechCorp matches your skills (85% match).',
      timestamp: '1 day ago',
      isRead: false,
      type: NotificationType.offers,
      source: 'Career',
      icon: Icons.work_outline,
      color: AppColors.info,
      actionText: 'View Job',
    ),
    NotificationData(
      id: '5',
      title: 'Privacy policy updated',
      description: 'We\'ve updated our privacy policy with enhanced data protection.',
      timestamp: '2 days ago',
      isRead: true,
      type: NotificationType.system,
      source: 'System',
      icon: Icons.privacy_tip_outlined,
      color: AppColors.warning,
      actionText: 'Read More',
    ),
  ];

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

enum NotificationType { learning, tutor, challenges, offers, system }

class NotificationData {
  final String id;
  final String title;
  final String description;
  final String timestamp;
  bool isRead;
  final NotificationType type;
  final String source;
  final IconData icon;
  final Color color;
  final String? actionText;

  NotificationData({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.isRead,
    required this.type,
    required this.source,
    required this.icon,
    required this.color,
    this.actionText,
  });
}