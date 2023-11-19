import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mitrevels22/logic/router.dart';
import 'package:mitrevels22/ui/widgets/loading.dart';

class ProShowScreen extends StatefulWidget {
  final RevelsAppState appState;
  const ProShowScreen({Key? key, required this.appState}) : super(key: key);

  @override
  _ProShowScreenState createState() => _ProShowScreenState();
}

class _ProShowScreenState extends State<ProShowScreen>
    with SingleTickerProviderStateMixin {
  late TabController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
    _controller?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121416),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        toolbarHeight: 75,
        title: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Text(
              "Proshow",
              textAlign: TextAlign.center,
              style: GoogleFonts.cabin(
                fontWeight: FontWeight.w400,
                fontSize: 25,
              ),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF121416),
        centerTitle: true,
        bottom: TabBar(
          isScrollable: true,
          indicatorWeight: 0.5,
          controller: _controller,
          indicatorSize: TabBarIndicatorSize.label,
          indicator: const BoxDecoration(
            color: Color(0xFF394046),
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
          tabs: [
            SizedBox(
              width: 64,
              height: 34,
              child: Tab(
                child: Text(
                  "Day 1",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 64,
              height: 34,
              child: Tab(
                child: Text(
                  "Day 2",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 64,
              height: 34,
              child: Tab(
                child: Text(
                  "Day 3",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 64,
              height: 34,
              child: Tab(
                child: Text(
                  "Day 4",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 64,
              height: 34,
              child: Tab(
                child: Text(
                  "Day 5",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              const Divider(
                height: 15,
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: Color.fromRGBO(255, 255, 255, 0.2),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(21, 8, 28, 19),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://raw.githubusercontent.com/Pranshul2002/test/main/Tribhukti.jpg',
                      height: MediaQuery.of(context).size.height - 210,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => loading(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListView(
            shrinkWrap: true,
            children: [
              const Divider(
                height: 15,
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: Color.fromRGBO(255, 255, 255, 0.2),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(21, 8, 28, 19),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://raw.githubusercontent.com/Pranshul2002/test/main/KennySebastian.png',
                      height: MediaQuery.of(context).size.height / 2 - 100,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => loading(context),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CachedNetworkImage(
                      imageUrl:
                          'https://raw.githubusercontent.com/Pranshul2002/test/main/AakashMehta.png',
                      height: MediaQuery.of(context).size.height / 2 - 100,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => loading(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListView(
            shrinkWrap: true,
            children: [
              const Divider(
                height: 15,
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: Color.fromRGBO(255, 255, 255, 0.2),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(21, 8, 28, 19),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://raw.githubusercontent.com/Pranshul2002/test/main/Shruti.jpg',
                      height: MediaQuery.of(context).size.height - 210,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => loading(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListView(
            shrinkWrap: true,
            children: [
              const Divider(
                height: 15,
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: Color.fromRGBO(255, 255, 255, 0.2),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(21, 8, 28, 19),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://raw.githubusercontent.com/Pranshul2002/test/main/KK.png',
                      height: MediaQuery.of(context).size.height / 2 - 100,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => loading(context),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CachedNetworkImage(
                      imageUrl:
                          'https://raw.githubusercontent.com/Pranshul2002/test/main/Naalayak.png',
                      height: MediaQuery.of(context).size.height / 2 - 100,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => loading(context),
                    )
                  ],
                ),
              ),
            ],
          ),
          ListView(
            shrinkWrap: true,
            children: [
              const Divider(
                height: 15,
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: Color.fromRGBO(255, 255, 255, 0.2),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(21, 8, 28, 19),
                child: Column(
                  children: [
                    Image.network(
                      ('https://raw.githubusercontent.com/Pranshul2002/test/main/Nikhil.jpg'),
                      height: MediaQuery.of(context).size.height - 210,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
