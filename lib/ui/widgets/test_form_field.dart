import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicTextFormField extends StatefulWidget {
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final String hintText;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final Iterable<String>? autofillHints;
  final TextEditingController controller;
  final String? errorText;
  const NeumorphicTextFormField({
    Key? key,
    required this.keyboardType,
    required this.textStyle,
    required this.hintText,
    required this.obscureText,
    required this.textInputAction,
    this.textCapitalization,
    required this.autofillHints,
    required this.controller,
    required this.errorText,
  }) : super(key: key);

  @override
  State<NeumorphicTextFormField> createState() =>
      _NeumorphicTextFormFieldState();
}

class _NeumorphicTextFormFieldState extends State<NeumorphicTextFormField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Neumorphic(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            style: NeumorphicStyle(
              color: const Color(0xFF17181C).withOpacity(0.5),
              boxShape: const NeumorphicBoxShape.stadium(),
              depth: _focusNode.hasFocus
                  ? -4
                  : widget.controller.text.isEmpty
                      ? 4
                      : 0,
            ),
            child: TextFormField(
              controller: widget.controller,
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.none,
              textInputAction: widget.textInputAction,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              style: widget.textStyle,
              focusNode: _focusNode,
              autofillHints: widget.autofillHints,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                hintStyle: widget.textStyle?.copyWith(
                  color: widget.textStyle?.color?.withOpacity(0.5),
                ),
              ),
              onTap: () => _focusNode.requestFocus(),
            ),
          ),
          if (widget.errorText != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.errorText!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
