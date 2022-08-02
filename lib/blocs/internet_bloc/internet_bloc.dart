import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/blocs/internet_bloc/internet_event.dart';
import 'package:flutterbloc/blocs/internet_bloc/internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  Connectivity connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;
  InternetBloc() : super(InternetInitialState()) {
    on<InternetLostEvent>((event, emit) {
      emit(InternetLostState());
    });
    on<InternetGainedEvent>((event, emit) {
      emit(InternetGainedState());
    });

    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        add(InternetGainedEvent());
      } else {
        add(InternetLostEvent());
      }
    });
  }

  @override
  Future<void> close() {
    connectivitySubscription!.cancel();
    return super.close();
  }
}
