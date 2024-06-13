import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:my_app/src/features/data/register/user.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:twitter_login/twitter_login.dart';

class UserAPI {
  final SmsAutoFill _autoFill = SmsAutoFill();

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/user.json');
  }

  Future<List<UserModel>> fetchUsers() async {
    try {
      final file = await _getLocalFile();
      if (await file.exists()) {
        // Nếu tệp tồn tại, đọc dữ liệu từ tệp
        final contents = await file.readAsString();
        final data = json.decode(contents);
        final List<dynamic> usersJson = data['users'];
        return usersJson.map((json) => UserModel.fromJson(json)).toList();
      } else {
        // Nếu tệp không tồn tại, tải từ tệp assets
        final String response =
            await rootBundle.loadString('lib/src/services/mock/user/user.json');
        final data = json.decode(response);
        final List<dynamic> usersJson = data['users'];

        // Lưu dữ liệu tải được từ file JSON vào tệp tạm
        await file.writeAsString(jsonEncode({'users': usersJson}));

        return usersJson.map((json) => UserModel.fromJson(json)).toList();
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  Future<void> registerUser(UserModel newUser) async {
    try {
      List<UserModel> users = await fetchUsers();

      // Add new users to the list
      users.add(newUser);

      // Convert user list to JSON
      List<Map<String, dynamic>> usersJson =
          users.map((user) => user.toJson()).toList();
      String updatedJson = jsonEncode({'users': usersJson});

      // Write updated JSON to temporary file
      final file = await _getLocalFile();
      await file.writeAsString(updatedJson);
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  Future<void> checkFacebookIsSignUp() async {
    try {
      final accessToken = await FacebookAuth.instance.accessToken;
      if (accessToken != null) {
        // Get user information using accessToken
        final userData = await FacebookAuth.instance.getUserData();

        // Create a UserModel object from user data
        final UserModel user = UserModel(
          id: userData['id'],
          username: userData['name'],
          email: userData['email'],
          phone: '', // Fill in phone information if any
          password: 'null',
        );

        // Check if the user already exists in the database
        List<UserModel> users = await fetchUsers();
        bool userExists = users.any((u) => u.id == user.id);

        if (!userExists) {
          // If the user does not exist, register the user
          await registerUser(user);
        }

        // Perform necessary actions once the user is logged in
        // For example, redirect to home page or update application status
        // ...
      } else {
        // If accessToken is null, request Facebook login
        await signUpByFacebook();
      }
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  Future<void> signUpByFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final requestData = await FacebookAuth.i.getUserData();
        final completePhoneNumber = await _autoFill.hint;
        final UserModel newUser = UserModel(
            id: requestData['id'],
            username: requestData['name'],
            email: requestData['email'],
            phone: completePhoneNumber ?? '+1 650 555-6789',
            password: 'null');

        // Save user information to a JSON file
        await registerUser(newUser);
      }
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  Future<void> logout() async {
    await FacebookAuth.instance.logOut();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      // Get mobile number

      if (googleUser == null) {
        // User cancels login
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // can use googleAuth to login with Firebase or backend
      final String? idToken = googleAuth.idToken;
      final String? accessToken = googleAuth.accessToken;
      final completePhoneNumber = await _autoFill.hint;

      // Tạo UserModel từ thông tin của googleUser
      final UserModel newUser = UserModel(
          id: googleUser.id,
          username: googleUser.displayName.toString(),
          email: googleUser.email,
          phone: completePhoneNumber ?? '+1 650 555-6789',
          password: 'null');

      // Save user information to a JSON file
      await registerUser(newUser);
    } catch (e) {
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  Future<void> signOutFromGoogle() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      throw Exception('Failed to sign out from Google: $e');
    }
  }

  Future<void> signInWithTwitter() async {
    try {
      const authTokenHere = 'zsqpk7yFbDAWpHsmP86YqePfHqt0HDvIp4tdQHstlDWox';
      final twitterLogin = TwitterLogin(
        // Consumer API keys
        apiKey: 'nlFLIVU9eOPfjtTjk5uBXOGPn',
        // Consumer API Secret keys
        apiSecretKey: '2fnLjnJisp38kHRV9sa5K9DqeJ5k07FqOaLTyRf3esGL7UQNlQ',
        // Registered Callback URLs in TwitterApp
        // Android is a deeplink
        // iOS is a URLScheme
        redirectURI: 'https://twitter.com/i/oauth2/authorize',
      );

      // Await the Future to get the actual AuthResult
      final authResult = await twitterLogin.loginV2();

      if (authResult.status == TwitterLoginStatus.loggedIn) {
        final user = authResult.user;
        final completePhoneNumber = await _autoFill.hint;
        final UserModel newUser = UserModel(
          id: user!.id.toString(),
          username: user.name,
          email: user.email!,
          phone: completePhoneNumber ?? '+1 650 555-6789',
          password: 'null',
        );

        // Save user information to a JSON file
        await registerUser(newUser);
      } else if (authResult.status == TwitterLoginStatus.cancelledByUser) {
        throw Exception('Failed to sign in with Twitter');
      } else if (authResult.status == TwitterLoginStatus.error) {
        throw Exception('Failed to sign in with Twitter');
      }
    } catch (e) {
      throw Exception('Failed to sign in with Twitter: $e');
    }
  }
}
