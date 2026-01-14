import 'package:flutter/material.dart';
import 'package:my_flutter_app/home/widgets/home_screen.dart';
import 'package:provider/provider.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewmodel>();

    return Scaffold(
 
      body: Center(
        child: vm.isLoading
            ? const CircularProgressIndicator()
            : vm.currentUser != null
                ? HomeScreen()
                    
                  
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (vm.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            vm.errorMessage!,
                            style:
                                const TextStyle(color: Colors.red),
                          ),
                        ),
                      FilledButton.icon(
                        onPressed: vm.loginWithSpotify,
                        icon: Icon(Icons.music_note),
                        label: Text("Login with Spotify"),
                        style: FilledButton.styleFrom(
                          backgroundColor:  Colors.redAccent.shade400,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24,
                          vertical: 14),
                          shape : RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5, 
                          ),
                          
                          ),
                          
        
                        
                       
                      ),
                      
                    ],
                  ),
      ),
    );
  }
}
