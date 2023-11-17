import 'dart:convert';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rempah_apps/Views/home_screen.dart';
import 'package:rempah_apps/Views/user_screen.dart';
import 'package:rempah_apps/api/news_api.dart';
import 'package:rempah_apps/widgets/data.dart';
import 'package:rempah_apps/widgets/item_rempah.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var json = "";
  var listJson = [];
  var dateNow = DateTime.now();
  var dateNowFormat = DateTime.now().toString().substring(0, 10);

  @override
  void initState() {
    asyncMethod();
    super.initState();
  }

  void asyncMethod() async {
    json = await rootBundle.loadString('assets/herbs.json');
    setState(() {
      json = json;
      listJson = jsonDecode(json);
    });
  }

  final data = Product('assets/cengkeh.png', 'Cengkeh',
      'Cengkeh merupakan tanaman endemik di Maluku Utara, yang terdapat di Ternate, Moti, Tidore, Makian, dan Bacan.');

  Widget buildItemRempah(Product product) {
    return ItemRempah(product: product);
  }

  @override
  Widget build(BuildContext context) {
    print(dateNowFormat);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 24,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black54,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.ad_units,
              color: Colors.black54,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bar_chart,
              color: Colors.black54,
            ),
            label: '',
          ),
        ],
        onTap: (int index) {
          if (index == 2) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsScreen()),
            );
          }
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hallo,",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.username,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserScreen()));
                    },
                    child: const CircleAvatar(
                      radius: 13,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/icon_users.png"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/icon_news.png",
                      width: 92,
                      height: 100,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "How do you feel ?",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const SizedBox(
                          width: 120,
                          child: Text(
                            "See today's latest News",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NewsScreen()),
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 35,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Center(
                              child: Text(
                                "Get Started",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.only(left: 16),
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 33,
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "How can we help you?",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 85,
                      width: MediaQuery.of(context).size.width,
                      child: Marquee(
                        directionMarguee: DirectionMarguee.oneDirection,
                        animationDuration: const Duration(milliseconds: 14000),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: listJson.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (listJson[index]['date'] == dateNowFormat) {
                              return Marquee(
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  width: 155,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrange.withOpacity(.3),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(0, 2),
                                        ),
                                      ]),
                                  child: ListTile(
                                    title: Text(listJson[index]['name']),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(listJson[index]['price']),
                                        Text(listJson[index]['date']),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rempah list",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                child: SizedBox(
                  height: 210,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ItemRempah(product: allData[index]);
                    },
                    itemCount: allData.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
