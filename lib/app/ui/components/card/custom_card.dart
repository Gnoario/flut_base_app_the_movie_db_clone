import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flut_base_app_the_movie_db_clone/core/theme/app_colors.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Color? color;

  const CustomCard({
    super.key,
    required this.child,
    this.decoration,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: decoration,
      color: color,
      child: child,
    );
  }

  factory CustomCard.shortMidia({
    required BuildContext context,
    EdgeInsetsGeometry? margin,
    required String name,
    String? releaseDate,
    required String posterPath,
    required double voteAverage,
    required Function() onTap,
  }) {
    return CustomCard(
      height: 380,
      width: 180,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 280,
            child: Stack(
              children: [
                Container(
                  width: 180,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: ClipRRect(
                    borderRadius: context.radius.all.medium,
                    child: InkWell(
                      onTap: onTap,
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500/$posterPath',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: context.appColors.neutral.grey2,
                            child: Center(
                              child: Icon(
                                Icons.image,
                                color: context.appColors.neutral.grey3,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 10,
                  child: CustomBadge(
                    voteAverage: voteAverage,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: context.spacer.value.xxxs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: name,
                      style: TextStyle(
                        fontSize: 16,
                        color: context.appColors.brandSecondary.black,
                        fontWeight: FontWeight.w700,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = onTap,
                    ),
                  ),
                ),
                if (releaseDate != null)
                  Flexible(
                    child: BaseText(
                      text: releaseDate,
                      color: context.appColors.neutral.grey5.withOpacity(0.8),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  factory CustomCard.midia({
    required BuildContext context,
    EdgeInsetsGeometry? margin,
    required String name,
    required String originalName,
    String? releaseDate,
    required String posterPath,
    required String overview,
    required Function() onTap,
  }) {
    return CustomCard(
      height: 143,
      margin: margin,
      decoration: BoxDecoration(
        color: context.appColors.brand.primary,
        borderRadius: context.radius.all.medium,
        boxShadow: [
          BoxShadow(
            color: context.appColors.neutral.grey5.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: context.radius.all.medium,
        child: InkWell(
          onTap: onTap,
          borderRadius: context.radius.all.medium,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 94,
                child: ClipRRect(
                  borderRadius: context.radius.left.medium,
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/$posterPath',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: context.appColors.neutral.grey2,
                        child: Center(
                          child: Icon(
                            Icons.image,
                            color: context.appColors.neutral.grey3,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: context.spacer.value.xs),
              Expanded(
                child: SizedBox(
                  height: 143,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text.rich(
                        maxLines: isResponsiveMode(context) ? 2 : 3,
                        TextSpan(
                          children: [
                            TextSpan(
                              text: name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: ' ($originalName)',
                              style: TextStyle(
                                fontSize: 16,
                                color: context.appColors.neutral.grey4
                                    .withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (releaseDate != null)
                        Flexible(
                          child: BaseText(
                            text: releaseDate,
                            color: context.appColors.neutral.grey4
                                .withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      Flexible(
                        child: BaseText(
                          text: overview,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          color:
                              context.appColors.neutral.grey5.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  factory CustomCard.viewMediaInfo({
    required BuildContext context,
    required String title,
    String? releaseDate,
    required String posterPath,
    required String backdropPath,
    required String overview,
    required double voteAverage,
  }) {
    return CustomCard(
      height: 380,
      child: Stack(
        children: [
          SizedBox(
            height: 380,
            child: Image.network(
              'https://image.tmdb.org/t/p/w500/$backdropPath',
              width: double.infinity,
              fit: BoxFit.fill,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: context.appColors.neutral.grey2,
                  child: Center(
                    child: Icon(
                      Icons.image,
                      color: context.appColors.neutral.grey3,
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: context.appColors.brandSecondary.shadowGradient,
              ),
            ),
          ),
          Positioned.fill(
            right: 16,
            left: 16,
            child: Row(
              children: [
                SizedBox(
                  width: isResponsiveMode(context) ? 110 : 200,
                  child: ClipRRect(
                    borderRadius: context.radius.left.medium,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500/$posterPath',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: context.appColors.neutral.grey2,
                          child: Center(
                            child: Icon(
                              Icons.image,
                              color: context.appColors.neutral.grey3,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: context.spacer.value.xs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            text: title,
                            children: [
                              if (releaseDate != null)
                                TextSpan(
                                  text: ' ($releaseDate)',
                                  style: TextStyle(
                                    color: context.appColors.neutral.grey2
                                        .withOpacity(0.5),
                                  ),
                                ),
                            ],
                            style: TextStyle(
                              fontSize: 18,
                              color: context.appColors.brand.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: context.spacer.value.xxxs),
                      Row(
                        children: [
                          CustomBadge(
                            voteAverage: voteAverage,
                          ),
                          SizedBox(width: context.spacer.value.xxs),
                          BaseText(
                            text: 'Avaliação\ndos\nusuários',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: context.appColors.brand.primary,
                          )
                        ],
                      ),
                      SizedBox(height: context.spacer.value.xxxs),
                      BaseText(
                        text: 'Sinopse',
                        color: context.appColors.brand.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: context.spacer.value.xxxs),
                      BaseText(
                        text: overview,
                        color: context.appColors.brand.primary,
                        fontSize: 14,
                        maxLines: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  factory CustomCard.person({
    required BuildContext context,
    required String name,
    required String profilePath,
    required String character,
  }) {
    return CustomCard(
      height: 266,
      width: 140,
      margin: context.spacer.x.xs,
      decoration: BoxDecoration(
        color: context.appColors.brand.primary,
        borderRadius: context.radius.all.medium,
        border: Border.all(
          color: context.appColors.neutral.grey5.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: context.appColors.neutral.grey5.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            height: 180,
            child: ClipRRect(
              borderRadius: context.radius.top.medium,
              child: Image.network(
                'https://image.tmdb.org/t/p/w500/$profilePath',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: context.appColors.neutral.grey2,
                    child: Center(
                      child: Icon(
                        Icons.image,
                        color: context.appColors.neutral.grey3,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: context.spacer.value.xs),
          Expanded(
            child: Padding(
              padding: context.spacer.x.xxs + context.spacer.y.xxxs,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BaseText(
                    text: name,
                    color: context.appColors.brandSecondary.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  BaseText(
                    text: character,
                    color: context.appColors.brandSecondary.black,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
