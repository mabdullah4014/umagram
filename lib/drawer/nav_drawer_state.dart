class NavDrawerState {
  final NavItemClass selectedItem;

  const NavDrawerState(this.selectedItem);
}

enum NavItem {
  introScreen,
  freeScreen,
  freeScreenResult,
  paid2,
  paid2ScreenResult,
  paid3,
  paid3ScreenResult,
  paid4,
  paid4ScreenResult,
  paid5,
  paid5ScreenResult,
  paid6,
  paid6ScreenResult,
  fortune,
  fortuneScreenResult,
  termsAndConditions,
  privacyPolicy
}

class NavItemClass {
  final NavItem type;
  final Object arguments;

  NavItemClass(this.type, this.arguments);
}
