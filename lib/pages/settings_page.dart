import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/language.dart';
import 'package:weather_app/theme/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //dark mode
                Text(AppLocalizations.of(context)!.darkMode,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                //switch toggle
                Switch(
                  value: Provider.of<ThemeProvider>(context, listen: false)
                      .isDarkMode,
                  onChanged: (value) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //dark mode
                Text(AppLocalizations.of(context)!.languagePick,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                //language button
                DropdownButton<Language>(
                  hint: Text(""),
                  underline: const SizedBox(),
                  icon: const Icon(
                    Icons.menu,
                    size: 40,
                  ), // Icon
                  onChanged: (Language? language) {
                    // TODO: to call change language method
                  },
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>(
                        (e) => DropdownMenuItem<Language>(
                          value: e,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                e.flag,
                                style: const TextStyle(fontSize: 30),
                              ), // Text
                              Text(e.name),
                            ], // <Widget> []
                          ), // Row
                        ),
                      ) // DropdownMenuItem
                      .toList(),
                ), // DropdownButton
              ],
            ),
          ),
        ],
      ),
    );
  }
}
