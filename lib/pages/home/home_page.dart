
import 'package:flutter/material.dart';
import 'package:flutterhuquan/config/appcolors.dart';
import 'package:flutterhuquan/config/dimens.dart';
import 'package:flutterhuquan/pages/account/page/account_page.dart';
import 'package:flutterhuquan/pages/home/provider/home_provider.dart';
import 'package:flutterhuquan/util/double_tap_back_exit_app.dart';
import 'package:flutterhuquan/util/theme_utils.dart';
import 'package:flutterhuquan/widgets/load_image.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _pageList;
  
  var _appBarTitles = ['首页', '分类', '搜索', '我的'];
  final _pageController = PageController();

  HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem> _list;
  List<BottomNavigationBarItem> _listDark;

  @override
  void initState() {
    super.initState();
    initData();
  }
  
  void initData() {
    _pageList = [
      AccountPage(),
      AccountPage(),
      AccountPage(),
      AccountPage(),
    ];
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
    if (_list == null) {
      var _tabImages = [
        [
          const LoadAssetImage('home/icon_order', width: 25.0, color: AppColors.unselected_item_color,),
          const LoadAssetImage('home/icon_order', width: 25.0, color: AppColors.app_main,),
        ],
        [
          const LoadAssetImage('home/icon_commodity', width: 25.0, color: AppColors.unselected_item_color,),
          const LoadAssetImage('home/icon_commodity', width: 25.0, color: AppColors.app_main,),
        ],
        [
          const LoadAssetImage('home/icon_statistics', width: 25.0, color: AppColors.unselected_item_color,),
          const LoadAssetImage('home/icon_statistics', width: 25.0, color: AppColors.app_main,),
        ],
        [
          const LoadAssetImage('home/icon_shop', width: 25.0, color: AppColors.unselected_item_color,),
          const LoadAssetImage('home/icon_shop', width: 25.0, color: AppColors.app_main,),
        ]
      ];
      _list = List.generate(4, (i) {
        return BottomNavigationBarItem(
            icon: _tabImages[i][0],
            activeIcon: _tabImages[i][1],
            title: Padding(
              padding: const EdgeInsets.only(top: 1.5),
              child: Text(_appBarTitles[i], key: Key(_appBarTitles[i]),),
            )
        );
      });
    }
    return _list;
  }

  List<BottomNavigationBarItem> _buildDarkBottomNavigationBarItem() {
    if (_listDark == null) {
      var _tabImagesDark = [
        [
          const LoadAssetImage('home/icon_order', width: 25.0),
          const LoadAssetImage('home/icon_order', width: 25.0, color: AppColors.dark_app_main,),
        ],
        [
          const LoadAssetImage('home/icon_commodity', width: 25.0),
          const LoadAssetImage('home/icon_commodity', width: 25.0, color: AppColors.dark_app_main,),
        ],
        [
          const LoadAssetImage('home/icon_statistics', width: 25.0),
          const LoadAssetImage('home/icon_statistics', width: 25.0, color: AppColors.dark_app_main,),
        ],
        [
          const LoadAssetImage('home/icon_shop', width: 25.0),
          const LoadAssetImage('home/icon_shop', width: 25.0, color: AppColors.dark_app_main,),
        ]
      ];

      _listDark = List.generate(4, (i) {
        return BottomNavigationBarItem(
            icon: _tabImagesDark[i][0],
            activeIcon: _tabImagesDark[i][1],
            title: Padding(
              padding: const EdgeInsets.only(top: 1.5),
              child: Text(_appBarTitles[i], key: Key(_appBarTitles[i]),),
            )
        );
      });
    }
    return _listDark;
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => provider,
      child: DoubleTapBackExitApp(
        child: Scaffold(
          bottomNavigationBar: Consumer<HomeProvider>(
            builder: (_, provider, __) {
              return BottomNavigationBar(
                backgroundColor: ThemeUtils.getBackgroundColor(context),
                items: isDark ? _buildDarkBottomNavigationBarItem() : _buildBottomNavigationBarItem(),
                type: BottomNavigationBarType.fixed,
                currentIndex: provider.value,
                elevation: 5.0,
                iconSize: 21.0,
                selectedFontSize: Dimens.font_sp10,
                unselectedFontSize: Dimens.font_sp10,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: isDark ? AppColors.dark_unselected_item_color : AppColors.unselected_item_color,
                onTap: (index) => _pageController.jumpToPage(index),
              );
            },
          ),
          // 使用PageView的原因参看 https://zhuanlan.zhihu.com/p/58582876
          body: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _pageList,
            physics: NeverScrollableScrollPhysics(), // 禁止滑动
          )
        ),
      ),
    );
  }

  void _onPageChanged(int index) {
    provider.value = index;
  }

}
