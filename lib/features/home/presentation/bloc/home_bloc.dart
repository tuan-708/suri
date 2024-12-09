import 'package:bloc/bloc.dart';
import 'package:suri_checking_event_app/features/home/domain/usecase/home_usecase.dart';
import 'package:suri_checking_event_app/features/home/presentation/bloc/home_event.dart';
import 'package:suri_checking_event_app/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCases homeUseCases;

  HomeBloc({required this.homeUseCases}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
  }
}
