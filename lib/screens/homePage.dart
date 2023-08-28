// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tetherlandclone/helper/constants.dart';
import 'package:tetherlandclone/models/currencies.dart';
import 'package:tetherlandclone/service/apiProvider.dart';
import 'package:animate_do/animate_do.dart';
import '../helper/numberHelper.dart';
import '../service/currencyService.dart';
import '../widgets/customTextfield.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage>
    with SingleTickerProviderStateMixin {
  bool isTabselected = false;
  final TextEditingController _buyselltetherCount = TextEditingController();
  bool _IsbuyselltetherCount = false;
  final TextEditingController _buyselltomanCount = TextEditingController();
  bool _IsbuyselltomanCount = false;
  late TabController _tabController;
  AnimationController? animateController;
  TextEditingController animationTextController = TextEditingController();
  String baseUrl = 'https://service.tetherland.com';
  ScrollController _controller = new ScrollController();
  Future<String>? _value;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    doAnimation();
    currentUsdtPrice();
    _value = delaytime();
  }

  Future<String> delaytime() async {
    await Future.delayed(const Duration(seconds: 3));
    return 'Flutter Devs';
  }

  String myFunction(String str, String separator) {
    String tempString = "";
    for (int i = 0; i < str.length; i++) {
      if (i % 2 == 0 && i > 0) {
        if (i <= 2) {
          tempString = tempString + separator;
        }
      }
      tempString = tempString + str[i];
    }
    return tempString;
  }

  Future<void> currentUsdtPrice() async {
    String sp = ',';
    int? calc = await Provider.of<apiProvider>(context, listen: false)
        .calculateToman()
        .then((value) {
      Provider.of<apiProvider>(context, listen: false).currentUsdtPrice =
          (myFunction(value.toString(), ',')).toString();
    });

    String? usdtmodel = await Provider.of<apiProvider>(context, listen: false)
        .calculateUSDTmodel()
        .then((value) {
      Provider.of<apiProvider>(context, listen: false).usdtModel = value!;
    });

    currencies? mycrr = await Provider.of<apiProvider>(context, listen: false)
        .fetchcurrencies()
        .then((value) {
      Provider.of<apiProvider>(context, listen: false).currenciesModel =
          value as List<currencies?>;
    });
  }

//function To Animate Text on Home Page
  void doAnimation() async {
    List titles = ['امن', 'سریع', 'هوشمند', 'آسان'];

    for (int i = 0; i <= 4; i++) {
      animationTextController.text = titles[i];
      await Future.delayed(const Duration(seconds: 2));
      animateController?.forward();
      animateController?.repeat(period: Duration(seconds: 1));
      setState(() {});

      if (i == 3) {
        i = -1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        bodyWidget(),
        //cutsom Appbar
        customAppbar(context),
      ],
    ));
  }

  SingleChildScrollView bodyWidget() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            section1(),
            section2(),
            SizedBox(height: 10),
            Container(
              height: 300,
              color: Colors.amber,
            ),
            Container(
              height: 300,
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }

  Container section2() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 300,
        // color: Colors.blue,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Button All Cryoptos
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                      border: Border.all(color: btnGold, width: 1)),
                  margin: EdgeInsets.only(left: 20),
                  width: 100,
                  height: 40,
                  child: Center(
                      child: Text(
                    'همه ارزها',
                    style: TextStyle(
                        fontFamily: 'Anjoman',
                        color: btnGold,
                        fontWeight: FontWeight.w500,
                        fontSize: 11),
                  )),
                ),
                Container(
                  margin: EdgeInsets.only(right: 4),
                  child: Text('قیمت رمز ارزها',
                      style: TextStyle(fontFamily: 'Anjoman', fontSize: 16)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 180,
              width: double.infinity,
              child: FutureBuilder<String>(
                  future: _value,
                  builder: (context, snapshot) {
                    //If Done loading Api Privder
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return currenciesCardAtListview(context, index);
                        },
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox();
                  }),
            ),
          ],
        ));
  }

  Padding currenciesCardAtListview(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        //   height: 20,
        width: MediaQuery.of(context).size.width * 0.45,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 5),
                        child: Text(
                          Provider.of<apiProvider>(context, listen: false)
                              .currenciesModel[index]!
                              .faName
                              .toString(),
                          style: TextStyle(
                              fontFamily: 'Anjoman',
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              Provider.of<apiProvider>(context, listen: false)
                                  .currenciesModel[index]!
                                  .symbol
                                  .toString(),
                              style:
                                  TextStyle(fontFamily: 'Anjoman', fontSize: 9),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              '-',
                              style: TextStyle(
                                  fontFamily: 'Anjoman', fontSize: 10),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              Provider.of<apiProvider>(context, listen: false)
                                  .currenciesModel[index]!
                                  .name
                                  .toString(),
                              style:
                                  TextStyle(fontFamily: 'Anjoman', fontSize: 9),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Row(
                        children: [
                          Text(
                              style: TextStyle(
                                  fontFamily: 'Anjoman',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              '${separateThousands(Provider.of<apiProvider>(context, listen: false).currenciesModel[index]!.tomanAmount.toString())} تومان ')
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SvgPicture.network(
                          height: 50,
                          width: 50,
                          baseUrl +
                              Provider.of<apiProvider>(context, listen: false)
                                  .currenciesModel[index]!
                                  .logo
                                  .toString()),
                      SizedBox(height: 50),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                      style: TextStyle(
                          fontFamily: 'Anjoman',
                          fontSize: 13,
                          color: Colors.grey),
                      'تتر'),
                  SizedBox(width: 5),
                  Text(
                      style: TextStyle(
                          fontFamily: 'Anjoman',
                          fontSize: 13,
                          color: Colors.grey),
                      '${Provider.of<apiProvider>(context, listen: false).currenciesModel[index]!.price.toString()} '),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Stack section1() {
    return Stack(
      children: [
        BgShapesHomePage(),
        Column(
          children: [
            SizedBox(
              height: 80,
            ),
            //Box of Tab Controller Widget
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.94,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Colors.grey.withOpacity(0.5)),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: 380,
                  //TabController widget
                  child: DefaultTabController(
                    length: 3,
                    initialIndex: 2,
                    child: Column(
                      children: <Widget>[
                        //Tab Widgets
                        tabBarWidget(),
                        Expanded(
                          child: TabBarView(children: [
                            //Market Tab
                            Container(
                              child: Text("Home Body"),
                            ),
                            //Calculator Tab
                            Container(
                              child: Text("Articles Body"),
                            ),
                            //BuyAndSell Tab
                            Container(
                              child: tabBarViewPage1(),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            //RamzArz tether text
            TextWidgetHomePage(),
            SizedBox(
              height: 8,
            ),
            animationTextWidgetHomePage(),
            SizedBox(
              height: 30,
            ),
            //Current Price Box With Blur Effect
            Container(
              height: 200,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white)),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 5.0, sigmaY: 5.0), // Adjust blur intensity
                  child: Container(
                    margin: EdgeInsets.all(2),
                    color: Colors
                        .transparent, // This color won't be visible, but the filter will still be applied
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 10, top: 1, right: 10),
                                  width: 120,
                                  height: 40,
                                  color: Colors.white,
                                  child: Center(
                                      child: Text(
                                    'نمودار تتر',
                                    style: TextStyle(
                                        fontFamily: 'Anjoman',
                                        fontSize: 13,
                                        color: primaryColor),
                                  )),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            //Current Price With Text
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(right: 3, top: 20),
                                      child: Text(
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              fontFamily: 'Anjoman',
                                              fontSize: 19,
                                              color: Colors.white),
                                          'تومان'),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(right: 10, top: 20),
                                      child: Text(
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              fontFamily: 'Anjoman',
                                              fontSize: 19,
                                              color: Colors.white),
                                          '${Provider.of<apiProvider>(context, listen: true).currentUsdtPrice.toString()}  '),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        right: 10,
                                      ),
                                      child: Text(
                                        'قیمت لحظه ای تتر',
                                        style: TextStyle(
                                            fontFamily: 'Anjoman',
                                            fontSize: 11,
                                            color: Color.fromRGBO(
                                                207, 212, 210, 1)),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),

                            //Tether Logo
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(right: 0, top: 20),
                                  width: 80,
                                  height: 80,
                                  child: Image(
                                      image: AssetImage(
                                          'assets/images/tetherlogo1.png')),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Divider(
                            color: Colors.white,
                            height: 1,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        myFunction(
                                            Provider.of<apiProvider>(context,
                                                    listen: true)
                                                .usdtModel
                                                .last24hMin
                                                .toString(),
                                            ','),
                                        style: TextStyle(
                                            fontFamily: 'Anjoman',
                                            fontSize: 15,
                                            color: Colors.white),
                                      ),
                                      RotatedBox(
                                        quarterTurns: 45,
                                        child: Icon(
                                          Icons.chevron_right_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('پایین ترین',
                                      style: TextStyle(
                                          fontFamily: 'Anjoman',
                                          fontSize: 10,
                                          color: Colors.white.withOpacity(0.5)))
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        myFunction(
                                            Provider.of<apiProvider>(context,
                                                    listen: true)
                                                .usdtModel
                                                .last24hMax
                                                .toString(),
                                            ','),
                                        style: TextStyle(
                                            fontFamily: 'Anjoman',
                                            fontSize: 15,
                                            color: Colors.white),
                                      ),
                                      RotatedBox(
                                        quarterTurns: -45,
                                        child: Icon(
                                          Icons.chevron_right_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('بالاترین',
                                      style: TextStyle(
                                          fontFamily: 'Anjoman',
                                          fontSize: 10,
                                          color: Colors.white.withOpacity(0.5)))
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '% ${Provider.of<apiProvider>(context, listen: true).usdtModel.diff24d.toString()}',
                                        style: TextStyle(
                                            fontFamily: 'Anjoman',
                                            fontSize: 15,
                                            color: Colors.white),
                                      ),
                                      RotatedBox(
                                        quarterTurns: 45,
                                        child: Icon(
                                          Icons.chevron_right_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'تغییر',
                                    style: TextStyle(
                                        fontFamily: 'Anjoman',
                                        fontSize: 10,
                                        color: Colors.white.withOpacity(0.5)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row animationTextWidgetHomePage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            FadeIn(
              manualTrigger: true,
              duration: Duration(seconds: 2),
              controller: (controller) => animateController = controller,
              child: Text(
                animationTextController.text,
                style: TextStyle(
                    fontFamily: 'Anjoman',
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          children: [
            Text(
              'یک راه انتقال',
              style: TextStyle(
                  fontFamily: 'Anjoman',
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w100),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.30,
        ),
      ],
    );
  }

  Row TextWidgetHomePage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '«رمزارز «تتر',
          style: TextStyle(
              fontFamily: 'Anjoman',
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w100),
        )
      ],
    );
  }

  Padding tabBarViewPage1() {
    return Padding(
      padding: EdgeInsets.only(top: 30, left: 15, right: 15),
      child: Column(
        children: [
          //Input field for tether Count
          Consumer(
            builder: (context, value, child) {
              return customTextfield(
                hintTex: 'تتر',
                boxHinttext: 'تعداد',
                controller:
                    Provider.of<apiProvider>(context, listen: true).usdt,
                focusNode: _IsbuyselltetherCount,
              );
            },
          ),
          SizedBox(
            height: 30,
          ),
          //Input field for toman Rate of Requested Tether
          Consumer(
            builder: (context, value, child) {
              return customTextfield(
                hintTex: 'مبلغ',
                boxHinttext: 'تومان',
                controller:
                    Provider.of<apiProvider>(context, listen: true).toman,
                focusNode: _IsbuyselltomanCount,
              );
            },
          ),
          SizedBox(height: 10),
          blueinfoText(),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            padding: EdgeInsets.only(left: 3, right: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sellTetherButton(),
                buytetherButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buytetherButton() {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(3),
      ),
      width: MediaQuery.of(context).size.width * 0.35,
      child: Center(
        child: Text(
          'خرید',
          style: TextStyle(fontFamily: 'Anjoman', color: Colors.white),
        ),
      ),
    );
  }

  Container sellTetherButton() {
    return Container(
      decoration: BoxDecoration(
        color: redColor,
        borderRadius: BorderRadius.circular(3),
      ),
      width: MediaQuery.of(context).size.width * 0.35,
      child: Center(
        child: Text(
          'فروش',
          style: TextStyle(fontFamily: 'Anjoman', color: Colors.white),
        ),
      ),
    );
  }

  Container tabBarWidget() {
    return Container(
      constraints: BoxConstraints.expand(height: 80),
      child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: primaryColor,
          labelColor: primaryColor,
          labelStyle: TextStyle(fontFamily: 'Anjoman', fontSize: 11),
          tabs: [
            Tab(
              icon: Container(
                height: 35,
                width: 35,
                child: Image(image: AssetImage('assets/images/charticon.png')),
              ),
              height: 80,
              text: "بازار تترلند",
            ),
            Tab(
              icon: Container(
                height: 35,
                width: 35,
                child: Image(image: AssetImage('assets/images/clalcicon.png')),
              ),
              text: "مبدل رمزارز",
              height: 80,
            ),
            Tab(
              iconMargin: EdgeInsets.all(5),
              icon: Container(
                height: 35,
                width: 35,
                child:
                    Image(image: AssetImage('assets/images/buysellicon.png')),
              ),
              text: "خریدوفروش تتر",
              height: 80,
            ),
          ]),
    );
  }

  Container BgShapesHomePage() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 320,
            color: Colors.white,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 600,
            decoration: BoxDecoration(
                color: primaryColor,
                image: DecorationImage(
                    image: AssetImage('assets/images/shapes.png'),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Container blueinfoText() {
    return Container(
      height: 30,
      padding: EdgeInsets.only(left: 3, right: 3),
      child: Wrap(
        textDirection: TextDirection.ltr,
        children: [
          Text(
            maxLines: 3,
            '.مقدار دقیق دریافتی با توجه به نرخ لحظه‌ای تتر محاسبه می‌شود',
            style:
                TextStyle(fontFamily: 'Anjoman', fontSize: 11, color: btnBlue),
          ),
          SizedBox(
            width: 4,
          ),
          Container(
            width: 15,
            height: 15,
            child: Image(image: AssetImage('assets/images/infoicon.png')),
          ),
        ],
      ),
    );
  }

  ///////////////////////////////custom text fff

//CustomAppbar
  Row customAppbar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.96,
          height: 60,
          decoration: BoxDecoration(
              border:
                  Border.all(width: 0.5, color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(color: btnGold, width: 1)),
                    margin: EdgeInsets.only(left: 20),
                    width: 100,
                    height: 40,
                    child: Center(
                        child: Text(
                      'ورود / ثبت نام',
                      style: TextStyle(
                          fontFamily: 'Anjoman',
                          color: btnGold,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () async {
                    int n = getCurrency() as int;
                  },
                  icon: Icon(Icons.menu))
            ],
          ),
        ),
      ],
    );
  }
}
