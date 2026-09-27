import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    super.key,
    required this.headerBuilder,
    required this.children,
    this.initiallyExpanded = false,
    this.backgroundColor = Colors.transparent,
    this.collapsedBackgroundColor = Colors.transparent,
    this.hoverColor = Colors.transparent,
    this.onExpansionChanged,
    this.expanded,
    this.shape,
  });

  // Widget yang dapat diklik (pengganti title)
  final Widget Function(
          BuildContext context, bool isExpanded, Animation<double> animation)
      headerBuilder;
  final List<Widget> children;
  final bool initiallyExpanded;
  final Color backgroundColor;
  final Color collapsedBackgroundColor;
  final Color hoverColor;
  final ValueChanged<bool>? onExpansionChanged;
  final bool? expanded;
  final ShapeBorder? shape;

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _controller;
  late Animation<double> _heightFactor;

  bool get _isControlled => widget.expanded != null;

  @override
  void initState() {
    super.initState();
    final storedExpanded = PageStorage.of(context).readState(context) as bool?;
    _isExpanded = widget.expanded ?? storedExpanded ?? widget.initiallyExpanded;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeIn));

    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant CustomExpansionTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    final expanded = widget.expanded;
    if (expanded != null && expanded != _isExpanded) {
      _setExpanded(
        expanded,
        notifyChanged: false,
        persistToPageStorage: false,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setExpanded(
    bool expanded, {
    required bool notifyChanged,
    required bool persistToPageStorage,
  }) {
    setState(() {
      _isExpanded = expanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild untuk menghapus child yang tidak terlihat jika diperlukan
          });
        });
      }
      if (persistToPageStorage) {
        PageStorage.of(context).writeState(context, _isExpanded);
      }
    });
    if (notifyChanged) {
      widget.onExpansionChanged?.call(_isExpanded);
    }
  }

  void _handleTap() {
    final expanded = !_isExpanded;
    if (_isControlled) {
      widget.onExpansionChanged?.call(expanded);
      return;
    }

    _setExpanded(
      expanded,
      notifyChanged: true,
      persistToPageStorage: true,
    );
  }

// Sebelumnya: Widget _buildChildren(BuildContext context, Widget child)
// Solusi: Ganti tipe argumen 'child' menjadi 'Widget?'
  Widget _buildChildren(BuildContext context, Widget? child) {
    // Karena 'child' sekarang bisa null, kita harus menanganinya.
    // Namun, karena kita tahu kita memberikan 'child' di AnimatedBuilder,
    // kita bisa yakin itu tidak null, atau kita bisa menggunakan operator !.

    return ClipRect(
      child: Align(
        alignment: Alignment.topLeft,
        heightFactor: _heightFactor.value,
        // Gunakan 'child!' untuk menyatakan bahwa 'child' tidak akan null
        // karena kita memberikannya secara eksplisit di AnimatedBuilder.
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final Color color =
        _isExpanded ? widget.backgroundColor : widget.collapsedBackgroundColor;

    return Container(
      decoration: ShapeDecoration(
        color: color,
        shape: widget.shape ?? const RoundedRectangleBorder(),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Header (Area yang Dapat Diklik)
          InkWell(
            onTap: _handleTap,
            hoverColor: widget.hoverColor,
            // HEADER BUILDER: Memberikan kontrol padding penuh
            child: widget.headerBuilder(context, _isExpanded, _controller),
          ),

          // Children (Konten yang Diperluas)
          // Menggunakan AnimatedBuilder untuk animasi SizeTransition
          closed
              ? const SizedBox()
              : AnimatedBuilder(
                  animation: _controller.view,
                  builder: _buildChildren,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.children,
                  ),
                ),
        ],
      ),
    );
  }
}
