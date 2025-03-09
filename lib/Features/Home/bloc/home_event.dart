abstract class HomeEvent {}

class HomeInitializeEvent extends HomeEvent {}

class HomeRefreshDataEvent extends HomeEvent {
  bool isInternet;

  HomeRefreshDataEvent(this.isInternet);
}
