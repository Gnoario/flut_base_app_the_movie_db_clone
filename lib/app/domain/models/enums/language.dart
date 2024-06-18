import 'package:recase/recase.dart';

enum Language { ptBR, enUS }

extension ELanguage on Language {
  String get nameConstantCase => name.constantCase;
  String get nameSnakeCase => name.snakeCase;

  String get description {
    final action = {
      Language.ptBR: 'Português',
      Language.enUS: 'Inglês',
    };

    return action[this] ?? 'none';
  }

  String get convertedType => {
        Language.ptBR: 'pt-BR',
        Language.enUS: 'en-US',
      }[this]!;
}
