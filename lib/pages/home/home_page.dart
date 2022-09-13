import 'package:animated_icon/animate_icon.dart';
import 'package:animated_icon/animate_icons.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/controllers/recommeded_product_controller.dart';
import 'package:e_commerce/pages/account/account_page.dart';
import 'package:e_commerce/pages/cart/cart_history.dart';
import 'package:e_commerce/pages/home/main_food_page.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
    // Get.find<CartController>();
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
  }

  Future<void> initConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      _loadResources();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      _loadResources();
    } else {
      Get.snackbar("No internet connection", "Connect and tap the refresh icon",
          duration: const Duration(hours: 2),
          icon: AnimateIcon(
              height: Dimensions.height20,
              onTap: () {
                Get.closeCurrentSnackbar();
                _loadResources();
              },
              iconType: IconType.animatedOnTap,
              animateIcon: AnimateIcons.refresh),
          colorText: Colors.red.withAlpha(200));
    }
  }

  // late PersistentTabController _controller;

  List pages = [
    const MainFoodPage(),
    const Center(child: Text("History page")),
    const CartHistory(),
    const AccountPage(),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = PersistentTabController(initialIndex: 0);
  // }
// Flutter default bottomNavigationBar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appBar(),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.amberAccent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          currentIndex: _selectedIndex,
          onTap: onTapNav,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: "home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.archive,
                ),
                label: "history"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                label: "cart"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "me"),
          ]),
    );
  }

  //persistent_bottom_nav_bar plugin
  // List<Widget> _buildScreens() {
  //   return [
  //     MainFoodPage(),
  //     Container(
  //       child: Center(child: Text("Next page")),
  //     ),
  //     Container(
  //       child: Center(child: Text("Next next page")),
  //     ),
  //     Container(
  //       child: Center(child: Text("Next next  next page")),
  //     ),
  //   ];
  // }

  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //   return [
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.home),
  //       title: ("Home"),
  //       activeColorPrimary: AppColors.mainColor,
  //       inactiveColorPrimary: Colors.amberAccent,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.archive),
  //       title: ("Archive"),
  //       activeColorPrimary: AppColors.mainColor,
  //       inactiveColorPrimary: Colors.amberAccent,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.shopping_cart),
  //       title: ("Cart"),
  //       activeColorPrimary: AppColors.mainColor,
  //       inactiveColorPrimary: Colors.amberAccent,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.person),
  //       title: ("Me"),
  //       activeColorPrimary: AppColors.mainColor,
  //       inactiveColorPrimary: Colors.amberAccent,
  //     ),
  //   ];
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return PersistentTabView(
  //     context,
  //     controller: _controller,
  //     screens: _buildScreens(),
  //     items: _navBarsItems(),
  //     confineInSafeArea: true,
  //     backgroundColor: Colors.white, // Default is Colors.white.
  //     handleAndroidBackButtonPress: true, // Default is true.
  //     resizeToAvoidBottomInset:
  //         true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
  //     stateManagement: true, // Default is true.
  //     hideNavigationBarWhenKeyboardShows:
  //         true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
  //     decoration: NavBarDecoration(
  //       borderRadius: BorderRadius.circular(10.0),
  //       colorBehindNavBar: Colors.white,
  //     ),
  //     popAllScreensOnTapOfSelectedTab: true,
  //     popActionScreens: PopActionScreensType.all,
  //     itemAnimationProperties: ItemAnimationProperties(
  //       // Navigation Bar's items animation properties.
  //       duration: Duration(milliseconds: 200),
  //       curve: Curves.ease,
  //     ),
  //     screenTransitionAnimation: ScreenTransitionAnimation(
  //       // Screen transition animation on change of selected tab.
  //       animateTabTransition: true,
  //       curve: Curves.ease,
  //       duration: Duration(milliseconds: 200),
  //     ),
  //     navBarStyle:
  //         NavBarStyle.style1, // Choose the nav bar style with this property.
  //   );
  // }

  // _appBar() {
  //   return AppBar(
  //     elevation: 0,
  //     backgroundColor: context.theme.backgroundColor,
  //     leading: InkWell(
  //       onTap: () {
  //         ThemeServices().switchTheme();
  //         // notifyHelper.displayNotification(
  //         //   title: "Theme Changed",
  //         //   body: Get.isDarkMode
  //         //       ? "Activated Light Theme"
  //         //       : "Activated Dark Theme",
  //         // );

  //         // notifyHelper.scheduledNotification();
  //       },
  //       child: Icon(
  //         Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
  //         size: 20,
  //         color: Get.isDarkMode ? Colors.white : Colors.black,
  //       ),
  //     ),
  //     // actions: const [
  //     //   CircleAvatar(
  //     //     backgroundImage: AssetImage("images/profile.jpg"),
  //     //   ),
  //     //   SizedBox(
  //     //     width: 20,
  //     //   ),
  //     // ],
  //   );
  // }
}
