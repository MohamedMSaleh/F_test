import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../constants/app_constants.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(AppConstants.spacing6),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.primary100,
                    child: Text(
                      'U',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                          'Welcome to SpeakX',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Your AI English Coach',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const Divider(),
            
            // Primary Navigation
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing2),
                children: [
                  _DrawerItem(
                    icon: Icons.home_outlined,
                    selectedIcon: Icons.home,
                    title: 'Home',
                    onTap: () => _navigateTo(context, AppConstants.routeHome),
                  ),
                  _DrawerItem(
                    icon: Icons.school_outlined,
                    selectedIcon: Icons.school,
                    title: 'Learning Journey',
                    onTap: () => _navigateTo(context, AppConstants.routeLearningJourney),
                  ),
                  _DrawerItem(
                    icon: Icons.emoji_events_outlined,
                    selectedIcon: Icons.emoji_events,
                    title: 'Challenges',
                    onTap: () => _navigateTo(context, AppConstants.routeChallenges),
                  ),
                  _DrawerItem(
                    icon: Icons.psychology_outlined,
                    selectedIcon: Icons.psychology,
                    title: 'AI Tutor',
                    onTap: () => _navigateTo(context, AppConstants.routeTutor),
                  ),
                  _DrawerItem(
                    icon: Icons.groups_outlined,
                    selectedIcon: Icons.groups,
                    title: 'Rooms',
                    onTap: () => _navigateTo(context, AppConstants.routeRooms),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing4),
                  const Divider(),
                  const SizedBox(height: AppConstants.spacing4),
                  
                  // Secondary Navigation
                  _DrawerItem(
                    icon: Icons.person_outline,
                    selectedIcon: Icons.person,
                    title: 'Profile & Settings',
                    onTap: () => _navigateTo(context, AppConstants.routeProfile),
                  ),
                  _DrawerItem(
                    icon: Icons.library_books_outlined,
                    selectedIcon: Icons.library_books,
                    title: 'Resources',
                    onTap: () => _navigateTo(context, '/resources'),
                  ),
                  _DrawerItem(
                    icon: Icons.forum_outlined,
                    selectedIcon: Icons.forum,
                    title: 'Community & Support',
                    onTap: () => _navigateTo(context, '/community'),
                  ),
                  _DrawerItem(
                    icon: Icons.work_outline,
                    selectedIcon: Icons.work,
                    title: 'Career Opportunities',
                    onTap: () => _navigateTo(context, '/careers'),
                  ),
                  _DrawerItem(
                    icon: Icons.analytics_outlined,
                    selectedIcon: Icons.analytics,
                    title: 'Progress & Analytics',
                    onTap: () => _navigateTo(context, '/progress'),
                  ),
                  _DrawerItem(
                    icon: Icons.assessment_outlined,
                    selectedIcon: Icons.assessment,
                    title: 'Assessment',
                    onTap: () => _navigateTo(context, AppConstants.routeAssessment),
                  ),
                  _DrawerItem(
                    icon: Icons.help_outline,
                    selectedIcon: Icons.help,
                    title: 'Help Center',
                    onTap: () => _navigateTo(context, '/help'),
                  ),
                ],
              ),
            ),
            
            // Footer
            Container(
              padding: const EdgeInsets.all(AppConstants.spacing4),
              child: Column(
                children: [
                  const Divider(),
                  const SizedBox(height: AppConstants.spacing2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => _navigateTo(context, '/about'),
                        child: const Text('About'),
                      ),
                      TextButton(
                        onPressed: () => _navigateTo(context, '/privacy'),
                        child: const Text('Privacy'),
                      ),
                      TextButton(
                        onPressed: () => _navigateTo(context, '/terms'),
                        child: const Text('Terms'),
                      ),
                    ],
                  ),
                  Text(
                    'SpeakX v${AppConstants.appVersion}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textDisabled,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, String route) {
    Navigator.of(context).pop(); // Close drawer
    Navigator.of(context).pushReplacementNamed(route);
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final IconData? selectedIcon;
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  const _DrawerItem({
    required this.icon,
    this.selectedIcon,
    required this.title,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        isSelected ? (selectedIcon ?? icon) : icon,
        color: isSelected ? AppColors.primary600 : AppColors.textSecondary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: isSelected ? AppColors.primary600 : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.primary50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacing4,
        vertical: AppConstants.spacing1,
      ),
      onTap: onTap,
    );
  }
}