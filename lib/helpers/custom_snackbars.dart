import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbars {
  // Private method to create styled snackbars
  static void _showSnackbar({
    required String title,
    required String message,
    required Color startColor,
    required Color endColor,
    required IconData icon,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.transparent,
      titleText: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: startColor.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.95),
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      messageText: const SizedBox.shrink(),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.zero,
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  // Success snackbar - Green gradient
  static void showSuccessSnackBar({required String msg}) {
    _showSnackbar(
      title: 'Success',
      message: msg,
      startColor: const Color(0xFF00C853),
      endColor: const Color(0xFF00E676),
      icon: Icons.check_circle_rounded,
    );
  }

  // Error snackbar - Red gradient
  static void showErrorSnackBar({required String msg}) {
    _showSnackbar(
      title: 'Error',
      message: msg,
      startColor: const Color(0xFFD32F2F),
      endColor: const Color(0xFFEF5350),
      icon: Icons.error_rounded,
    );
  }

  // Info snackbar - Blue gradient
  static void showInfoSnackBar({required String msg}) {
    _showSnackbar(
      title: 'Info',
      message: msg,
      startColor: const Color(0xFF1976D2),
      endColor: const Color(0xFF42A5F5),
      icon: Icons.info_rounded,
    );
  }

  // Warning snackbar - Orange gradient (bonus)
  static void showWarningSnackBar({required String msg}) {
    _showSnackbar(
      title: 'Warning',
      message: msg,
      startColor: const Color(0xFFF57C00),
      endColor: const Color(0xFFFFB74D),
      icon: Icons.warning_rounded,
    );
  }
}
