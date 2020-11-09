import 'package:e_commerce_app/screens/login/login_screen.dart';
import 'package:e_commerce_app/utilities/constants.dart';
import 'package:e_commerce_app/utilities/size_config.dart';
import 'package:e_commerce_app/widgets/default_button.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to EasyBuy, Let's shop! ",
      "image": "assets/images/splash_1.png",
    },
    {
      "text": "We help people connect with store \naround Nigeria and Africa",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
            children: [
              Expanded(
                flex: 3,
//              child:SizedBox(),
                child: PageView.builder(
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        itemCount: splashData.length,
        itemBuilder: (context, index) => SplashContent(
          text: splashData[index]["text"],
          image: splashData[index]["image"],
        ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20.0)),
        child: Column(children: <Widget>[
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              splashData.length,
              (index) => buildDot(index: index),
            ),
          ),
          Spacer(flex: 3),
          DefaultButton(
            text: "Continue",
            onPressed: (){
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
          ),
          Spacer(),
        ]),
                ),
              )
            ],
          ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5.0),
      height: 6,
      width: currentPage == index ? 20.0 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(13),
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);

  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Text(
          "EasyBuy",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(text, textAlign: TextAlign.center),
        Spacer(flex: 2),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        )
      ],
    );
  }
}
