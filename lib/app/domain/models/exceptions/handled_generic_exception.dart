import 'handled_exception.dart';

class HandledGenericException extends HandledException {
  HandledGenericException([Object? exception])
      : super(
          message: 'Ocorreu um erro inesperado!',
          error: 'Opss!',
          exception: exception,
        );
}
