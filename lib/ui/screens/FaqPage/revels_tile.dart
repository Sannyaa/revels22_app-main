import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/constants/constants.dart';
import '../../../data/models/faq_model.dart';

class RevealTile extends StatefulWidget {
  FAQ data;
  RevealTile({Key? key, required this.data}) : super(key: key);

  @override
  State<RevealTile> createState() => _RevealTileState();
}

class _RevealTileState extends State<RevealTile>
    with SingleTickerProviderStateMixin {
   final Duration _kExpand = const  Duration(milliseconds: 200);
  late Animation<double> _iconTurns;
  late Animation<double> _tileOpacity;
  late Animation<Offset> _tileOffset;

  late AnimationController _controller;
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _quarterTween =
      Tween<double>(begin: 0.0, end: 0.25);
  static final Animatable<double> _fullTween =
      Tween<double>(begin: 0.0, end: 1.0);
  static final Animatable<Offset> _offsetTween =
      Tween<Offset>(begin: const Offset(0, -0.2), end: const Offset(0, 0));


  bool _isExpanded = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this)
      ..addStatusListener((status) {
    
        if (status == AnimationStatus.completed) {
          setState(() {
          });
        } else {
        }
      });
    _iconTurns = _controller.drive(_quarterTween.chain(_easeInTween));
    _tileOpacity = _controller.drive(_fullTween.chain(_easeInTween))

      ..addStatusListener((status) {
        if (status == AnimationStatus.forward ||
            status == AnimationStatus.completed) {
          if (_tileOpacity.value > 0.8) {
            setState(() {});
          }
        } else {
          if (_tileOpacity.value < 0.2) {
            setState(() {});
          }
        }
      });
    _tileOffset = _controller.drive(_offsetTween.chain(_easeInTween));
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
       
      }
  
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: _isExpanded
              ? const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                )
              : BorderRadius.circular(10.0),
          child: Container(
            decoration: BoxDecoration(
              border: _isExpanded
                  ? null
                  : const Border(
                      bottom: BorderSide(
                        color: stackTileColor,
                        width: 11,
                      ),
                    ),
            ),
            child: ListTile(
              tileColor: tileBgColor,
              contentPadding: const EdgeInsets.all(8.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                 widget.data.question,
                  style: GoogleFonts.cabin(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              onTap: _handleTap,
              trailing: RotationTransition(
                turns: _iconTurns,
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
     

        FadeTransition(
          opacity: _tileOpacity,
          child: AnimatedSize(
            duration: _kExpand,
            child: SizedBox(
              height: !_isExpanded ? 0 : null,
           
              child: SlideTransition(
                position: _tileOffset,
                child: ListTile(
                  tileColor:expandedTileColor
                      .withOpacity(_tileOpacity.value),
            
                  contentPadding: const EdgeInsets.all(8.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.data.answer,
                      style: GoogleFonts.cabin(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
