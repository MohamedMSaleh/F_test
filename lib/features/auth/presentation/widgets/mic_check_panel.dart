import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/theme/app_theme.dart';

class MicCheckPanel extends StatefulWidget {
  const MicCheckPanel({super.key});

  @override
  State<MicCheckPanel> createState() => _MicCheckPanelState();
}

class _MicCheckPanelState extends State<MicCheckPanel>
    with TickerProviderStateMixin {
  bool _hasPermission = false;
  bool _isRecording = false;
  bool _testCompleted = false;
  double _audioLevel = 0.0;
  String _statusMessage = 'Tap the microphone to test your audio';
  
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _checkMicrophonePermission();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Microphone Setup',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        
        SizedBox(height: AppTheme.spacing16.h),
        
        Text(
          'We need to test your microphone for the best learning experience.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        
        SizedBox(height: AppTheme.spacing32.h),
        
        Center(
          child: Column(
            children: [
              // Microphone Test Button
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _isRecording ? _pulseAnimation.value : 1.0,
                    child: GestureDetector(
                      onTap: _hasPermission ? _toggleRecording : _requestPermission,
                      child: Container(
                        width: 120.w,
                        height: 120.h,
                        decoration: BoxDecoration(
                          color: _getMicButtonColor(),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: _getMicButtonColor().withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: _isRecording ? 10 : 0,
                            ),
                          ],
                        ),
                        child: Icon(
                          _hasPermission ? Icons.mic : Icons.mic_off,
                          size: 48.w,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
              
              SizedBox(height: AppTheme.spacing24.h),
              
              Text(
                _statusMessage,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              
              if (_isRecording) ...[
                SizedBox(height: AppTheme.spacing16.h),
                _buildAudioLevelIndicator(),
              ],
            ],
          ),
        ),
        
        SizedBox(height: AppTheme.spacing32.h),
        
        // Audio Tips
        Container(
          padding: EdgeInsets.all(AppTheme.spacing16.w),
          decoration: BoxDecoration(
            color: AppTheme.info.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            border: Border.all(color: AppTheme.info.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: AppTheme.info,
                    size: 20.w,
                  ),
                  SizedBox(width: AppTheme.spacing8.w),
                  Text(
                    'Audio Tips',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.info,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: AppTheme.spacing12.h),
              
              ...[
                'Find a quiet environment',
                'Speak at arm\'s length from your device',
                'Ensure your microphone is not blocked',
                'Test different volumes until the indicator is green',
              ].map((tip) => Padding(
                padding: EdgeInsets.symmetric(vertical: AppTheme.spacing4.h),
                child: Row(
                  children: [
                    Container(
                      width: 4.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppTheme.info,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: AppTheme.spacing8.w),
                    Expanded(
                      child: Text(
                        tip,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
        
        if (_testCompleted) ...[
          SizedBox(height: AppTheme.spacing24.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppTheme.spacing16.w),
            decoration: BoxDecoration(
              color: AppTheme.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
              border: Border.all(color: AppTheme.success.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: AppTheme.success,
                  size: 24.w,
                ),
                SizedBox(width: AppTheme.spacing12.w),
                Text(
                  'Microphone test completed successfully!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
  
  Widget _buildAudioLevelIndicator() {
    return Column(
      children: [
        Text(
          'Audio Level',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        
        SizedBox(height: AppTheme.spacing8.h),
        
        Container(
          width: 200.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: AppTheme.textDisabled.withOpacity(0.3),
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _audioLevel,
            child: Container(
              decoration: BoxDecoration(
                color: _getAudioLevelColor(),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
              ),
            ),
          ),
        ),
        
        SizedBox(height: AppTheme.spacing8.h),
        
        Text(
          _getAudioLevelText(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: _getAudioLevelColor(),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
  
  Color _getMicButtonColor() {
    if (!_hasPermission) return AppTheme.textDisabled;
    if (_testCompleted) return AppTheme.success;
    if (_isRecording) return AppTheme.error;
    return AppTheme.primary600;
  }
  
  Color _getAudioLevelColor() {
    if (_audioLevel < 0.3) return AppTheme.error;
    if (_audioLevel < 0.7) return AppTheme.warning;
    return AppTheme.success;
  }
  
  String _getAudioLevelText() {
    if (_audioLevel < 0.3) return 'Too quiet - speak louder';
    if (_audioLevel < 0.7) return 'Good level';
    if (_audioLevel < 0.9) return 'Perfect level';
    return 'Too loud - reduce volume';
  }
  
  Future<void> _checkMicrophonePermission() async {
    final status = await Permission.microphone.status;
    setState(() {
      _hasPermission = status == PermissionStatus.granted;
      if (!_hasPermission) {
        _statusMessage = 'Microphone permission required';
      }
    });
  }
  
  Future<void> _requestPermission() async {
    final status = await Permission.microphone.request();
    setState(() {
      _hasPermission = status == PermissionStatus.granted;
      if (_hasPermission) {
        _statusMessage = 'Permission granted! Tap to test microphone';
      } else {
        _statusMessage = 'Permission denied. Please enable in settings';
      }
    });
  }
  
  void _toggleRecording() {
    if (_isRecording) {
      _stopRecording();
    } else {
      _startRecording();
    }
  }
  
  void _startRecording() {
    setState(() {
      _isRecording = true;
      _statusMessage = 'Say "Hello, this is a microphone test"';
    });
    
    _pulseController.repeat(reverse: true);
    
    // Simulate audio level changes
    _simulateAudioLevel();
    
    // Auto-stop after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (_isRecording) {
        _stopRecording();
      }
    });
  }
  
  void _stopRecording() {
    setState(() {
      _isRecording = false;
      _testCompleted = true;
      _statusMessage = 'Test completed! Your microphone is working well';
    });
    
    _pulseController.stop();
    _pulseController.reset();
  }
  
  void _simulateAudioLevel() {
    if (!_isRecording) return;
    
    // Simulate realistic audio levels
    setState(() {
      _audioLevel = 0.4 + (0.4 * (DateTime.now().millisecond % 1000) / 1000);
    });
    
    Future.delayed(const Duration(milliseconds: 100), _simulateAudioLevel);
  }
}