import 'package:commitment_tracker/base/base_stateful.dart';
import 'package:commitment_tracker/common/api/session_timer.dart';
import 'package:commitment_tracker/common/api/user_secure_storage.dart';
import 'package:commitment_tracker/common/components/drawer_list.dart';
import 'package:commitment_tracker/common/utils/constant.dart';
import 'package:commitment_tracker/common/utils/route_generator.dart';
import 'package:commitment_tracker/common/utils/tab_item.dart';
import 'package:commitment_tracker/common/utils/utils.dart';
import 'package:commitment_tracker/models/security_model.dart';
import 'package:commitment_tracker/screens/tab_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiver/async.dart';

import 'authentication_screen.dart';
import 'cryptography_screen.dart';
import 'device_info_screen.dart';
import 'expansion_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStateful<HomeScreen> with WidgetsBindingObserver {
  SecurityModel _securityModel = SecurityModel();
  TabItem _currentTab = TabItem.expansion;
  String title = tabName[TabItem.expansion];
  List<Widget> _children;

  bool loading = true;
  bool isAuthenticate = false;
  String email;
  String password;

  CountdownTimer _countdownTimer;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (isAuthenticate) {
      print("AppLifecycleState :::: $state");
      if (state == AppLifecycleState.paused) {
        _countdownTimer = SessionTimer.start(context);
      } else if (state == AppLifecycleState.resumed) {
        if (_countdownTimer != null && _countdownTimer.remaining > Duration(seconds: 0)) {
          print("AppLifeCycleState timer didn't complete");
          //Let user continue using the app
        } else {
          print("AppLifeCycleState timeout!");
        }
        _countdownTimer = SessionTimer.stop();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    initPlatformState();
    init();
    _children = [
      AuthenticationScreen(
        onInit: init,
        selectedTab: selectTab,
      ),
      ExpansionScreen(),
      DeviceInfoScreen(),
      CryptographyScreen(),
      TabOne(title: tabName[TabItem.pageOne]),
      // TabTwo(title: tabName[TabItem.pageTwo]),
    ];

    // You can let the plugin handle fetching the status and showing a dialog,
    Utils.basicAppVersionCheck(context);
    // or you can fetch the status and display your own dialog, or no dialog.
    // Utils.advancedStatusCheck(context);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future init() async {
    final secureEmail = await UserSecureStorage.getSecureData(Constants.skEmail);
    final securePassword = await UserSecureStorage.getSecureData(Constants.skPassword);
    if (secureEmail.isNotNullOrEmpty && securePassword.isNotNullOrEmpty) {
      setState(() {
        email = secureEmail;
        password = securePassword;
        isAuthenticate = true;
        loading = false;
      });
    } else {
      setState(() {
        email = secureEmail;
        password = securePassword;
        isAuthenticate = false;
        loading = false;
        _currentTab = TabItem.signIn;
        title = tabName[TabItem.signIn];
      });
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    SecurityModel result = await Utils.safeDeviceCheck(context);
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _securityModel = result;
    });
  }

  bool closeApp() {
    SystemNavigator.pop();
    return false;
  }

  Future logout() async {
    await UserSecureStorage.deleteAll();
    Navigator.pushReplacementNamed(context, Routes.logout);
    // init();
  }

  void selectTab(TabItem tabItem, {bool isChangeTab, bool hasUser}) {
    setState(() {
      if (isChangeTab && hasUser) {
        _currentTab = tabItem;
        title = tabName[tabItem];
      } else {
        _currentTab = TabItem.signIn;
        title = tabName[TabItem.signIn];
      }
    });
  }

  @override
  List<Widget> getAction() => null;

  @override
  String getAppTitle() => title;

  @override
  Widget getBottomNavigation() => null;

  @override
  Widget getDrawer() => isAuthenticate
      ? Drawer(
          child: Column(
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.asset('assets/ic_launcher.png').image,
                            ),
                          ),
                        ),
                        Text(
                          'Set text to something',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )),
              !isAuthenticate
                  ? DrawerList(
                      tabItem: TabItem.signIn,
                      currentTab: _currentTab,
                      onTap: () {
                        selectTab(TabItem.signIn, isChangeTab: false, hasUser: isAuthenticate);
                      },
                    )
                  : Container(),
              DrawerList(
                tabItem: TabItem.expansion,
                currentTab: _currentTab,
                onTap: () {
                  selectTab(TabItem.expansion, isChangeTab: true, hasUser: isAuthenticate);
                },
              ),
              DrawerList(
                tabItem: TabItem.deviceInfo,
                currentTab: _currentTab,
                onTap: () {
                  selectTab(TabItem.deviceInfo, isChangeTab: true, hasUser: isAuthenticate);
                },
              ),
              DrawerList(
                tabItem: TabItem.cryptography,
                currentTab: _currentTab,
                onTap: () {
                  selectTab(TabItem.cryptography, isChangeTab: true, hasUser: isAuthenticate);
                },
              ),
              DrawerList(
                tabItem: TabItem.pageOne,
                currentTab: _currentTab,
                onTap: () {
                  selectTab(TabItem.pageOne, isChangeTab: true, hasUser: isAuthenticate);
                },
              ),
              // DrawerList(
              //   tabItem: TabItem.pageTwo,
              //   currentTab: _currentTab,
              //   onTap: () {
              //     selectTab(TabItem.pageTwo, isChangeTab: true, hasUser: isAuthenticate);
              //   },
              // ),
              isAuthenticate
                  ? DrawerList(
                      tabItem: TabItem.logout,
                      currentTab: _currentTab,
                      onTap: () {
                        logout();
                        selectTab(TabItem.signIn, isChangeTab: true, hasUser: isAuthenticate);
                      },
                    )
                  : Container(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            'isJailBroken: ${_securityModel.isJailBroken == null ? "Unknown" : _securityModel.isJailBroken ? "YES" : "NO"}'),
                        Text(
                            'isRealDevice: ${_securityModel.isRealDevice == null ? "Unknown" : _securityModel.isRealDevice ? "YES" : "NO"}'),
                        Text(
                            'isOnExternalStorage: ${_securityModel.isOnExternalStorage == null ? "Unknown" : _securityModel.isOnExternalStorage ? "YES" : "NO"}'),
                        Text(
                            'isSafeDevice: ${_securityModel.isSafeDevice == null ? "Unknown" : _securityModel.isSafeDevice ? "YES" : "NO"}'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      : null;

  @override
  Widget getFloatingActionButton() => null;

  @override
  Widget getChildView() => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: loading
              ? Container()
              : !isAuthenticate
                  ? _children[0]
                  : _children[_currentTab.index],
        ),
      );
}
