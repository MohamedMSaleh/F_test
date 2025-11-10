import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.spacing16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            SizedBox(height: AppTheme.spacing32.h),
            _buildSettingsSections(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing20.w),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.r,
            backgroundColor: AppTheme.primary600.withOpacity(0.1),
            child: Text(
              'AH',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppTheme.primary600,
              ),
            ),
          ),
          SizedBox(width: AppTheme.spacing16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ahmed Hassan',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                SizedBox(height: AppTheme.spacing4.h),
                Text(
                  'ahmed.hassan@email.com',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(height: AppTheme.spacing8.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.spacing8.w,
                    vertical: AppTheme.spacing4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.accent500.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                  ),
                  child: Text(
                    'Intermediate Level',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppTheme.accent500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // Edit profile
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSections(BuildContext context) {
    return Column(
      children: [
        _buildSettingsSection(
          context,
          title: 'Learning Preferences',
          items: [
            _SettingsItem('Language', 'English / العربية', Icons.language),
            _SettingsItem('Difficulty Level', 'Intermediate', Icons.trending_up),
            _SettingsItem('Daily Goal', '30 minutes', Icons.schedule),
            _SettingsItem('Reminder Time', '8:00 PM', Icons.notifications),
          ],
        ),
        
        SizedBox(height: AppTheme.spacing24.h),
        
        _buildSettingsSection(
          context,
          title: 'Privacy & Data',
          items: [
            _SettingsItem('Voice Recording', 'Enabled', Icons.mic),
            _SettingsItem('Data Storage', 'Encrypted', Icons.security),
            _SettingsItem('Export Data', 'Download your data', Icons.download),
            _SettingsItem('Delete Account', 'Permanently delete', Icons.delete_forever),
          ],
          isDanger: true,
        ),
        
        SizedBox(height: AppTheme.spacing24.h),
        
        _buildSettingsSection(
          context,
          title: 'Subscription',
          items: [
            _SettingsItem('Current Plan', 'AI + Human Tutor', Icons.star),
            _SettingsItem('Billing', 'Manage payment', Icons.payment),
            _SettingsItem('Usage', 'View session history', Icons.history),
          ],
        ),
        
        SizedBox(height: AppTheme.spacing24.h),
        
        _buildSettingsSection(
          context,
          title: 'Support',
          items: [
            _SettingsItem('Help Center', 'FAQs and guides', Icons.help),
            _SettingsItem('Contact Us', 'Get support', Icons.support_agent),
            _SettingsItem('Feedback', 'Rate the app', Icons.feedback),
            _SettingsItem('About SpeakX', 'Version 1.0.0', Icons.info),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsSection(
    BuildContext context, {
    required String title,
    required List<_SettingsItem> items,
    bool isDanger = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        
        SizedBox(height: AppTheme.spacing16.h),
        
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == items.length - 1;
              
              return Column(
                children: [
                  ListTile(
                    leading: Icon(
                      item.icon,
                      color: isDanger && index >= items.length - 2 
                        ? AppTheme.error 
                        : AppTheme.textSecondary,
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        color: isDanger && index >= items.length - 2 
                          ? AppTheme.error 
                          : AppTheme.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      item.subtitle,
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: AppTheme.textDisabled,
                    ),
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppTheme.textDisabled.withOpacity(0.2),
                      indent: 72.w,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _SettingsItem {
  final String title;
  final String subtitle;
  final IconData icon;

  _SettingsItem(this.title, this.subtitle, this.icon);
}