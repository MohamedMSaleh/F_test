import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/assessment_provider.dart';

class AssessmentReportPage extends StatelessWidget {
  const AssessmentReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AssessmentProvider>(
        builder: (context, provider, child) {
          final report = provider.latestReport;
          
          if (report == null) {
            return _buildNoReportState();
          }
          
          return SingleChildScrollView(
            padding: EdgeInsets.all(AppTheme.spacing16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, report),
                SizedBox(height: AppTheme.spacing24.h),
                _buildScoreSummary(context, report),
                SizedBox(height: AppTheme.spacing24.h),
                _buildRadarChart(context, report),
                SizedBox(height: AppTheme.spacing24.h),
                _buildMicroSkills(context, report),
                SizedBox(height: AppTheme.spacing24.h),
                _buildRecommendations(context, report),
                SizedBox(height: AppTheme.spacing24.h),
                _buildActionButtons(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoReportState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assessment,
            size: 80.w,
            color: AppTheme.textDisabled,
          ),
          SizedBox(height: AppTheme.spacing16.h),
          const Text('No assessment report available'),
          SizedBox(height: AppTheme.spacing16.h),
          ElevatedButton(
            onPressed: () {
              // Start new assessment
            },
            child: const Text('Take Assessment'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AssessmentReport report) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Assessment Results',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: AppTheme.spacing8.h),
        Text(
          'Generated ${_formatDate(report.generatedAt)}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreSummary(BuildContext context, AssessmentReport report) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppTheme.spacing20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primary600, Color(0xFF4C63D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
      ),
      child: Column(
        children: [
          Text(
            'Overall Score',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          SizedBox(height: AppTheme.spacing8.h),
          Text(
            '${report.overallScore.toInt()}%',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: AppTheme.spacing8.h),
          Text(
            _getScoreDescription(report.overallScore),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadarChart(BuildContext context, AssessmentReport report) {
    return Container(
      height: 300.h,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skill Breakdown',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppTheme.spacing20.h),
          Expanded(
            child: RadarChart(
              RadarChartData(
                radarBackgroundColor: Colors.transparent,
                radarBorderData: BorderSide(color: AppTheme.textDisabled.withOpacity(0.3)),
                gridBorderData: BorderSide(color: AppTheme.textDisabled.withOpacity(0.2)),
                tickBorderData: BorderSide(color: AppTheme.textDisabled.withOpacity(0.2)),
                getTitle: (index, angle) {
                  final skills = ['Pronunciation', 'Grammar', 'Vocabulary', 'Fluency', 'Intonation', 'Interaction'];
                  return RadarChartTitle(
                    text: skills[index],
                    angle: angle,
                  );
                },
                dataSets: [
                  RadarDataSet(
                    dataEntries: [
                      RadarEntry(value: report.skillScores['pronunciation'] ?? 0),
                      RadarEntry(value: report.skillScores['grammar'] ?? 0),
                      RadarEntry(value: report.skillScores['vocabulary'] ?? 0),
                      RadarEntry(value: report.skillScores['fluency'] ?? 0),
                      RadarEntry(value: report.skillScores['intonation'] ?? 0),
                      RadarEntry(value: report.skillScores['interaction'] ?? 0),
                    ],
                    fillColor: AppTheme.primary600.withOpacity(0.2),
                    borderColor: AppTheme.primary600,
                    borderWidth: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMicroSkills(BuildContext context, AssessmentReport report) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Areas for Improvement',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppTheme.spacing16.h),
          ...report.microSkills.map((skill) => Container(
            margin: EdgeInsets.only(bottom: AppTheme.spacing16.h),
            padding: EdgeInsets.all(AppTheme.spacing16.w),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
              border: Border.all(
                color: _getSkillColor(skill.score).withOpacity(0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        skill.name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppTheme.spacing8.w,
                        vertical: AppTheme.spacing4.h,
                      ),
                      decoration: BoxDecoration(
                        color: _getSkillColor(skill.score).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                      ),
                      child: Text(
                        '${skill.score.toInt()}%',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getSkillColor(skill.score),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppTheme.spacing8.h),
                Text(
                  skill.category,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: AppTheme.spacing8.h),
                Text(
                  skill.feedback,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textPrimary,
                  ),
                ),
                SizedBox(height: AppTheme.spacing12.h),
                Wrap(
                  spacing: AppTheme.spacing8.w,
                  children: skill.examples.map((example) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing8.w,
                      vertical: AppTheme.spacing4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.accent500.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                    ),
                    child: Text(
                      example,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.accent500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildRecommendations(BuildContext context, AssessmentReport report) {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacing20.w),
      decoration: BoxDecoration(
        color: AppTheme.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        border: Border.all(color: AppTheme.success.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: AppTheme.success,
                size: 24.w,
              ),
              SizedBox(width: AppTheme.spacing12.w),
              Text(
                'Recommendations',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppTheme.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacing16.h),
          ...report.recommendations.map((recommendation) => Padding(
            padding: EdgeInsets.only(bottom: AppTheme.spacing8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6.w,
                  height: 6.h,
                  margin: EdgeInsets.only(top: AppTheme.spacing8.h),
                  decoration: BoxDecoration(
                    color: AppTheme.success,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: AppTheme.spacing12.w),
                Expanded(
                  child: Text(
                    recommendation,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton.icon(
            onPressed: () {
              // Add to learning plan
            },
            icon: const Icon(Icons.add_task),
            label: const Text('Add to Learning Plan'),
          ),
        ),
        SizedBox(height: AppTheme.spacing12.h),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // Share report
                },
                icon: const Icon(Icons.share),
                label: const Text('Share'),
              ),
            ),
            SizedBox(width: AppTheme.spacing12.w),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // Export PDF
                },
                icon: const Icon(Icons.download),
                label: const Text('Export'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _getScoreDescription(double score) {
    if (score >= 90) return 'Excellent! Outstanding English proficiency';
    if (score >= 80) return 'Very Good! Strong English skills';
    if (score >= 70) return 'Good! Solid foundation with room for improvement';
    if (score >= 60) return 'Fair! Making progress, keep practicing';
    return 'Needs Improvement! Focus on fundamentals';
  }

  Color _getSkillColor(double score) {
    if (score >= 80) return AppTheme.success;
    if (score >= 60) return AppTheme.warning;
    return AppTheme.error;
  }
}