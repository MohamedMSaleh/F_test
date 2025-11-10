import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';

class ChatsListPage extends StatelessWidget {
  const ChatsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          _buildFilterBar(),
          Expanded(child: _buildChatsList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNewChatDialog(context);
        },
        backgroundColor: AppTheme.primary600,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing16.w),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Text(
              'Messages',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                // Search chats
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing16.w),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip('All', true),
          SizedBox(width: AppTheme.spacing8.w),
          _buildFilterChip('AI Tutor', false),
          SizedBox(width: AppTheme.spacing8.w),
          _buildFilterChip('Human Tutors', false),
          SizedBox(width: AppTheme.spacing8.w),
          _buildFilterChip('Rooms', false),
          SizedBox(width: AppTheme.spacing8.w),
          _buildFilterChip('Support', false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        // Handle filter selection
      },
      selectedColor: AppTheme.primary600.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? AppTheme.primary600 : AppTheme.textSecondary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }

  Widget _buildChatsList() {
    final chats = [
      {
        'name': 'AI Conversation Tutor',
        'lastMessage': 'Great job on your pronunciation practice!',
        'timestamp': '2m ago',
        'unreadCount': 0,
        'avatar': Icons.smart_toy,
        'type': 'ai',
      },
      {
        'name': 'Dr. Sarah Johnson',
        'lastMessage': 'I\'ve reviewed your speaking exercise...',
        'timestamp': '1h ago',
        'unreadCount': 2,
        'avatar': Icons.person,
        'type': 'human',
      },
      {
        'name': 'Pronunciation Practice Room',
        'lastMessage': 'Ahmed: Can someone help with /th/ sounds?',
        'timestamp': '3h ago',
        'unreadCount': 5,
        'avatar': Icons.groups,
        'type': 'room',
      },
      {
        'name': 'Support Team',
        'lastMessage': 'Your privacy settings have been updated',
        'timestamp': '1d ago',
        'unreadCount': 0,
        'avatar': Icons.support_agent,
        'type': 'support',
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing16.w),
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return _buildChatItem(chat);
      },
    );
  }

  Widget _buildChatItem(Map<String, dynamic> chat) {
    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.spacing8.h),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getChatTypeColor(chat['type']).withOpacity(0.1),
          child: Icon(
            chat['avatar'] as IconData,
            color: _getChatTypeColor(chat['type']),
          ),
        ),
        title: Text(
          chat['name'] as String,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        subtitle: Text(
          chat['lastMessage'] as String,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppTheme.textSecondary,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              chat['timestamp'] as String,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppTheme.textDisabled,
              ),
            ),
            if ((chat['unreadCount'] as int) > 0) ...[
              SizedBox(height: AppTheme.spacing4.h),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing6.w,
                  vertical: AppTheme.spacing2.h,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.error,
                  borderRadius: BorderRadius.circular(AppTheme.radiusCircular.r),
                ),
                child: Text(
                  '${chat['unreadCount']}',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        onTap: () {
          // Navigate to chat thread
        },
      ),
    );
  }

  Color _getChatTypeColor(String type) {
    switch (type) {
      case 'ai':
        return AppTheme.info;
      case 'human':
        return AppTheme.success;
      case 'room':
        return AppTheme.secondary600;
      case 'support':
        return AppTheme.warning;
      default:
        return AppTheme.textSecondary;
    }
  }

  void _showNewChatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Start New Chat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.info.withOpacity(0.1),
                  child: Icon(Icons.smart_toy, color: AppTheme.info),
                ),
                title: const Text('AI Conversation'),
                subtitle: const Text('Practice with AI tutor'),
                onTap: () {
                  Navigator.of(context).pop();
                  // Start AI conversation
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.success.withOpacity(0.1),
                  child: Icon(Icons.person, color: AppTheme.success),
                ),
                title: const Text('Human Tutor'),
                subtitle: const Text('Book session or message'),
                onTap: () {
                  Navigator.of(context).pop();
                  // Navigate to human tutor booking
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}