import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flut_base_app_the_movie_db_clone/core/theme/app_colors.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/utils/utils.dart';
import 'package:flutter/material.dart';

class Pagination extends StatefulWidget {
  final int total;
  final int page;
  final bool enabled;
  final PaginationController? controller;
  final EdgeInsets? margin;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final double? iconSize;
  final Function(int)? onChanged;

  const Pagination({
    super.key,
    required this.total,
    this.page = 1,
    this.enabled = true,
    this.controller,
    this.margin,
    this.onChanged,
    this.iconSize,
    this.leftIcon,
    this.rightIcon,
  });

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  late PaginationController _controller;

  int get _totalCircle => widget.total > 7 ? 7 : widget.total;

  @override
  void initState() {
    _controller = widget.controller ?? PaginationController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.moveTo(_controller.initialPage ?? widget.page);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.total <= 1) {
      return const SizedBox();
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Padding(
          padding: widget.margin ?? context.spacer.all.xxs,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCircleAction(isBack: true),
              ...List.generate(
                _totalCircle,
                (index) {
                  int listIndex = index + 1;

                  if (widget.total <= 7) {
                    return _buildCirclePage(listIndex);
                  } else {
                    return _buildManyIndexCirclePage(listIndex);
                  }
                },
              ),
              _buildCircleAction(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildManyIndexCirclePage(int index) {
    int max = widget.total;
    int currentPage = _controller.page;

    if (index == 2) {
      if (currentPage <= 4) {
        return _buildCirclePage(index);
      } else {
        return _buildCirclePage();
      }
    }

    if (index == 3 && currentPage >= 5) {
      if (currentPage < (max - 3)) {
        return _buildCirclePage(currentPage - 1);
      } else {
        return _buildCirclePage(max - 4);
      }
    }

    if (index == 4 && currentPage >= 5) {
      if (currentPage < (max - 3)) {
        return _buildCirclePage(currentPage);
      } else {
        return _buildCirclePage(max - 3);
      }
    }

    if (index == 5 && currentPage >= 5) {
      if (currentPage < (max - 3)) {
        return _buildCirclePage(currentPage + 1);
      } else {
        return _buildCirclePage(max - 2);
      }
    }

    if (index == 6) {
      if (currentPage < (max - 3)) {
        return _buildCirclePage();
      } else {
        return _buildCirclePage(max - 1);
      }
    }

    if (index == 7) {
      return _buildCirclePage(max);
    }

    return _buildCirclePage(index);
  }

  String generateHeroTag(String baseTag) {
    return '$baseTag-${UniqueKey().toString()}';
  }

  Widget _buildCircleAction({bool isBack = false}) {
    final theme = context.appColors;
    final enabled = widget.enabled &&
        (isBack ? _controller.page != 1 : _controller.page != widget.total);

    return Flexible(
      child: Padding(
        padding: context.spacer.x.xxs,
        child: AbsorbPointer(
          absorbing: !enabled,
          child: FloatingActionButton(
            heroTag: generateHeroTag('paginationButton'),
            mini: true,
            elevation: 0,
            backgroundColor:
                enabled ? theme.brandSecondary.blue : theme.neutral.grey2,
            child: Icon(
              isBack
                  ? widget.leftIcon ?? Icons.chevron_left
                  : widget.rightIcon ?? Icons.chevron_right,
              size: widget.iconSize ?? 34,
              color: enabled ? theme.brand.primary : theme.neutral.grey3,
            ),
            onPressed: () {
              isBack ? _controller.back() : _controller.next();
              if (widget.onChanged != null) {
                widget.onChanged!(_controller.page);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCirclePage([int? page]) {
    final theme = context.appColors;
    final isCurrentPage = page == _controller.page;
    final enabled = widget.enabled && page != null;
    final selectColor =
        widget.enabled ? theme.brandSecondary.blue : theme.neutral.grey2;
    final unselectedTextColor =
        widget.enabled ? theme.neutral.grey3 : theme.neutral.grey1;

    return Flexible(
      child: Padding(
        padding: context.spacer.x.xxxs,
        child: AbsorbPointer(
          absorbing: !enabled,
          child: FloatingActionButton(
            heroTag: generateHeroTag('paginationButton'),
            elevation: 0,
            mini: true,
            backgroundColor: isCurrentPage ? selectColor : theme.neutral.grey1,
            child: Padding(
              padding: const EdgeInsets.only(left: 2, top: 2),
              child: BaseText(
                text: page?.toString() ?? '...',
                fontWeight: isCurrentPage ? FontWeight.w600 : FontWeight.w400,
                color:
                    isCurrentPage ? theme.brand.primary : unselectedTextColor,
              ),
            ),
            onPressed: () {
              if (enabled) {
                _controller.moveTo(page);
                if (widget.onChanged != null) {
                  widget.onChanged!(page);
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
