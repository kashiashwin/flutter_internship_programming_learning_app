/// Holds the currently logged-in user's information across screens.
///
/// Because the app only allows one signed-in user at a time, a simple
/// static (global) holder is enough.  Call [login] right after a
/// successful login / signup, and [logout] when the user signs out /
/// deletes their account.
class SessionManager {
  static String? currentUserEmail;
  static Map<String, dynamic>? currentUser;

  static bool get isLoggedIn => currentUserEmail != null;

  static void login(Map<String, dynamic> user) {
    currentUser = Map<String, dynamic>.from(user);
    currentUserEmail = user['email'] as String?;
  }

  static void updateProfilePhoto(String path) {
    if (currentUser != null) {
      currentUser!['profile_photo'] = path;
    }
  }

  static void logout() {
    currentUser = null;
    currentUserEmail = null;
  }
}
