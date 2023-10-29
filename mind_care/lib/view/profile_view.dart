import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mind_care/models/user_profile.dart';
import 'package:mind_care/viewModel/provider/user_profile_provider.dart';
import 'package:provider/provider.dart';

class ApiPage extends StatefulWidget {
  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data dari API'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => UserProfileProvider(),
        child: Consumer<UserProfileProvider>(
            builder: (context, userProfileProvider, child) {
          if (userProfileProvider.items.isEmpty) {
            userProfileProvider.fetchUserProfile();
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: userProfileProvider.items.length,
              itemBuilder: (context, index) {
                // UserProfileModel userProfile = userProfileProvider.items[index];
                return ListTile(
                  title: Text(userProfileProvider.items[index].name),
                  subtitle: Text(userProfileProvider.items[index].name),
                );
              },
            );
          }
          // Here, you can access the UserProfileProvider instance to get data.
          //    return YourContentWidget(userProfileProvider: userProfileProvider);
        }),
      ),
    );
  }
}
