import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_assistant/features/profile/presentation/screens/Widgets/customProfileOptions.dart';

import '../../../auth/presentation/screens/login_screen.dart';
import '../../../bookmarks/presentation/screens/bookmarks_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool notifications = true;
    String selectedRegion = "IND";
    String selectedLanguage = "English";
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  Text(
            "Profile",
            style: TextStyle(
                fontWeight: FontWeight.bold
            )
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                // Profile
                const CircleAvatar(
                  radius: 25,
                  child: Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 15),

                // User Name
                Text(
                  // "Angelika",
                  user?.displayName ??"New User",
                  style: TextStyle(
                      fontSize:18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // User Email
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                user?.email ??"No email",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 18,
                ),
              ),
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Free account",
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black, // fill color
                    side: BorderSide(
                      color: Colors.black, // outline color
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // makes it square
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                  ),
                  child: Text(
                    'Get premium',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            // SizedBox(height: 10),

            // Bookmark
            CustomProfileOptions(
              icon: Icons.bookmark,
              title: "Bookmarks",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BookmarksScreen(),
                  ),
                );
              },
            ),

            // History
            CustomProfileOptions(
              icon: Icons.history,
              title: "History",
              onTap: () {
                // TODO
              },
            ),
            // Display
            CustomProfileOptions(
              icon: Icons.settings_display,
              title: "Display settings",
              onTap: () {
                // todo
              },
            ),

            // Customize
            CustomProfileOptions(
              icon: Icons.dashboard_customize_outlined,
              title: "Customize your feed",
              onTap: () {
                // TODO
              },
            ),
            // SizedBox(height: 20),

            // Notification

            CustomProfileOptions(icon: Icons.notifications, title: 'Notification', onTap: (){

            }),

            // Region
            CustomProfileOptions(
              icon: Icons.location_on,
              title: "Region",
              onTap: () {
                // TODO
              },
            ),


            // News Language
            CustomProfileOptions(
              icon: Icons.language,
              title: "News Language",
              onTap: () {
                // TODO
              },
            ),


            // AI Voice
            CustomProfileOptions(
              icon: Icons.settings_voice,
              title: "AI Voice",
              onTap: () {
                // TODO
              },
            ),
            // SizedBox(height: 20),

            // Contact and Support
            CustomProfileOptions(
              icon: Icons.contact_phone,
              title: "Contact and Support",
              onTap: () {
                // TODO
              },
            ),
            // Sign out
            CustomProfileOptions(
              icon: Icons.logout, color: Colors.red,
              title: "Sign out",
              onTap: () async {
                await FirebaseAuth.instance.signOut();

                if (!context.mounted) return;

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                      (route) => false,
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}