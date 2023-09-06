import 'package:flutter/material.dart';
import 'package:iquiz_flutter/pages/home_page.dart';
import 'package:iquiz_flutter/providers/audio_provider.dart';
import 'package:iquiz_flutter/widgets/custom_drawer_button.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  void showSettingsDialog(BuildContext context) {
    Alert(
      context: context,
      useRootNavigator: true,
      content: Column(
        children: [
          const Divider(thickness: 2, color: Colors.white),
          ListTile(
            title: Text(
              "BG Music",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20 / MediaQuery.of(context).textScaleFactor,
              ),
            ),
            trailing: Consumer<AudioProvider>(
              builder: (context, provider, child) {
                return IconButton(
                  onPressed: () {
                    provider.checkMusicSettings();
                  },
                  icon: Icon(
                    provider.getMusicSettingsIcon(),
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          ListTile(
            title: Text(
              "SFX",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20 / MediaQuery.of(context).textScaleFactor,
              ),
            ),
            trailing: Consumer<AudioProvider>(
              builder: (context, provider, child) {
                return IconButton(
                  onPressed: () {
                    provider.checkSFXSettings();
                  },
                  icon: Icon(
                    provider.getSFXSettingsIcon(),
                    color: Colors.white,
                  ),
                );
              },
            ),
          )
        ],
      ),
      desc: "Settings",
      style: AlertStyle(
        isCloseButton: false,
        isButtonVisible: false,
        backgroundColor: Colors.black54,
        descStyle: TextStyle(
          color: Colors.white,
          fontSize: 30 / MediaQuery.of(context).textScaleFactor,
        ),
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor;

    return Container(
      color: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                'Menu',
                style:
                    TextStyle(fontSize: 50 / scaleFactor, color: Colors.white),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomDrawerButton(
                    buttonText: "Resume",
                    onPress: () => Navigator.pop(context)),
                const SizedBox(height: 30),
                CustomDrawerButton(
                  buttonText: "Settings",
                  onPress: () => showSettingsDialog(context),
                ),
                const SizedBox(height: 30),
                CustomDrawerButton(
                  buttonText: "Home",
                  onPress: () =>
                      Navigator.of(context).pushReplacementNamed(HomePage.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
