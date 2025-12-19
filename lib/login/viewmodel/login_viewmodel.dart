import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:my_flutter_app/models/user.dart';
import 'package:my_flutter_app/services/auth_service.dart';
import 'package:my_flutter_app/services/spotify_service.dart';
import 'package:my_flutter_app/services/user_service.dart';
import 'package:oauth2_client/spotify_oauth2_client.dart';
import 'package:oauth2_client/access_token_response.dart';



class LoginViewmodel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  String? accessToken;

  AppUser? currentUser;

  final AuthService authService = AuthService();
 

  final String clientId = "e128658cf3474ee3ac6fb9bf60f35aae";

  final SpotifyService _spotifyService = SpotifyService();
  final UserService _userService = UserService();
  


  Future<void> loginWithSpotify() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final redirectUri = kIsWeb
          ? 'http://127.0.0.1:5000/callback'
          : 'playlistgen://callback';

      final client = SpotifyOAuth2Client(
        redirectUri: redirectUri,
        customUriScheme: kIsWeb ? 'http' : 'playlistgen',
      );

      // 1️⃣ Spotify login
      AccessTokenResponse tokenResp =
          await client.getTokenWithAuthCodeFlow(
        clientId: clientId,
        scopes: ['user-read-private', 'user-read-email'],
      );

      if (!tokenResp.isValid()) {
        throw Exception(tokenResp.errorDescription);
      }

      accessToken = tokenResp.accessToken;

      final profile =
          await _spotifyService.fetchProfile(accessToken!);

 
      final user = AppUser.fromSpotify(profile);


      currentUser = await _userService.createOrGetUser(user);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  Future<void> logout() async {
    isLoading = true;
    notifyListeners();
    await authService.logout();
    accessToken = null;
    currentUser = null;

    isLoading = false;
    notifyListeners();
    

  }
}
