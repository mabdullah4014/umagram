
import 'nav_drawer_state.dart';

abstract class NavDrawerEvent {
  const NavDrawerEvent();
}

class NavigateTo extends NavDrawerEvent {
  final NavItemClass destination;

  const NavigateTo(this.destination);
}
