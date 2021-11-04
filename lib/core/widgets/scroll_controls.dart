import 'package:flutter/material.dart';
import 'package:jimmy_test/core/theme/theme.dart';

/// Displays two buttons to jump up and to jump down within scroll area
/// parameter [hideOffset] defines the direction in which buttons will be hidden from vision
class ScrollControlButtons extends StatefulWidget {
  final ScrollController scrollController;
  final Offset hideOffset;

  const ScrollControlButtons({
    Key? key,
    required this.scrollController,
    required this.hideOffset,
  }) : super(key: key);

  @override
  _ScrollControlButtonsState createState() => _ScrollControlButtonsState();
}

class _ScrollControlButtonsState extends State<ScrollControlButtons> {
  bool _showJumpToTop = false;
  bool _showJumpToBottom = false;

  @override
  void initState() {
    widget.scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ScrollControlButton(
          isVisible: _showJumpToTop,
          buttonContent: Icon(
            Icons.arrow_upward,
            size: 20,
            color: AppTheme.colors.activeButtonTextColor,
          ),
          onPressed: () {
            widget.scrollController.animateTo(
              0,
              duration: const Duration(seconds: 2),
              curve: Curves.easeOutExpo,
            );
          },
          disappearOffset: widget.hideOffset,
        ),
        if (_showJumpToTop && _showJumpToBottom) const SizedBox(height: 10),
        _ScrollControlButton(
          isVisible: _showJumpToBottom,
          buttonContent: Icon(
            Icons.arrow_downward,
            size: 20,
            color: AppTheme.colors.activeButtonTextColor,
          ),
          onPressed: () {
            widget.scrollController.jumpTo(widget.scrollController.position.maxScrollExtent);
          },
          disappearOffset: widget.hideOffset,
        ),
      ],
    );
  }

  void _onScroll() {
    if (!widget.scrollController.hasClients) return;
    final position = widget.scrollController.position;
    final maxScroll = position.maxScrollExtent;
    final currentOffset = widget.scrollController.offset;

    final showJumpToTop = currentOffset >= position.viewportDimension;
    final showJumpToBottom = currentOffset > position.minScrollExtent &&
        currentOffset < maxScroll - position.viewportDimension;

    final shouldUpdateState =
        _showJumpToBottom != showJumpToBottom || _showJumpToTop != showJumpToTop;
    if (shouldUpdateState) {
      setState(() {
        _showJumpToBottom = showJumpToBottom;
        _showJumpToTop = showJumpToTop;
      });
    }
  }
}

class _ScrollControlButton extends StatelessWidget {
  final bool isVisible;
  final Widget buttonContent;
  final VoidCallback onPressed;
  final Offset disappearOffset;

  const _ScrollControlButton({
    Key? key,
    required this.isVisible,
    required this.buttonContent,
    required this.onPressed,
    required this.disappearOffset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: isVisible ? Offset.zero : disappearOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.colors.scrollButtonBackgroundColor,
          ),
          child: buttonContent,
        ),
      ),
    );
  }
}
