import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../constants/app_constants.dart';

enum AppCardType { elevated, outlined, filled }

class AppCard extends StatelessWidget {
  final Widget child;
  final AppCardType type;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final Color? backgroundColor;
  final Border? border;

  const AppCard({
    super.key,
    required this.child,
    this.type = AppCardType.elevated,
    this.onTap,
    this.padding = const EdgeInsets.all(AppConstants.spacing4),
    this.margin,
    this.elevation,
    this.backgroundColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Widget card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? _getBackgroundColor(context),
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        border: border ?? _getBorder(),
        boxShadow: _getBoxShadow(),
      ),
      child: Padding(
        padding: padding!,
        child: child,
      ),
    );

    if (onTap != null) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
          child: card,
        ),
      );
    }

    return card;
  }

  Color _getBackgroundColor(BuildContext context) {
    switch (type) {
      case AppCardType.elevated:
        return Theme.of(context).cardColor;
      case AppCardType.outlined:
        return Colors.transparent;
      case AppCardType.filled:
        return AppColors.surfaceVariant;
    }
  }

  Border? _getBorder() {
    switch (type) {
      case AppCardType.elevated:
        return null;
      case AppCardType.outlined:
        return Border.all(color: AppColors.neutral200);
      case AppCardType.filled:
        return null;
    }
  }

  List<BoxShadow>? _getBoxShadow() {
    if (type == AppCardType.elevated) {
      return [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          offset: const Offset(0, 4),
          blurRadius: 16,
          spreadRadius: 0,
        ),
      ];
    }
    return null;
  }
}

class AppTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const AppTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.padding = const EdgeInsets.all(AppConstants.spacing4),
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: padding,
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: AppConstants.spacing3),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                if (subtitle != null) ...[
                  const SizedBox(height: AppConstants.spacing1),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    child: subtitle!,
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppConstants.spacing3),
            trailing!,
          ],
        ],
      ),
    );
  }
}