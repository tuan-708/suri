// import 'dart:async';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'connectivity_event.dart';
// import 'connectivity_state.dart';

// class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;

//   ConnectivityBloc() : super(ConnectivityInitial()) {
//     _connectivitySubscription =
//         Connectivity().onConnectivityChanged.listen((result) {
//       add(ConnectivityChanged(result != ConnectivityResult.none));
//     });

//     on<ConnectivityChanged>((event, emit) {
//       if (event.isConnected) {
//         emit(ConnectivityConnected());
//       } else {
//         emit(ConnectivityDisconnected());
//       }
//     });
//   }

//   @override
//   Future<void> close() {
//     _connectivitySubscription.cancel();
//     return super.close();
//   }s
// }
