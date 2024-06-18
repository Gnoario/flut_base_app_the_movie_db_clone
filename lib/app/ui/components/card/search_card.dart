import 'package:flut_base_app_the_movie_db_clone/app/ui/components/components.dart';
import 'package:flut_base_app_the_movie_db_clone/core/theme/theme.dart';
import 'package:flut_base_app_the_movie_db_clone/shared/shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchCard extends StatelessWidget {
  final String? bannerPath;
  final Function(String?) onFieldSubmitted;
  final Function() onTapButton;
  final Function(String?) onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const SearchCard({
    super.key,
    required this.bannerPath,
    required this.onFieldSubmitted,
    required this.onTapButton,
    required this.onChanged,
    this.focusNode,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(
          width: double.infinity,
          height: 280,
        ),
        if (bannerPath != null)
          Image.network(
            'https://image.tmdb.org/t/p/w500/$bannerPath',
            fit: BoxFit.fill,
            width: double.infinity,
            height: 280,
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
            errorBuilder: (context, _, __) {
              return Container(
                color: context.appColors.brand.primary,
                height: 280,
                child: Center(
                  child: Icon(
                    Icons.error,
                    color: context.appColors.neutral.grey3,
                  ),
                ),
              );
            },
          ),
        Positioned.fill(
          child: Container(
            color: context.appColors.brandSecondary.accentBlue,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 16,
          right: 16,
          top: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseText(
                text: 'Bem-Vindo(a)',
                fontSize: isResponsiveMode(context) ? 24 : 32,
                fontWeight: FontWeight.bold,
                color: context.appColors.brand.primary,
              ),
              BaseText(
                text:
                    'Milhões de Filmes, Séries e Pessoas para Descobrir. Explore já.',
                maxLines: 2,
                fontSize: isResponsiveMode(context) ? 20 : 24,
                fontWeight: FontWeight.w700,
                color: context.appColors.brand.primary,
              ),
              SizedBox(height: context.spacer.value.sm),
              SizedBox(
                height: kIsWeb ? 40 : 50,
                child: BasicField(
                  onFieldSubmitted: onFieldSubmitted,
                  onChanged: onChanged,
                  focusNode: focusNode,
                  labelText: 'Buscar por um Filme...',
                  onTapButton: onTapButton,
                  controller: controller,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
