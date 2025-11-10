import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/app_state_provider.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Profile & Settings',
      body: Column(
        children: [
          // Profile header
          Container(
            padding: const EdgeInsets.all(AppConstants.spacing6),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: AppColors.primary100,
                  child: Text(
                    'JD',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.primary600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                const SizedBox(width: AppConstants.spacing4),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'john.doe@email.com',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacing1),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.spacing2,
                          vertical: AppConstants.spacing1,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent100,
                          borderRadius: BorderRadius.circular(AppConstants.radiusS),
                        ),
                        child: Text(
                          'Premium Member',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.accent500,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
            ),
          ),
          
          // Settings tabs
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: 'Profile'),
              Tab(text: 'Preferences'),
              Tab(text: 'Notifications'),
              Tab(text: 'Privacy'),
              Tab(text: 'Subscription'),
            ],
          ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProfileTab(),
                _buildPreferencesTab(),
                _buildNotificationsTab(),
                _buildPrivacyTab(),
                _buildSubscriptionTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacing4),
      child: Column(
        children: [
          _buildSettingsGroup(
            'Personal Information',
            [
              _buildSettingsTile(
                'Name',
                'John Doe',
                Icons.person_outline,
                onTap: () {},
              ),
              _buildSettingsTile(
                'Email',
                'john.doe@email.com',
                Icons.email_outlined,
                onTap: () {},
              ),
              _buildSettingsTile(
                'Phone',
                '+20 123 456 789',
                Icons.phone_outlined,
                onTap: () {},
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacing6),
          
          _buildSettingsGroup(
            'Learning Profile',
            [
              _buildSettingsTile(
                'Current Level',
                'Intermediate',
                Icons.trending_up,
                onTap: () {},
              ),
              _buildSettingsTile(
                'Learning Goals',
                'Business English, Pronunciation',
                Icons.flag_outlined,
                onTap: () {},
              ),
              _buildSettingsTile(
                'Native Language',
                'Arabic',
                Icons.language,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacing4),
      child: Column(
        children: [
          _buildSettingsGroup(
            'App Preferences',
            [
              Consumer<AppStateProvider>(
                builder: (context, appState, child) {
                  return _buildSettingsTile(
                    'Language',
                    appState.locale.languageCode == 'en' ? 'English' : 'العربية',
                    Icons.translate,
                    trailing: Switch(
                      value: appState.locale.languageCode == 'ar',
                      onChanged: (value) {
                        appState.toggleLanguage();
                      },
                    ),
                  );
                },
              ),
              Consumer<AppStateProvider>(
                builder: (context, appState, child) {
                  return _buildSettingsTile(
                    'Theme',
                    appState.themeMode == ThemeMode.light ? 'Light' : 
                    appState.themeMode == ThemeMode.dark ? 'Dark' : 'System',
                    Icons.palette_outlined,
                    onTap: () => _showThemePicker(),
                  );
                },
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacing6),
          
          _buildSettingsGroup(
            'Learning Preferences',
            [
              _buildSettingsTile(
                'Difficulty Level',
                'Adaptive',
                Icons.tune,
                onTap: () {},
              ),
              _buildSettingsTile(
                'Session Length',
                '20 minutes',
                Icons.schedule,
                onTap: () {},
              ),
              _buildSettingsTile(
                'Practice Reminders',
                'Daily at 7:00 PM',
                Icons.notifications_outlined,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacing4),
      child: Column(
        children: [
          _buildSettingsGroup(
            'Push Notifications',
            [
              _buildSettingsTile(
                'Learning Updates',
                'Get notified about progress and new content',
                Icons.school_outlined,
                trailing: Switch(value: true, onChanged: (value) {}),
              ),
              _buildSettingsTile(
                'Tutor Messages',
                'Notifications from human tutors',
                Icons.person_outlined,
                trailing: Switch(value: true, onChanged: (value) {}),
              ),
              _buildSettingsTile(
                'Challenge Updates',
                'Weekly and monthly challenge notifications',
                Icons.emoji_events_outlined,
                trailing: Switch(value: false, onChanged: (value) {}),
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacing6),
          
          _buildSettingsGroup(
            'Email Notifications',
            [
              _buildSettingsTile(
                'Weekly Progress Report',
                'Summary of your learning progress',
                Icons.analytics_outlined,
                trailing: Switch(value: true, onChanged: (value) {}),
              ),
              _buildSettingsTile(
                'Job Opportunities',
                'New job matches and offers',
                Icons.work_outline,
                trailing: Switch(value: true, onChanged: (value) {}),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacing4),
      child: Column(
        children: [
          // Privacy notice
          AppCard(
            type: AppCardType.outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: AppConstants.spacing2),
                    Text(
                      'Your Data is Secure',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacing2),
                Text(
                  'All voice recordings are encrypted and stored securely. You have full control over your data.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppConstants.spacing6),
          
          _buildSettingsGroup(
            'Data Controls',
            [
              _buildSettingsTile(
                'Download My Data',
                'Export all your learning data',
                Icons.download_outlined,
                onTap: () {},
              ),
              _buildSettingsTile(
                'Delete Recordings',
                'Remove specific voice recordings',
                Icons.delete_outline,
                onTap: () {},
              ),
              _buildSettingsTile(
                'Data Sharing',
                'Control how your data is used',
                Icons.share_outlined,
                onTap: () {},
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacing6),
          
          _buildSettingsGroup(
            'Legal',
            [
              _buildSettingsTile(
                'Privacy Policy',
                'Read our privacy policy',
                Icons.privacy_tip_outlined,
                onTap: () {},
              ),
              _buildSettingsTile(
                'Terms of Service',
                'View terms and conditions',
                Icons.description_outlined,
                onTap: () {},
              ),
              _buildSettingsTile(
                'Delete Account',
                'Permanently delete your account',
                Icons.delete_forever_outlined,
                onTap: () => _showDeleteAccountDialog(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacing4),
      child: Column(
        children: [
          // Current plan
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColors.accent500,
                    ),
                    const SizedBox(width: AppConstants.spacing2),
                    Text(
                      'Premium Plan',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.spacing2,
                        vertical: AppConstants.spacing1,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppConstants.radiusS),
                      ),
                      child: Text(
                        'ACTIVE',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppConstants.spacing2),
                
                Text(
                  'AI + Human Tutor access with unlimited sessions',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacing4),
                
                Row(
                  children: [
                    Text(
                      '\$19.99/month',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Next billing: Jan 15, 2025',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppConstants.spacing6),
          
          _buildSettingsGroup(
            'Subscription Management',
            [
              _buildSettingsTile(
                'Change Plan',
                'Upgrade or downgrade your subscription',
                Icons.swap_vert,
                onTap: () {},
              ),
              _buildSettingsTile(
                'Payment Method',
                'Update your payment information',
                Icons.payment,
                onTap: () {},
              ),
              _buildSettingsTile(
                'Billing History',
                'View past invoices and payments',
                Icons.receipt_long,
                onTap: () {},
              ),
              _buildSettingsTile(
                'Cancel Subscription',
                'End your premium membership',
                Icons.cancel_outlined,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppConstants.spacing2, bottom: AppConstants.spacing2),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        AppCard(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(
    String title,
    String subtitle,
    IconData icon, {
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: AppConstants.spacing1),
    );
  }

  void _showThemePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Consumer<AppStateProvider>(
          builder: (context, appState, child) {
            return Container(
              padding: const EdgeInsets.all(AppConstants.spacing6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose Theme',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing4),
                  
                  RadioListTile<ThemeMode>(
                    title: const Text('System'),
                    value: ThemeMode.system,
                    groupValue: appState.themeMode,
                    onChanged: (mode) {
                      if (mode != null) {
                        appState.setThemeMode(mode);
                        Navigator.pop(context);
                      }
                    },
                  ),
                  RadioListTile<ThemeMode>(
                    title: const Text('Light'),
                    value: ThemeMode.light,
                    groupValue: appState.themeMode,
                    onChanged: (mode) {
                      if (mode != null) {
                        appState.setThemeMode(mode);
                        Navigator.pop(context);
                      }
                    },
                  ),
                  RadioListTile<ThemeMode>(
                    title: const Text('Dark'),
                    value: ThemeMode.dark,
                    groupValue: appState.themeMode,
                    onChanged: (mode) {
                      if (mode != null) {
                        appState.setThemeMode(mode);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This action cannot be undone. All your data, progress, and recordings will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          AppButton(
            text: 'Delete',
            type: AppButtonType.secondary,
            size: AppButtonSize.small,
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement account deletion
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}