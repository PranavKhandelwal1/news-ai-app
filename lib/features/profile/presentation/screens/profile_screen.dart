import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_assistant/features/profile/presentation/screens/Widgets/customProfileOptions.dart';

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
        padding: const EdgeInsets.all(20),
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
                  "Angelika",
                  // user?.displayName ??"New User",
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

            CustomProfileOptions(title: 'Bookmark', trailing: Icon(Icons.arrow_forward_ios,size: 15)),

            // SizedBox(height: 20),

            CustomProfileOptions(title: 'History', trailing: Icon(Icons.arrow_forward_ios,size: 15)),

            // SizedBox(height: 20),

            // Display
            CustomProfileOptions(title: 'Display settings', trailing: Icon(Icons.arrow_forward_ios,size: 15)),

            // SizedBox(height: 20),

            // Customize
            CustomProfileOptions(title: 'Customize your feed', trailing: Icon(Icons.arrow_forward_ios,size: 15)),

            // SizedBox(height: 20),

            // Notification
            CustomProfileOptions(title: 'Notification',
                trailing: Transform.scale(
                  scale: 0.8, // smaller size
                  child: Switch(
                    value: notifications,
                    activeColor: Colors.black,
                    activeTrackColor: Colors.black54,
                    inactiveThumbColor: Colors.black,
                    inactiveTrackColor: Colors.grey,
                    onChanged: (value) {
                      //TODO
                    },
                  ),
                )
            ),

            // Region
            CustomProfileOptions(
              title: "Region",
              trailing: DropdownButton<String>(
                value: selectedRegion,
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(
                    value: "IND",
                    child: Text("IND"),
                  ),
                  DropdownMenuItem(
                    value: "USA",
                    child: Text("USA"),
                  ),
                ],
                onChanged: (value) {
                  // TODO Toggle
                },
              ),
            ),

            // News Language
            CustomProfileOptions(
              title: "News Language",
              trailing: DropdownButton<String>(
                value: selectedLanguage,
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(
                    value: "English",
                    child: Text("English"),
                  ),
                  DropdownMenuItem(
                    value: "Hindi",
                    child: Text("Hindi"),
                  ),
                ],
                onChanged: (value) {
                  // TODO
                },
              ),
            ),


            // AI Voice
            CustomProfileOptions(title: 'AI Voice', trailing: Icon(Icons.arrow_forward_ios,size: 15)),

            // SizedBox(height: 20),

            // Contact and Support
            CustomProfileOptions(title: 'Contact and Support', trailing: Icon(Icons.arrow_forward_ios,size: 15)),

            // SizedBox(height: 20),

            CustomProfileOptions(title: 'Sign out', trailing: Icon(Icons.logout,size: 20, color: Colors.red)),

          ],
        ),
      ),
    );
  }
}