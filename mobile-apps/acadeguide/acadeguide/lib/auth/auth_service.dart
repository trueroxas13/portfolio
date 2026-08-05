import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  SupabaseClient supabase = Supabase.instance.client;
  final db = Supabase.instance.client.from('user_profile');
  static String? userEmail;
  var email = '';
  //Sign in with email and pass
  Future<AuthResponse> signIn(String email, String password) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  //Sign up
  Future<bool> isTaken(String email, String username) async {
    try {
      final response = await supabase
          .from('user_profile')
          .select('email')
          .eq('email', email.toLowerCase())
          .maybeSingle();

      final usernameResponse = await supabase
          .from('user_profile')
          .select('username')
          .eq('username', username)
          .maybeSingle();

      if (response != null || usernameResponse != null) {
        return true; // Email or username is taken
      } else {
        return false; // Email and username are available
      }
    } catch (e) {
      print('Error checking email: $e');
      return false;
    }
  }

// Use it before signup
  Future<AuthResponse?> signup({
    required String email,
    required String password,
    required String username,
    required String firstname,
    required String lastname,
    required String interests,
  }) async {
    // Check if email is already taken
    final emailExists = await isTaken(email, username);
    if (emailExists) {
      throw Exception('Email or Username already registered');
    }

    final response = await supabase.auth.signUp(
      password: password,
      email: email,
      data: {
        'username': username,
        'firstname': firstname,
        'lastname': lastname,
        'interests': interests,
      },
    );

    if (response.user != null) {
      try {
        await db.insert({
          'id': response.user!.id,
          'email': email.toLowerCase(),
          'username': username,
          'role': false,
        });
      } catch (e) {
        print('Error inserting user profile: $e');
      }
    }

    return response;
  }

  //update user data
  Future<void> updateUserData(
    String username,
    String firstname,
    String lastname,
    String interests,
  ) async {
    final session = supabase.auth.currentSession;
    final user = session?.user;
    if (user != null) {
      await supabase.auth.updateUser(
        UserAttributes(
          data: {
            'username': username,
            'firstname': firstname,
            'lastname': lastname,
            'interests': interests,
          },
        ),
      );
    }
  }

  Future<bool> isAdmin(String userId) async {
    final value = await db.select().eq('id', userId).single();
    return value['role'] == true;
  }

  //Sign out
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  //reset password
  Future<void> resetPassword(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  //updatePassword
  Future<void> updatePassword(String password) async {
    final session = supabase.auth.currentSession;
    if (session != null) {
      await supabase.auth.updateUser(UserAttributes(password: password));
    }
  }

  //send OTP
  Future<void> sendOtp(String email) async {
    await Supabase.instance.client.auth.signInWithOtp(
      email: email.trim(),
      shouldCreateUser: false,
    );
  }

  //verify Otp
  Future<void> verifyOtp(String otp) async {
    await Supabase.instance.client.auth.verifyOTP(
      token: otp.trim(),
      type: OtpType.email,
      email: userEmail!.trim(),
    );
  }

  //Get User
  String? getUser() {
    final session = supabase.auth.currentSession;
    final user = session?.user;
    return user != null ? user.id : '';
  }

  Map? getUserData() {
    final session = supabase.auth.currentSession;
    final user = session?.user;
    final userData = user?.userMetadata;
    return userData;

    // return userData?.values.toList();
  }

  Future<String?> getUsername(String userId) async {
    final user = await supabase.auth.admin.getUserById(userId);
    final userData = user.user?.userMetadata;
    return userData != null ? userData['username'] as String? : null;
  }

  // String? getUserUsername(String userId) {}
}
