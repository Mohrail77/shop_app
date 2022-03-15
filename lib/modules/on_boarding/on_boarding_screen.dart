import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 1 Title',
      body: 'On Board 1 body',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 2 Title',
      body: 'On Board 2 body',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 3 Title',
      body: 'On Board 3 body',
    ),
  ];

  var boardController = PageController();

  bool isLast = false;

  void submit() {
    CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ), (route) {
          return false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: () {
              submit();
            },
            text: 'SKIP',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10.0,
                    expansionFactor: 4,
                    dotWidth: 10.0,
                    spacing: 5.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                (model.image),
              ),
            ),
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
        ],
      );
}
