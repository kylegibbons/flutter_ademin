import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';

class AIChatInputBar extends StatefulWidget {
  const AIChatInputBar({
    super.key,
    this.onSend,
    this.onMic,
    this.onUploadFiles,
    this.onAddFromDrive,
    this.onDeepResearch,
  });

  final ValueChanged<String>? onSend;
  final VoidCallback? onMic;
  final VoidCallback? onUploadFiles;
  final VoidCallback? onAddFromDrive;
  final VoidCallback? onDeepResearch;

  @override
  State<AIChatInputBar> createState() => _AIChatInputBarState();
}

class _AIChatInputBarState extends State<AIChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey _addButtonKey = GlobalKey();

  bool get hasText => _controller.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    widget.onSend?.call(text);

    _controller.clear();
  }

  Future<void> _showAddMenu() async {
    if (_addButtonKey.currentContext == null) return;

    final RenderBox buttonRenderBox =
        _addButtonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset buttonPosition = buttonRenderBox.localToGlobal(
      Offset.zero,
      ancestor: overlay,
    );
    final Size buttonSize = buttonRenderBox.size;

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        buttonPosition.dx,
        buttonPosition.dy - buttonSize.height - 8,
        buttonPosition.dx + buttonSize.width,
        buttonPosition.dy,
      ),
      items: [
        PopupMenuItem(
          onTap: widget.onUploadFiles,
          child: const Row(
            children: [
              Icon(Icons.upload_file),
              SizedBox(width: 12),
              Text("Upload files"),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: widget.onAddFromDrive,
          child: const Row(
            children: [
              Icon(Icons.cloud_outlined),
              SizedBox(width: 12),
              Text("Add from Drive"),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: widget.onDeepResearch,
          child: const Row(
            children: [
              Icon(Icons.auto_awesome),
              SizedBox(width: 12),
              Text("Deep Research"),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 4,
          vertical: kDefaultPadding / 4,
        ),
        margin: EdgeInsetsDirectional.only(
          start: kDefaultPadding,
          end: kDefaultPadding,
          bottom: kDefaultPadding,
        ),
        decoration: BoxDecoration(
          color: themeData.colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: themeData.colorScheme.outline),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIconButton(
              key: _addButtonKey,
              onTap: _showAddMenu,
              icon: Icons.add,
              shape: ButtonShape.circle,
              tooltipMessage: 'Add files and others ',
            ),

            SizedBox(width: kDefaultPadding / 4),

            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 1,
                maxLines: 5,

                decoration: InputDecoration(
                  hintText: "Ask anything...",
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  isCollapsed: true,
                  hoverColor: themeData.colorScheme.surface,
                  filled: true,
                  fillColor: themeData.colorScheme.surface,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: kDefaultPadding,
                  ),
                ),
              ),
            ),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: hasText
                  ? CustomIconButton(
                      key: const ValueKey("send"),
                      onTap: _send,
                      shape: ButtonShape.circle,
                      icon: Icons.arrow_upward,
                    )
                  : CustomIconButton(
                      key: const ValueKey("mic"),
                      onTap: widget.onMic,
                      shape: ButtonShape.circle,
                      icon: Icons.mic_none,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
