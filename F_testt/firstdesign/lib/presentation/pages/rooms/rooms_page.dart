import 'package:flutter/material.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Pronunciation', 'Grammar', 'Conversation', 'Business'];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Practice Rooms',
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewRoom,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Filter bar
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: AppConstants.spacing2),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing4),
              itemCount: _filters.length,
              separatorBuilder: (context, index) => const SizedBox(width: AppConstants.spacing2),
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = filter == _selectedFilter;
                return FilterChip(
                  label: Text(filter),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                );
              },
            ),
          ),
          
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing4),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search rooms...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // TODO: Implement search
              },
            ),
          ),
          
          const SizedBox(height: AppConstants.spacing4),
          
          // Rooms list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing4),
              itemCount: _filteredRooms.length,
              separatorBuilder: (context, index) => const SizedBox(height: AppConstants.spacing3),
              itemBuilder: (context, index) {
                final room = _filteredRooms[index];
                return _buildRoomCard(room);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(RoomData room) {
    return AppCard(
      onTap: () => _joinRoom(room.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Room header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.spacing2),
                decoration: BoxDecoration(
                  color: room.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusS),
                ),
                child: Icon(
                  room.icon,
                  color: room.color,
                  size: 20,
                ),
              ),
              
              const SizedBox(width: AppConstants.spacing3),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      room.topic,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              if (room.isLive)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacing2,
                    vertical: AppConstants.spacing1,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.radiusS),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppConstants.spacing1),
                      Text(
                        'LIVE',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacing3),
          
          // Room description
          Text(
            room.description,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: AppConstants.spacing3),
          
          // Room stats
          Row(
            children: [
              _buildRoomStat(
                Icons.people_outline,
                '${room.participants}',
                'participants',
              ),
              const SizedBox(width: AppConstants.spacing4),
              _buildRoomStat(
                Icons.forum_outlined,
                '${room.messages}',
                'messages',
              ),
              const SizedBox(width: AppConstants.spacing4),
              _buildRoomStat(
                Icons.schedule_outlined,
                room.lastActivity,
                '',
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacing4),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: room.isJoined ? 'Continue' : 'Join Room',
                  type: room.isJoined ? AppButtonType.primary : AppButtonType.secondary,
                  size: AppButtonSize.small,
                  onPressed: () => _joinRoom(room.id),
                ),
              ),
              const SizedBox(width: AppConstants.spacing2),
              IconButton(
                onPressed: () => _viewRoomDetails(room.id),
                icon: const Icon(Icons.info_outline),
                tooltip: 'Room Details',
              ),
              if (room.hasLeaderboard)
                IconButton(
                  onPressed: () => _viewLeaderboard(room.id),
                  icon: const Icon(Icons.leaderboard),
                  tooltip: 'Leaderboard',
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoomStat(IconData icon, String value, String label) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: AppConstants.spacing1),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        if (label.isNotEmpty) ...[
          const SizedBox(width: AppConstants.spacing1),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }

  List<RoomData> get _filteredRooms {
    if (_selectedFilter == 'All') return _allRooms;
    return _allRooms.where((room) => room.topic.toLowerCase().contains(_selectedFilter.toLowerCase())).toList();
  }

  void _createNewRoom() {
    // TODO: Navigate to room creation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Room creation coming soon')),
    );
  }

  void _joinRoom(String roomId) {
    // TODO: Navigate to room detail
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Joining room: $roomId')),
    );
  }

  void _viewRoomDetails(String roomId) {
    // TODO: Show room details modal
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Room details: $roomId')),
    );
  }

  void _viewLeaderboard(String roomId) {
    // TODO: Navigate to room leaderboard
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Leaderboard for room: $roomId')),
    );
  }

  // Sample data
  final List<RoomData> _allRooms = [
    RoomData(
      id: '1',
      title: 'Pronunciation Practice',
      topic: 'Pronunciation',
      description: 'Practice common pronunciation challenges with fellow learners. Focus on /th/, /v/, and /w/ sounds.',
      participants: 24,
      messages: 156,
      lastActivity: '5 min ago',
      isLive: true,
      isJoined: true,
      hasLeaderboard: true,
      color: AppColors.primary600,
      icon: Icons.record_voice_over_outlined,
    ),
    RoomData(
      id: '2',
      title: 'Business English',
      topic: 'Business',
      description: 'Improve your professional communication skills. Practice presentations, meetings, and emails.',
      participants: 18,
      messages: 89,
      lastActivity: '15 min ago',
      isLive: false,
      isJoined: false,
      hasLeaderboard: true,
      color: AppColors.secondary600,
      icon: Icons.business_outlined,
    ),
    RoomData(
      id: '3',
      title: 'Grammar Workshop',
      topic: 'Grammar',
      description: 'Master English grammar rules through interactive exercises and peer discussions.',
      participants: 31,
      messages: 203,
      lastActivity: '2 min ago',
      isLive: true,
      isJoined: false,
      hasLeaderboard: false,
      color: AppColors.accent500,
      icon: Icons.edit_outlined,
    ),
    RoomData(
      id: '4',
      title: 'Casual Conversations',
      topic: 'Conversation',
      description: 'Practice everyday English in a relaxed, friendly environment. All levels welcome!',
      participants: 42,
      messages: 312,
      lastActivity: '1 min ago',
      isLive: true,
      isJoined: true,
      hasLeaderboard: false,
      color: AppColors.info,
      icon: Icons.chat_bubble_outline,
    ),
  ];
}

class RoomData {
  final String id;
  final String title;
  final String topic;
  final String description;
  final int participants;
  final int messages;
  final String lastActivity;
  final bool isLive;
  final bool isJoined;
  final bool hasLeaderboard;
  final Color color;
  final IconData icon;

  RoomData({
    required this.id,
    required this.title,
    required this.topic,
    required this.description,
    required this.participants,
    required this.messages,
    required this.lastActivity,
    required this.isLive,
    required this.isJoined,
    required this.hasLeaderboard,
    required this.color,
    required this.icon,
  });
}