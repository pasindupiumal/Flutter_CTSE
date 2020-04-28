import 'package:ctseprojectapp/screens/home/app_flow.dart';
import 'package:ctseprojectapp/screens/home/browse.dart';
import 'package:ctseprojectapp/screens/home/cart.dart';
import 'package:ctseprojectapp/screens/home/history.dart';
import 'package:ctseprojectapp/screens/home/profile.dart';
import 'package:ctseprojectapp/services/auth.dart';
import 'package:flutter/material.dart';

import 'foodItem.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _authService = new AuthService();
  int _currentIndex = 0;
  bool loading = false;
  final List<AppFlow> appFlows = [
    AppFlow(
      title: 'Browse',
      iconData: Icons.home,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlow(
      title: 'Cart',
      iconData: Icons.shopping_cart,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlow(
      title: 'History',
      iconData: Icons.history,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlow(
      title: 'Profile',
      iconData: Icons.person,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
  ];
  List<FoodItem> cartList = [];


  @override
  Widget build(BuildContext context) {

    final currentFlow = appFlows[_currentIndex];

    return WillPopScope(

      onWillPop: () async => !await currentFlow.navigatorKey.currentState.maybePop(),

      child: Scaffold(

        appBar: AppBar(

          backgroundColor: Colors.blueAccent,
          title: Text('Flutter Eats'),
          actions: <Widget>[
            FlatButton.icon(

              icon: Icon(Icons.person, color:Colors.white,),
              label: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {

                await _authService.signOut();
              },

            )
          ],
        ),

        body: IndexedStack(
          index: _currentIndex,
          children: appFlows.map(
            _buildIndexedPageFlow,
          ).toList(),
        ),

        bottomNavigationBar: BottomNavigationBar(

          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: appFlows.map(
              (flow) => BottomNavigationBarItem(
                title: Text(flow.title),
                icon: Icon(flow.iconData),
              )
          ).toList(),
          onTap: (newIndex) => setState(
              () {
                if(_currentIndex != newIndex){
                  _currentIndex = newIndex;
                }
                else{
                  currentFlow.navigatorKey.currentState.popUntil((route) => route.isFirst);
                }
              }
          ),
        ),
      ),
    );
  }

  Widget getPage(int index){

    if (index == 0){
      return Browse(pushPage: pushPage, cartList: cartList);
    }
    else if(index == 1){
      return Cart(pushPage: pushPage, cartList: cartList);
    }
    else if(index == 2){
      return History(pushPage: pushPage);
    }
    else if(index == 3){
      return Profile(pushPage: pushPage);
    }
    else{
      return Home();
    }

  }

  void pushPage(BuildContext context, bool isHorizontalNavigation, int pageIndex) {

    Navigator.of(context, rootNavigator: !isHorizontalNavigation).push(
      MaterialPageRoute(
        builder: (context) => getPage(pageIndex),
        fullscreenDialog: !isHorizontalNavigation,
      ),
    );
  }

  Widget _buildIndexedPageFlow(AppFlow appFlow) => Navigator(

    key: appFlow.navigatorKey,

    onGenerateRoute: (settings) => MaterialPageRoute(

      settings: settings,
      builder: (context) => getPage(_currentIndex),
    )
  );
}
