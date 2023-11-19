import 'package:mitrevels22/logic/router.dart';

import '../../widgets/DeveloperTile.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class DevelopersPage extends StatefulWidget {
  const DevelopersPage({Key? key, required this.appState}) : super(key: key);
  final RevelsAppState appState;
  @override
  State<DevelopersPage> createState() => _DevelopersPageState();
}

class _DevelopersPageState extends State<DevelopersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF21242B),
        appBar: NeumorphicAppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          buttonStyle: const NeumorphicStyle(
            depth: 4,
            shadowDarkColor: Colors.black,
            shadowLightColor: Color(0xFF454954),
            boxShape: NeumorphicBoxShape.circle(),
          ),
          title: NeumorphicText(
            'Meet the Developers',
            style: const NeumorphicStyle(color: Colors.white),
            textStyle: NeumorphicTextStyle(
              fontSize: 24,
              fontFamily: "cabin",
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Core Committee",
                  style: GoogleFonts.cabin(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  DeveloperTile(
                    name: "Pranshul Goyal",
                    imgURL:
                        "https://avatars.githubusercontent.com/u/57452974?v=4",
                    githubURL: "https://github.com/Pranshul2002/",
                    instaURL: "https://www.instagram.com/pranshul_2002/",
                    linkedinURL: "https://www.linkedin.com/in/pranshul-goyal/",
                    isCC: true,
                  ),
                  DeveloperTile(
                    name: "Prakhar Bhatnagar",
                    imgURL:
                        "https://pbs.twimg.com/profile_images/1327840909761810433/UnDNiFxe_400x400.jpg",
                    githubURL: "https://github.com/prakharb10",
                    instaURL:
                        "https://www.instagram.com/prakhar_b10/?igshid=YmMyMTA2M2Y=",
                    linkedinURL:
                        "https://twitter.com/Prakhar_b10?t=ifCgimS3jFqBX9u_edSqiw&s=08",
                    isCC: true,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  DeveloperTile(
                    name: "Sanya",
                    imgURL:
                        "https://media-exp1.licdn.com/dms/image/C4E03AQEau9vBMrogsw/profile-displayphoto-shrink_400_400/0/1598029705418?e=1654732800&v=beta&t=2wVUdHVUzKa4byoTdGMVM97l7peLrUl-Vv0V9yUbDlY",
                    githubURL: "https://github.com/Sannyaa",
                    instaURL: "https://www.instagram.com/saannya_/",
                    linkedinURL:
                        "https://www.linkedin.com/in/sanya-gupta-5a2a06185/",
                    isCC: true,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                child: Divider(
                  height: 20,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  "Organisers",
                  style: GoogleFonts.cabin(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  DeveloperTile(
                    name: "Praveen",
                    imgURL: "https://i.ibb.co/mCjrYX3/res-pic.png",
                    githubURL: "https://github.com/geekyprawins",
                    instaURL: "https://www.instagram.com/_praveenvarma_/",
                    linkedinURL:
                        "https://www.linkedin.com/in/praveen-varma-a4b27b1b5/",
                    isCC: false,
                  ),
                  DeveloperTile(
                    name: "Divyansh",
                    imgURL: "https://avatars.githubusercontent.com/u/34028379",
                    githubURL: "https://github.com/divyanshkul",
                    instaURL: "https://instagram.com/divvyansh.__",
                    linkedinURL: "https://www.linkedin.com/in/divyanshkul/",
                    isCC: false,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  DeveloperTile(
                    name: "Kavya",
                    imgURL:
                        "https://instagram.fblr1-4.fna.fbcdn.net/v/t51.2885-19/248043839_276796241048384_5817881989217469245_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fblr1-4.fna.fbcdn.net&_nc_cat=108&_nc_ohc=c-rYyjqxufwAX8M8u2W&edm=ABfd0MgBAAAA&ccb=7-4&oh=00_AT8Xgm3w1hqxoxEwsokpdoXsMFxnDSo80lBNtz3IhVt0xw&oe=6256DF4A&_nc_sid=7bff83",
                    githubURL: "https://github.com/kavyagoel1707",
                    instaURL: "https://www.instagram.com/kavya_goel/",
                    linkedinURL:
                        "https://www.linkedin.com/in/kavya-goel-7ba0aa202/",
                    isCC: false,
                  ),
                  DeveloperTile(
                    name: "Shikhar",
                    imgURL:
                        "https://i.ibb.co/RNBFRsB/7617-B6-CB-137-F-4-CD7-B561-442-E1-F76-D425.jpg",
                    githubURL: "https://github.com/shikharr-ag",
                    instaURL: "https://www.instagram.com/shikharr_ag/",
                    linkedinURL:
                        "https://www.linkedin.com/in/shikhar-agarwal-98a239168/",
                    isCC: false,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
