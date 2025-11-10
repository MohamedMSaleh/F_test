import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/auth_provider.dart';

class ConsentCard extends StatefulWidget {
  const ConsentCard({super.key});

  @override
  State<ConsentCard> createState() => _ConsentCardState();
}

class _ConsentCardState extends State<ConsentCard> {
  bool _voiceRecording = false;
  bool _dataStorage = false;
  bool _modelImprovement = false;
  bool _biometricProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Privacy & Consent',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        
        SizedBox(height: AppTheme.spacing16.h),
        
        Text(
          'SpeakX uses AI to analyze your speech and provide feedback. Please review and accept the following permissions:',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        
        SizedBox(height: AppTheme.spacing24.h),
        
        Container(
          padding: EdgeInsets.all(AppTheme.spacing16.w),
          decoration: BoxDecoration(
            color: AppTheme.error.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            border: Border.all(color: AppTheme.error.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.security,
                color: AppTheme.error,
                size: 24.w,
              ),
              SizedBox(width: AppTheme.spacing12.w),
              Expanded(
                child: Text(
                  'Voice recordings may contain biometric data. All data is encrypted and stored securely.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: AppTheme.spacing24.h),
        
        _buildConsentItem(
          title: 'Voice Recording & Analysis',
          description: 'Allow SpeakX to record and analyze your voice for pronunciation and fluency feedback.',
          value: _voiceRecording,
          required: true,
          onChanged: (value) {
            setState(() {
              _voiceRecording = value ?? false;
            });
          },
        ),
        
        _buildConsentItem(
          title: 'Data Storage',
          description: 'Store your voice recordings and analysis results securely with encryption and hashed IDs.',
          value: _dataStorage,
          required: true,
          onChanged: (value) {
            setState(() {
              _dataStorage = value ?? false;
            });
          },
        ),
        
        _buildConsentItem(
          title: 'Model Improvement',
          description: 'Anonymously contribute to improving AI models for Egyptian English learners (optional).',
          value: _modelImprovement,
          required: false,
          onChanged: (value) {
            setState(() {
              _modelImprovement = value ?? false;
            });
          },
        ),
        
        _buildConsentItem(
          title: 'Biometric Processing',
          description: 'Process voice patterns that may be considered biometric data for personalized feedback.',
          value: _biometricProcessing,
          required: true,
          onChanged: (value) {
            setState(() {
              _biometricProcessing = value ?? false;
            });
          },
        ),
        
        SizedBox(height: AppTheme.spacing24.h),
        
        Row(
          children: [
            Icon(
              Icons.info_outline,
              color: AppTheme.info,
              size: 20.w,
            ),
            SizedBox(width: AppTheme.spacing8.w),
            Expanded(
              child: Text(
                'You can modify these settings anytime in your privacy preferences.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.info,
                ),
              ),
            ),
          ],
        ),
        
        SizedBox(height: AppTheme.spacing16.h),
        
        TextButton(
          onPressed: () {
            // Show privacy policy
          },
          child: const Text('Read Full Privacy Policy'),
        ),
        
        const Spacer(),
        
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: _canProceed() ? _saveConsent : null,
            child: const Text('Accept & Continue'),
          ),
        ),
      ],
    );
  }
  
  Widget _buildConsentItem({
    required String title,
    required String description,
    required bool value,
    required bool required,
    required ValueChanged<bool?> onChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.spacing16.h),
      padding: EdgeInsets.all(AppTheme.spacing16.w),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        border: Border.all(
          color: value 
            ? AppTheme.primary600.withOpacity(0.3)
            : AppTheme.textDisabled.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (required)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.spacing8.w,
                    vertical: AppTheme.spacing4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                  ),
                  child: Text(
                    'Required',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              SizedBox(width: AppTheme.spacing8.w),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: AppTheme.primary600,
              ),
            ],
          ),
          
          SizedBox(height: AppTheme.spacing8.h),
          
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
  
  bool _canProceed() {
    return _voiceRecording && _dataStorage && _biometricProcessing;
  }
  
  void _saveConsent() {
    final consentSettings = ConsentSettings(
      voiceRecording: _voiceRecording,
      dataStorage: _dataStorage,
      modelImprovement: _modelImprovement,
      biometricProcessing: _biometricProcessing,
    );
    
    context.read<AuthProvider>().updateConsent(consentSettings);
  }
}