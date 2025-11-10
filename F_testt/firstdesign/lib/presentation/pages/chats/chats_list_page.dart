import 'package:flutter/material.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class ChatsListPage extends StatefulWidget {
  const ChatsListPage({super.key});

  @override
  State<ChatsListPage> createState() => _ChatsListPageState();
}

class _ChatsListPageState extends State<ChatsListPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Chats',
      showBackButton: true,
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewChatModal,
        child: const Icon(Icons.add_comment),
      ),
      body: Column(
        children: [
          // Filter tabs
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'AI'),
              Tab(text: 'Human'),
              Tab(text: 'Rooms'),
              Tab(text: 'Support'),
            ],
          ),
          
          // Search bar
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacing4),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search conversations...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // TODO: Implement search filtering
                setState(() {});
              },
            ),
          ),
          
          // Chat list
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildChatList(_allChats),
                _buildChatList(_allChats.where((chat) => chat.type == ChatType.ai).toList()),
                _buildChatList(_allChats.where((chat) => chat.type == ChatType.human).toList()),
                _buildChatList(_allChats.where((chat) => chat.type == ChatType.room).toList()),
                _buildChatList(_allChats.where((chat) => chat.type == ChatType.support).toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatList(List<ChatData> chats) {
    if (chats.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing4),
      itemCount: chats.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppConstants.spacing2),
      itemBuilder: (context, index) {
        final chat = chats[index];
        return _buildChatItem(chat);
      },
    );
  }

  Widget _buildChatItem(ChatData chat) {
    return AppCard(
      type: AppCardType.outlined,
      onTap: () => _openChat(chat.id),
      child: Row(
        children: [
          // Avatar/Badge
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: chat.avatarColor.withOpacity(0.1),
                child: Icon(
                  chat.avatarIcon,
                  color: chat.avatarColor,
                  size: 24,
                ),
              ),
              if (chat.unreadCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Text(
                      '${chat.unreadCount}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(width: AppConstants.spacing3),
          
          // Chat content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        chat.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: chat.unreadCount > 0 ? FontWeight.bold : FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      chat.timestamp,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppConstants.spacing1),
                
                Row(
                  children: [
                    if (chat.type != ChatType.ai) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.spacing1,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: chat.typeColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppConstants.radiusXS),
                        ),
                        child: Text(
                          chat.typeLabel,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: chat.typeColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppConstants.spacing1),
                    ],
                    Expanded(
                      child: Text(
                        chat.lastMessage,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: chat.unreadCount > 0 ? AppColors.textPrimary : AppColors.textSecondary,
                          fontWeight: chat.unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Actions
          PopupMenuButton<String>(
            onSelected: (value) => _handleChatAction(chat.id, value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'pin',
                child: ListTile(
                  leading: Icon(Icons.push_pin_outlined),
                  title: Text('Pin'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'mute',
                child: ListTile(
                  leading: Icon(Icons.notifications_off_outlined),
                  title: Text('Mute'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'archive',
                child: ListTile(
                  leading: Icon(Icons.archive_outlined),
                  title: Text('Archive'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
            child: const Icon(
              Icons.more_vert,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: AppColors.textDisabled,
          ),
          const SizedBox(height: AppConstants.spacing4),
          Text(
            'No chats yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppConstants.spacing2),
          Text(
            'Start with AI Conversation or book a Human Tutor',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacing4),
          ElevatedButton(
            onPressed: _showNewChatModal,
            child: const Text('Start New Chat'),
          ),
        ],
      ),
    );
  }

  void _openChat(String chatId) {
    // TODO: Navigate to chat thread
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening chat: $chatId')),
    );
  }

  void _handleChatAction(String chatId, String action) {
    // TODO: Implement chat actions
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$action chat: $chatId')),
    );
  }

  void _showNewChatModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppConstants.spacing6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Chat',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: AppConstants.spacing4),
            
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(AppConstants.spacing2),
                decoration: BoxDecoration(
                  color: AppColors.primary100,
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
                child: const Icon(
                  Icons.psychology,
                  color: AppColors.primary600,
                ),
              ),
              title: const Text('AI Conversation'),
              subtitle: const Text('Practice with instant feedback'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(AppConstants.routeTutor);
              },
            ),
            
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(AppConstants.spacing2),
                decoration: BoxDecoration(
                  color: AppColors.accent100,
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
                child: const Icon(
                  Icons.person,
                  color: AppColors.accent500,
                ),
              ),
              title: const Text('Human Tutor'),
              subtitle: const Text('Book a session with expert tutors'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(AppConstants.routeTutor);
              },
            ),
            
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(AppConstants.spacing2),
                decoration: BoxDecoration(
                  color: AppColors.secondary100,
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
                child: const Icon(
                  Icons.groups,
                  color: AppColors.secondary600,
                ),
              ),
              title: const Text('Join Room'),
              subtitle: const Text('Practice with other learners'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(AppConstants.routeRooms);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Sample data
  final List<ChatData> _allChats = [
    ChatData(
      id: '1',
      name: 'AI Conversation',
      lastMessage: 'Great progress on your pronunciation today!',
      timestamp: '5m',
      unreadCount: 0,
      type: ChatType.ai,
      avatarIcon: Icons.psychology,
      avatarColor: AppColors.primary600,
    ),
    ChatData(
      id: '2',
      name: 'Sarah Ahmed',
      lastMessage: 'Your homework feedback is ready',
      timestamp: '1h',
      unreadCount: 2,
      type: ChatType.human,
      avatarIcon: Icons.person,
      avatarColor: AppColors.accent500,
    ),
    ChatData(
      id: '3',
      name: 'Pronunciation Practice',
      lastMessage: 'Ahmed: Thanks for the tip!',
      timestamp: '3h',
      unreadCount: 5,
      type: ChatType.room,
      avatarIcon: Icons.groups,
      avatarColor: AppColors.secondary600,
    ),
    ChatData(
      id: '4',
      name: 'SpeakX Support',
      lastMessage: 'How can we help you today?',
      timestamp: '1d',
      unreadCount: 0,
      type: ChatType.support,
      avatarIcon: Icons.support_agent,
      avatarColor: AppColors.info,
    ),
  ];

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}

enum ChatType { ai, human, room, support }

class ChatData {
  final String id;
  final String name;
  final String lastMessage;
  final String timestamp;
  final int unreadCount;
  final ChatType type;
  final IconData avatarIcon;
  final Color avatarColor;

  ChatData({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    required this.unreadCount,
    required this.type,
    required this.avatarIcon,
    required this.avatarColor,
  });

  String get typeLabel {
    switch (type) {
      case ChatType.ai:
        return 'AI';
      case ChatType.human:
        return 'HUMAN';
      case ChatType.room:
        return 'ROOM';
      case ChatType.support:
        return 'SUPPORT';
    }
  }

  Color get typeColor {
    switch (type) {
      case ChatType.ai:
        return AppColors.primary600;
      case ChatType.human:
        return AppColors.accent500;
      case ChatType.room:
        return AppColors.secondary600;
      case ChatType.support:
        return AppColors.info;
    }
  }
}