import 'package:flutter/material.dart';
import 'package:my_flutter_app/login/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget{

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    final vm = context.watch<LoginViewmodel>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('This is the home page'),
          FilledButton(onPressed: vm.logout, child: const  Text('Logout')),
          SizedBox(height: 10,),
          Text(
            vm.currentUser!.displayName,
            style: const TextStyle(fontSize: 16),
          ),
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              vm.currentUser!.avatarUrl!,
            ),
          ),
        ],
      ),
    );
  }
}