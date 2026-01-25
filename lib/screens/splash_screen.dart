import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.8, curve: Curves.elasticOut),
      ),
    );

    _animationController.forward();

    Future.delayed(
      Duration(milliseconds: 2500),
      () => {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge),
        Get.off(
          () => HomeScreen(),
          transition: Transition.fadeIn,
          duration: Duration(milliseconds: 500),
        ),
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              Color(0xFF1A1A2E).withValues(alpha: 0.3),
              Color(0xFF0A0A0A),
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 180.w,
                      height: 180.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.blueAccent.withValues(alpha: 0.3),
                            Colors.blueAccent.withValues(alpha: 0.1),
                            Colors.transparent,
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ),
                      ),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.blueAccent.withValues(alpha: 0.2),
                                Colors.blueAccent.withValues(alpha: 0.05),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueAccent.withValues(alpha: 0.3),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.shield_rounded,
                            size: 80.sp,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // App name
                    Text(
                      'Nexas VPN',
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Tagline
                    Text(
                      'Secure & Private Connection',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white54,
                        letterSpacing: 0.5,
                      ),
                    ),

                    SizedBox(height: 60.h),

                    // Loading indicator
                    SizedBox(
                      width: 30.w,
                      height: 30.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.blueAccent.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
