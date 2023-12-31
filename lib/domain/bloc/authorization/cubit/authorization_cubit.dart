import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../models/enum/auth_status.dart';
import '../../../repository/authorization_repository.dart';

@injectable
class AuthorizationCubit extends Cubit<AuthStatus> {
  AuthorizationCubit(
    this._authorizationRepository,
  ) : super(
          _authorizationRepository.getAuthStatus(),
        ) {
    _streamSubscription = _authorizationRepository.authStatusStream.listen(
      (AuthStatus status) {
        emit(status);
      },
    );
  }

  late final StreamSubscription<AuthStatus> _streamSubscription;
  final AuthorizationRepository _authorizationRepository;

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();

    return super.close();
  }
}
