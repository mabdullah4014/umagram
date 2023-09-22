import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umagram/drawer/nav_drawer_state.dart';
import 'package:umagram/generated/l10n.dart';
import 'package:umagram/utils/constants.dart';
import 'package:umagram/utils/hex_colors_extension.dart';
import 'package:umagram/utils/utils.dart';

import 'drawer_event.dart';
import 'nav_drawer_bloc.dart';

// ignore: must_be_immutable
class NavDrawerWidget extends StatelessWidget {
  List<_NavigationItem> _listItems;

  @override
  Widget build(BuildContext context) {
    initListItems(context);
    return Container(
        width: MediaQuery.of(context).size.width * 0.7,
        margin: EdgeInsets.only(top: Constants.APP_BAR_HEIGHT),
        child: Drawer(
          child: Container(
            color: HexColor.fromHex(Constants.COLOR_APP_PROGRESS_BAR_BG),
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(color: Colors.white);
                },
                padding: EdgeInsets.zero,
                itemCount: _listItems.length,
                itemBuilder: (BuildContext context, int index) =>
                    BlocBuilder<NavDrawerBloc, NavDrawerState>(
                      builder: (BuildContext context, NavDrawerState state) =>
                          _makeListItem(_listItems[index], state),
                    )),
          ),
        ));
  }

  Widget _makeListItem(_NavigationItem data, NavDrawerState state) => Builder(
      builder: (BuildContext context) => ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            title: Text("${data.title}",
                style: TextStyle(
                    fontSize: 17,
                    color:
                        data.selectedItemsList.contains(state.selectedItem.type)
                            ? HexColor.fromHex(Constants.COLOR_APP_RED)
                            : Colors.white)),
            onTap: () => _handleItemClick(context, data.item),
          ));

  void _handleItemClick(BuildContext context, NavItem item) {
    if (item != NavItem.freeScreen &&
        item != NavItem.introScreen &&
        item != NavItem.privacyPolicy &&
        item != NavItem.termsAndConditions) {
      Utils.purchaseProduct(context, item, fromDrawer: true);
    } else {
      BlocProvider.of<NavDrawerBloc>(context)
          .add(NavigateTo(NavItemClass(item, null)));
      Navigator.pop(context);
    }
  }

  void initListItems(BuildContext context) {
    _listItems = [
      _NavigationItem(NavItem.introScreen, S.of(context).drawer_item_intro,
          [NavItem.introScreen]),
      _NavigationItem(NavItem.freeScreen, S.of(context).drawer_item_free,
          [NavItem.freeScreen, NavItem.freeScreenResult]),
      _NavigationItem(NavItem.paid2, S.of(context).drawer_item_paid2,
          [NavItem.paid2, NavItem.paid2ScreenResult]),
      _NavigationItem(NavItem.paid3, S.of(context).drawer_item_paid3,
          [NavItem.paid3, NavItem.paid3ScreenResult]),
      _NavigationItem(NavItem.paid4, S.of(context).drawer_item_paid4,
          [NavItem.paid4, NavItem.paid4ScreenResult]),
      _NavigationItem(NavItem.paid5, S.of(context).drawer_item_paid5,
          [NavItem.paid5, NavItem.paid5ScreenResult]),
      _NavigationItem(NavItem.paid6, S.of(context).drawer_item_paid6,
          [NavItem.paid6, NavItem.paid6ScreenResult]),
      _NavigationItem(NavItem.fortune, S.of(context).drawer_item_fortune,
          [NavItem.fortune, NavItem.fortuneScreenResult]),
      _NavigationItem(NavItem.termsAndConditions, S.of(context).t_and_c,
          [NavItem.termsAndConditions]),
      _NavigationItem(NavItem.privacyPolicy, S.of(context).privacy_policy,
          [NavItem.privacyPolicy]),
    ];
  }
}

class _NavigationItem {
  final NavItem item;
  final String title;
  final List<NavItem> selectedItemsList;

  _NavigationItem(this.item, this.title, this.selectedItemsList);
}
