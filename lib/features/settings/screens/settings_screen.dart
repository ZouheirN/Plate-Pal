import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gap/gap.dart';
import 'package:platepal/main.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import '../hive/settings_box.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final updater = ShorebirdUpdater();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ListTile(
              title: Text(
                'Theme Settings',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: SettingsBox.listenable(),
              builder: (context, box, child) {
                final isMaterialYou = SettingsBox.useMaterialYou;
                final isAmoledBlack = SettingsBox.useAmoledBlack;

                return Column(
                  children: [
                    AbsorbPointer(
                      absorbing: isMaterialYou,
                      child: Opacity(
                        opacity: isMaterialYou ? 0.5 : 1,
                        child: ListTile(
                          title: const Text('Theme Color'),
                          subtitle: const Text(
                              'Tap to change, hold to reset to default'),
                          trailing: CircleAvatar(
                            backgroundColor: SettingsBox.themeColor,
                          ),
                          onLongPress: () {
                            SettingsBox.themeColor = Colors.red;
                          },
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Pick a color!'),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: SettingsBox.themeColor,
                                    onColorChanged: (color) {
                                      SettingsBox.themeColor = color;
                                    },
                                  ),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text('Got it'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SwitchListTile(
                      title: const Text('Use Material You'),
                      value: SettingsBox.useMaterialYou,
                      onChanged: (value) {
                        SettingsBox.useMaterialYou = value;
                      },
                    ),
                    AbsorbPointer(
                      absorbing: isAmoledBlack,
                      child: Opacity(
                        opacity: isAmoledBlack ? 0.5 : 1,
                        child: SwitchListTile(
                          title: const Text('Dark mode'),
                          value: SettingsBox.darkMode,
                          onChanged: (value) {
                            SettingsBox.darkMode = value;
                          },
                        ),
                      ),
                    ),
                    SwitchListTile(
                      title: const Text('Use AMOLED Black'),
                      value: SettingsBox.useAmoledBlack,
                      onChanged: (value) {
                        SettingsBox.useAmoledBlack = value;
                        if (value) {
                          SettingsBox.darkMode = true;
                        }
                      },
                    ),
                  ],
                );
              },
            ),
            const Divider(
              endIndent: 15,
              indent: 15,
            ),
            ListTile(
              title: const Text('Check for updates'),
              subtitle: const Text('Auto-update is enabled by default'),
              onTap: () async {
                try {
                  final status = await updater.checkForUpdate();

                  if (!mounted) return;

                  switch (status) {
                    case UpdateStatus.upToDate:
                      _showNoUpdateAvailableBanner();
                    case UpdateStatus.outdated:
                      _showUpdateAvailableBanner();
                    case UpdateStatus.restartRequired:
                      _showRestartBanner();
                    case UpdateStatus.unavailable:
                  }
                } catch (error) {
                  logger.e('Error checking for update: $error');
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void _showDownloadingBanner() {
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        const MaterialBanner(
          content: Text('Downloading...'),
          actions: [
            SizedBox(
              height: 14,
              width: 14,
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
  }

  void _showUpdateAvailableBanner() {
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          content: const Text(
            'Update available for download',
          ),
          actions: [
            TextButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                await _downloadUpdate();
                if (!mounted) return;
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text('Download'),
            ),
          ],
        ),
      );
  }

  void _showNoUpdateAvailableBanner() {
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          content: const Text(
            'No update available',
          ),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text('Dismiss'),
            ),
          ],
        ),
      );
  }

  void _showRestartBanner() {
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          content: const Text('Update downloaded! Please restart your app.'),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text('Dismiss'),
            ),
          ],
        ),
      );
  }

  void _showErrorBanner(Object error) {
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          content: Text(
            'An error occurred while downloading the update: $error.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text('Dismiss'),
            ),
          ],
        ),
      );
  }

  Future<void> _downloadUpdate() async {
    _showDownloadingBanner();
    try {
      await updater.update();
      _showRestartBanner();
    } on UpdateException catch (error) {
      _showErrorBanner(error.message);
    }
  }
}
