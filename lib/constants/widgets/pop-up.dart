import 'package:Trackpatrol/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum SampleItem { Logout }

class PopUp extends StatefulWidget {
  const PopUp({super.key});

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PopupMenuButton<SampleItem>(
        initialValue: selectedMenu,
        // Callback that sets the selected popup menu item.
        onSelected: (SampleItem item) async {
          setState(() {
            selectedMenu = item;
          });
          await Provider.of<AuthProvider>(context, listen: false)
              .logout(context);
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
          const PopupMenuItem<SampleItem>(
            value: SampleItem.Logout,
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
