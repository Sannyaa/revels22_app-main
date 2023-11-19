import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitrevels22/logic/router.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatelessWidget {
  final RevelsAppState appState;
  HomeView({Key? key, required this.appState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: Color(0xff21242B),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Image.asset(
                  "assets/logo_final_transparent_dark.png",
                  height: 200,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: () {
                    appState.homePage = HomePages.faq;
                  },
                  child: Center(
                    child: Text(
                      "FAQs",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cabin(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: () {
                    appState.homePage = HomePages.developers;
                  },
                  child: Center(
                    child: Text(
                      "Developers",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cabin(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: () async {
                    if (await canLaunch(
                        "https://forms.gle/TM6hzbBiP9LjAAtB6")) {
                      launch("https://forms.gle/TM6hzbBiP9LjAAtB6");
                    }
                  },
                  child: Center(
                    child: Text(
                      "Report a bug",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cabin(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: () async {
                    if (await canLaunch("https://revelsmit.in/mitpost.pdf")) {
                      launch("https://revelsmit.in/mitpost.pdf");
                    }
                  },
                  child: Center(
                    child: Text(
                      "Newsletter",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cabin(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: () async {
                    if (await canLaunch("https://tt-2022.web.app")) {
                      launch("https://tt-2022.web.app");
                    }
                  },
                  child: Center(
                    child: Text(
                      "Live Blog",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cabin(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Builder(builder: (context) {
          return WillPopScope(
            onWillPop: () {
              if (Scaffold.of(context).isDrawerOpen) {
                Navigator.pop(context);
                return Future.value(false);
              }
              return Future.value(true);
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.darken,
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(33, 36, 43, 0),
                              Color.fromRGBO(33, 36, 43, 1),
                            ]).createShader(bounds);
                      },
                      child: Image.asset(
                        "assets/image_8.png",
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          "assets/aaghaz.png",
                          width: MediaQuery.of(context).size.width * 0.7,
                        )),
                    Positioned(
                      right: 35,
                      bottom: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Revels'22",
                              style: GoogleFonts.raleway(
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 0.9),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Celebrating 40 years",
                              style: GoogleFonts.raleway(
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 0.5),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 17, right: 8),
                                child: NeumorphicButton(
                                  style: NeumorphicStyle(
                                      depth: 4,
                                      shadowDarkColor: Colors.black,
                                      shadowLightColor: const Color(0xFF454954),
                                      color: const Color(0xff21242b),
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(8.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 17),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Categories",
                                                  style: GoogleFonts.cabin(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 20),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "Curated just for you!",
                                                    style: GoogleFonts.cabin(
                                                        fontSize: 11,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color(
                                                            0xff9B9B9B)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Image.asset(
                                                "assets/category_icon 1.png",
                                                height: 40,
                                                width: 40,
                                              )
                                            ],
                                          )
                                        ]),
                                  ),
                                  onPressed: () {
                                    appState.homePage = HomePages.categories;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, top: 17),
                                child: NeumorphicButton(
                                  style: NeumorphicStyle(
                                      depth: 4,
                                      shadowDarkColor: Colors.black,
                                      shadowLightColor: const Color(0xFF454954),
                                      color: const Color(0xff21242b),
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(8.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 17),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Delegate Cards",
                                                  style: GoogleFonts.cabin(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 20),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Your access to Events",
                                                  style: GoogleFonts.cabin(
                                                      fontSize: 11,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: const Color(
                                                          0xff9B9B9B)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Image.asset(
                                                "assets/DelegateCards_icon 1.png",
                                                height: 40,
                                                width: 40,
                                              )
                                            ],
                                          )
                                        ]),
                                  ),
                                  onPressed: () {
                                    appState.homePage = HomePages.delegateCards;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 17),
                                child: NeumorphicButton(
                                  style: NeumorphicStyle(
                                      depth: 4,
                                      shadowDarkColor: Colors.black,
                                      shadowLightColor: const Color(0xFF454954),
                                      color: const Color(0xff21242b),
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(8.0))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Proshow",
                                                style: GoogleFonts.cabin(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 20),
                                                child: Text(
                                                  "See the lineup",
                                                  style: GoogleFonts.cabin(
                                                      fontSize: 11,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: const Color(
                                                          0xff9B9B9B)),
                                                ),
                                              ),
                                            ]),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: Image.asset(
                                            "assets/ProShow_icon 1.png",
                                            height: 32.84,
                                            width: 40,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    appState.homePage = HomePages.proshow;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 17, right: 8),
                                child: NeumorphicButton(
                                  style: NeumorphicStyle(
                                      depth: 4,
                                      shadowDarkColor: Colors.black,
                                      shadowLightColor: const Color(0xFF454954),
                                      color: const Color(0xff21242b),
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(8.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 17),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Events",
                                                style: GoogleFonts.cabin(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 20),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Filtered by Genre",
                                                  style: GoogleFonts.cabin(
                                                      fontSize: 11,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: const Color(
                                                          0xff9B9B9B)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Image.asset(
                                                "assets/Events_icon 1.png",
                                                height: 40,
                                                width: 40,
                                              )
                                            ],
                                          )
                                        ]),
                                  ),
                                  onPressed: () {
                                    appState.homePage = HomePages.events;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, top: 17),
                                child: NeumorphicButton(
                                  style: NeumorphicStyle(
                                      depth: 4,
                                      shadowDarkColor: Colors.black,
                                      shadowLightColor: const Color(0xFF454954),
                                      color: const Color(0xff21242b),
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(8.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Featured\nEvents",
                                              style: GoogleFonts.cabin(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 20),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Win Exciting Prizes",
                                                style: GoogleFonts.cabin(
                                                    fontSize: 11,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(
                                                        0xff9B9B9B)),
                                              ),
                                              Image.asset(
                                                "assets/FeaturedEvents_icons 1.png",
                                                height: 40,
                                                width: 40,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    appState.homePage =
                                        HomePages.featuredEvents;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 45),
                        child: Center(
                            child: Text(
                          "Reach out to us on our\nSocial Media",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cabin(
                              color: Color(0xffa6a7aa),
                              fontSize: 18,
                              height: 1.5,
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 45, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (await canLaunch(
                                    "https://www.instagram.com/revelsmit/")) {
                                  launch(
                                      "https://www.instagram.com/revelsmit/");
                                }
                              },
                              child: Image.asset(
                                "assets/instagram.png",
                                height: 30,
                                width: 30,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (await canLaunch(
                                    "https://www.facebook.com/mitrevels/")) {
                                  launch("https://www.facebook.com/mitrevels/");
                                }
                              },
                              child: Image.asset(
                                "assets/facebook.png",
                                height: 30,
                                width: 30,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (await canLaunch(
                                    "https://twitter.com/revelsmit")) {
                                  launch("https://twitter.com/revelsmit");
                                }
                              },
                              child: Image.asset(
                                "assets/twitter.png",
                                height: 30,
                                width: 30,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (await canLaunch(
                                    "https://www.youtube.com/channel/UC9gwWd47a0q042qwEgutjWw")) {
                                  launch(
                                      "https://www.youtube.com/channel/UC9gwWd47a0q042qwEgutjWw");
                                }
                              },
                              child: Image.asset(
                                "assets/youtube.png",
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 30, right: 30, bottom: 40),
                        child:
                            Divider(color: Color.fromRGBO(255, 255, 255, 0.3)),
                      ),
                      Stack(
                        children: [
                          Positioned(
                              top: -100,
                              left: 70,
                              child: Image.asset(
                                "assets/logo_final_transparent_dark 1 2.png",
                                width: 500,
                              )),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 27, left: 35, right: 35),
                                child: Text(
                                  "Revels 2022 | Aagaz - Beyond Legacies•\nMy sun sets to rise again.\n - Robert Browning.\nOften, we see despair creeping into our lives. We do not know what might hit us, but yet somehow, we trod through the vastness of our Universe.\nLife and Death are the mandatory nuances of one's existence but \"rebirth\"? Rebirth is nobility in the face of bourgeois existence.\nRebirth is about passion and romance. Imagine the day you were born - people around you celebrated, but you do not remember any of it. You could not comprehend that with you - on that very day - was the Rebirth of new hope, an idea, a legacy.\n\"Dust Thou art and to dust shall you returnest\nWas never spoken of the soul.\"\nThis is what makes the concept of Rebirth a quintessential factor of one's existence.\nSo, look Death dead in the eye from hereon and overwrite your own destiny.\nWe bring you \"Aagaz - Beyond Legacies\".\nThe commencement of life where you not only live; but also make every second count.",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cabin(
                                      fontSize: 16,
                                      height: 2,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          Color.fromRGBO(255, 255, 255, 0.8)),
                                ),
                              ),
                              Center(
                                  child: Image.asset(
                                "assets/logo_final_transparent_dark.png",
                                width: 200,
                              )),
                              Padding(
                                padding: EdgeInsets.only(top: 16, bottom: 30),
                                child: Center(
                                    child: Text(
                                  "Developed with \u2764 by App Dev Team",
                                  style: GoogleFonts.cabin(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          Color.fromRGBO(255, 255, 255, 0.7)),
                                )),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                    shrinkWrap: true,
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
