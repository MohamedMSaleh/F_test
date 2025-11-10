import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../constants/app_constants.dart';
import 'app_drawer.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool showDrawer;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.showDrawer = true,
    this.showBackButton = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title != null ? Text(title!) : null,
        leading: showBackButton
            ? IconButton(
                onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              )
            : showDrawer
                ? Builder(
                    builder: (context) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu),
                    ),
                  )
                : null,
        actions: [
          // Search icon (where applicable)
          if (actions?.any((action) => action is _SearchAction) != true)
            IconButton(
              onPressed: () => _showSearch(context),
              icon: const Icon(Icons.search),
            ),
          
          // Notifications
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(AppConstants.routeNotifications),
            icon: const Icon(Icons.notifications_outlined),
          ),
          
          // Chat icon
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(AppConstants.routeChats),
            icon: const Icon(Icons.chat_bubble_outline),
          ),
          
          // Custom actions
          if (actions != null) ...actions!,
          
          const SizedBox(width: AppConstants.spacing2),
        ],
      ),
      drawer: showDrawer ? const AppDrawer() : null,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  void _showSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: AppSearchDelegate(),
    );
  }
}

class _SearchAction extends StatelessWidget {
  final VoidCallback onPressed;

  const _SearchAction({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.search),
    );
  }
}

class AppSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 64,
            color: AppColors.textDisabled,
          ),
          const SizedBox(height: AppConstants.spacing4),
          Text(
            'Search results for "$query"',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppConstants.spacing2),
          Text(
            'Search functionality will be implemented soon',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement search suggestions
    final suggestions = [
      'Pronunciation exercises',
      'Grammar lessons',
      'Vocabulary practice',
      'Speaking challenges',
      'Assessment reports',
    ];

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          leading: const Icon(Icons.search),
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}