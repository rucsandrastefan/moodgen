import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewmodel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: vm.isLoading
            ? const CircularProgressIndicator()
            : vm.currentUser != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (vm.currentUser!.avatarUrl != null)
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            vm.currentUser!.avatarUrl!,
                          ),
                        ),
                      const SizedBox(height: 12),
                      Text(
                        vm.currentUser!.displayName,
                        style: const TextStyle(fontSize: 18),
                      ),
                      if (vm.currentUser!.email != null)
                        Text(vm.currentUser!.email!),
                        ElevatedButton(onPressed: vm.logout, child: Text("Logout button"),),
                    ],
                  )
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
                      ElevatedButton(
                        onPressed: vm.loginWithSpotify,
                        child:
                            const Text("Login with Spotify"),
                      ),
                      
                    ],
                  ),
      ),
    );
  }
}
