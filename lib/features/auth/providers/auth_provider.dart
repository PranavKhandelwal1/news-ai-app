import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_service.dart';

/// Makes AuthService available throughout the app.
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
