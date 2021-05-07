import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

/// Main Rate my app instance.
RateMyApp _rateMyApp = RateMyApp(
  preferencesPrefix: 'rateMyApp_',
  minDays: 7,
  minLaunches: 10,
  remindDays: 7,
  remindLaunches: 10,
  // appStoreIdentifier: '',
  // googlePlayIdentifier: '',
);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _rateMyApp.init().then((_) {
      _rateMyApp.conditions.forEach((condition) {
        if (condition is DebuggableCondition) {
          print(condition.valuesAsString());
          // We iterate through our list of conditions and we print all debuggable ones.
        }
      });

      print('Are all conditions met ? ' +
          (_rateMyApp.shouldOpenDialog ? 'Yes' : 'No'));

      if (_rateMyApp.shouldOpenDialog) _buildShowStarRateDialog(context);
    });
  }

  _buildShowStarRateDialog(BuildContext context) {
    _rateMyApp.showStarRateDialog(context, actionsBuilder: (_, count) {
      final Widget cancelButton = RateMyAppNoButton(
        // We create a custom "Cancel" button using the RateMyAppNoButton class.
        _rateMyApp,
        text: 'CANCEL',
        callback: () => setState(() {}),
      );
      if (count == null || count == 0) {
        // If there is no rating (or a 0 star rating), we only have to return our cancel button.
        return [cancelButton];
      }

      // Otherwise we can do some little more things...
      String message = 'You\'ve put ' + count.round().toString() + ' star(s). ';
      Color color;
      switch (count.round()) {
        case 1:
          message += 'Did this app hurt you physically ?';
          color = Colors.red;
          break;
        case 2:
          message += 'That\'s not really cool man.';
          color = Colors.orange;
          break;
        case 3:
          message += 'Well, it\'s average.';
          color = Colors.yellow;
          break;
        case 4:
          message += 'This is cool, like this app.';
          color = Colors.lime;
          break;
        case 5:
          message += 'Great ! <3';
          color = Colors.green;
          break;
      }

      return [
        FlatButton(
          child: const Text('OK'),
          onPressed: () async {
            print(message);
            // Toast.show(message, context,
            //     duration: Toast.LENGTH_LONG, gravity: Toast.TOP);

            // This allow to mimic a click on the default "Rate" button and thus update the conditions based on it ("Do not open again" condition for example) :
            await _rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
            Navigator.pop<RateMyAppDialogButton>(
                context, RateMyAppDialogButton.rate);

            setState(() {});
          },
        ),
        cancelButton,
      ];
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}