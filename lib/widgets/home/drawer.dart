import 'package:flutter/material.dart';
import 'package:linwood_app/pages.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({@required this.permanentlyDisplay, Key key}) : super(key: key);

  final bool permanentlyDisplay;
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> with RouteAware {
  String _selectedRoute;
  AppRouteObserver _routeObserver;
  @override
  void initState() {
    super.initState();
    _routeObserver = AppRouteObserver();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    _routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    _updateSelectedRoute();
    super.didPush();
  }

  @override
  void didPop() {
    _updateSelectedRoute();
    super.didPop();
  }

  @override
  Widget build(BuildContext context) {
    // return Drawer(
    //     child: Row(children: [
    //   Expanded(
    //       child: ListView(padding: EdgeInsets.zero, children: [
    //     DrawerHeader(
    //       child: Column(children: [
    //         Center(
    //           child: new ListView(
    //             shrinkWrap: true,
    //             scrollDirection: Axis.horizontal,
    //             padding: const EdgeInsets.all(20.0),
    //             children: [
    //               IconButton(
    //                 icon: Icon(MdiIcons.cogs),
    //                 onPressed: () {},
    //               ),
    //               IconButton(
    //                 icon: Icon(MdiIcons.logout),
    //                 onPressed: () {},
    //               )
    //             ],
    //           ),
    //         ),
    //         Image.asset(
    //           "assets/icon.png",
    //           height: 70,
    //         ),
    //         SizedBox(
    //           height: 50,
    //         ),
    //         Text("Evervent", style: Theme.of(context).textTheme.headline5),
    //         Text("github.com/codedoctorde/evervent",
    //             style: Theme.of(context).textTheme.subtitle1),
    //       ]),
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.home),
    //       title: const Text("Home"),
    //       onTap: () async {
    //         await _navigateTo(context, RoutePages.home);
    //       },
    //       selected: _selectedRoute == RoutePages.home,
    //     ),
    //     ListTile(
    //       leading: const Icon(Icons.home),
    //       title: const Text("Settings"),
    //       onTap: () async {
    //         await _navigateTo(context, RoutePages.settings);
    //       },
    //       selected: _selectedRoute == RoutePages.settings,
    //     ),
    //   ]))
    // ]));
    return SafeArea(
        right: false,
        child: Drawer(
            child: Row(children: [
          Expanded(
            child: ListView(padding: EdgeInsets.zero, children: [
              Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).backgroundColor.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        )
                      ]),
                  child: IconTheme(
                      data: Theme.of(context).iconTheme,
                      child: ExpansionTile(
                          title: Text("CodeDoctor"),
                          leading: Image.asset("assets/icon.png", height: 25),
                          children: [
                            Wrap(direction: Axis.horizontal, children: [
                              IconButton(
                                  icon: Icon(MdiIcons.accountOutline),
                                  onPressed: () {
                                    _navigateTo(context, RoutePages.user);
                                  },
                                  tooltip: "Account"),
                              IconButton(
                                  icon: Icon(MdiIcons.helpCircleOutline),
                                  onPressed: () async {
                                    await launch("https://wiki.linwood.tk", forceWebView: true);
                                  },
                                  tooltip: "Help"),
                              IconButton(
                                  icon: Icon(MdiIcons.cogs),
                                  onPressed: () async {
                                    await _navigateTo(context, RoutePages.settings);
                                  },
                                  tooltip: "Settings"),
                              IconButton(
                                  icon: Icon(MdiIcons.logout), onPressed: () {}, tooltip: "Logout")
                            ])
                          ]))),
              Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  height: 350,
                  child: DrawerHeader(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      "assets/icon.png",
                      height: 70,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text("Linwood", style: Theme.of(context).textTheme.headline5),
                    Text("Open source discord bot platform",
                        style: Theme.of(context).textTheme.subtitle2),
                  ]))),
              ListTile(
                leading: const Icon(MdiIcons.homeOutline),
                title: const Text("Home"),
                onTap: () async {
                  await _replaceNavigateTo(context, RoutePages.home);
                },
                selected: _selectedRoute == RoutePages.home,
              ),
              ListTile(
                leading: const Icon(MdiIcons.forumOutline),
                title: const Text("Guilds"),
                onTap: () async {
                  await _replaceNavigateTo(context, RoutePages.guilds);
                },
                selected: _selectedRoute == RoutePages.guilds,
              ),
              ListTile(
                leading: const Icon(MdiIcons.newspaperVariantMultipleOutline),
                title: const Text("Wikis"),
                onTap: () async {
                  await _replaceNavigateTo(context, RoutePages.wikis);
                },
                selected: _selectedRoute == RoutePages.wikis,
              ),
              ListTile(
                leading: const Icon(MdiIcons.bellOutline),
                title: const Text("Notification"),
                onTap: () async {
                  await _replaceNavigateTo(context, RoutePages.notification);
                },
                selected: _selectedRoute == RoutePages.notification,
              )
            ]),
          ),
          if (widget.permanentlyDisplay)
            const VerticalDivider(
              width: 5,
              thickness: 0.5,
            )
        ])));
  }

  /// Closes the drawer if applicable (which is only when it's not been displayed permanently) and navigates to the specified route
  /// In a mobile layout, the a modal drawer is used so we need to explicitly close it when the user selects a page to display
  Future<void> _navigateTo(BuildContext context, String routeName) async {
    if (!widget.permanentlyDisplay) Navigator.pop(context);
    await Navigator.pushNamed(context, routeName);
  }

  /// Closes the drawer if applicable (which is only when it's not been displayed permanently) and navigates to the specified route
  /// In a mobile layout, the a modal drawer is used so we need to explicitly close it when the user selects a page to display
  Future<void> _replaceNavigateTo(BuildContext context, String routeName) async {
    if (!widget.permanentlyDisplay) Navigator.pop(context);
    await Navigator.pushReplacementNamed(context, routeName);
  }

  void _updateSelectedRoute() {
    setState(() {
      _selectedRoute = ModalRoute.of(context).settings.name;
    });
  }
}
