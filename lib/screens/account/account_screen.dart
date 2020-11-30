import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/screens/login/login_screen.dart';
import 'package:e_commerce_app/services/auth-services.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:e_commerce_app/widgets/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  static String routeName = "/account";

  final _authService = AuthService();

  List<Map<String, dynamic>> items = [
    {
      "title": "Orders",
    },
    {
      "title": "Manage Card",
    },
    {
      "title": "Shipping Details",
    },
    {
      "title": "Change Password",
    },
    {
      "title": "Logout",
    },
  ];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return Scaffold(
        appBar: CustomAppBar(
          hasRating: false,
          appBarTitle: "My Account",
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10.0),
          ),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(20.0),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: SvgPicture.asset(
                    "assets/icons/User.svg",
                    width: 100,
                    height: 100,
                  ),
                ),
                title: Text(user == null ? '' : user.name),
                subtitle: Text(user == null ? '' : user.email),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => displayModalBottomSheet(context),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(30.0),
              ),
              ...List.generate(
                items.length,
                (index) => buildAccountTile(index, context),
              )
            ],
          ),
        ));
  }

  ListTile buildAccountTile(int index, BuildContext context) {
    return ListTile(
        selected: false,
        leading: Text(
          items[index]["title"],
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
            fontSize: getProportionateScreenWidth(18.0),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.black54,
        ),
        onTap: () async {
          if (index == 4) {
            await _authService.signOut();
            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName,
                (Route<dynamic> route) => false);
          }
        });
  }

  void displayModalBottomSheet(BuildContext context) {
    showBarModalBottomSheet(
      backgroundColor: Colors.green,
      context: context,
      builder: (context) => Column(
        // direction: Axis.vertical,
        children: <Widget>[
          ListTile(
              leading: new Icon(Icons.music_note),
              title: new Text('Music'),
              onTap: () => {}),
          ListTile(
            leading: new Icon(Icons.videocam),
            title: new Text('Video'),
            onTap: () => {},
          ),
          TextField()
        ],
      ),
    );
  }
}
