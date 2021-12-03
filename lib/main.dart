import 'package:flutter/material.dart';
import 'package:my_bili_f/db/hi_cache.dart';
import 'package:my_bili_f/model/video_model.dart';
import 'package:my_bili_f/nav/hi_navigator.dart';
import 'package:my_bili_f/pages/home_page.dart';
import 'package:my_bili_f/pages/login_page.dart';
import 'package:my_bili_f/pages/registration_page.dart';
import 'package:my_bili_f/pages/video_detail_page.dart';
import 'package:my_bili_f/util/color.dart';
import 'package:my_bili_f/util/utils.dart';

import 'http/dao/login_dao.dart';

void main() => runApp(const BiliRoot());

class BiliRoot extends StatefulWidget {
  const BiliRoot({Key? key}) : super(key: key);

  @override
  _BiliRootState createState() => _BiliRootState();
}

class _BiliRootState extends State<BiliRoot> {
  final BiliRouteDelegate _routerDelegate = BiliRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache?>(
      future: HiCache.preInit(),
      builder: (BuildContext context, AsyncSnapshot<HiCache?> snapshot) {
        Widget widget = snapshot.connectionState == ConnectionState.done
            ? Router(
                routerDelegate: _routerDelegate,
              )
            : const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
        return MaterialApp(
          home: widget,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: white,
          ),
        );
      },
    );
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRouterPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  /// 为Navigator 设置一个key， 关键时刻可以通过navigatorKey.currentState 获取NavigatorState对象
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();
  RoutesStatus _routesStatus = RoutesStatus.home;
  List<MaterialPage> pages = [];
  VideoModel? _videoModel;

  bool get hasLogin => LoginDao.getToken() != null;

  RoutesStatus get routesStatus {
    if (_routesStatus != RoutesStatus.registration && !hasLogin) {
      return _routesStatus = RoutesStatus.login;
    } else if (_videoModel != null) {
      return _routesStatus = RoutesStatus.detail;
    } else {
      return _routesStatus;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// 管理路由堆栈
    var index = getPageIndex(pages, routesStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      /// 打开的页面已经在路由堆栈中存在 就把上面的路由堆栈全部出栈
      /// 具体需求可调整 这里要求只允许在堆栈中有一个同样的页面实例
      tempPages.sublist(0, index);
    }
    var page;
    if (routesStatus == RoutesStatus.home) {
      /// 首页不可回退
      pages.clear();
      page = pageWrap(
        HomePage(
          onJumpDetail: (_videoModel) {
            this._videoModel = _videoModel;
            notifyListeners();
          },
        ),
      );
    } else if (routesStatus == RoutesStatus.detail) {
      page = pageWrap(
        VideoDetailPage(VideoModel(7777)),
      );
    } else if (routesStatus == RoutesStatus.registration) {
      page = pageWrap(
        RegistrationPage(onJumpLogin: () {
          _routesStatus = RoutesStatus.login;
          notifyListeners();
        }),
      );
    } else if (routesStatus == RoutesStatus.login) {
      page = pageWrap(LoginPage(
        onJumpRegistration: () {
          _routesStatus = RoutesStatus.registration;
          notifyListeners();
        },
        onLoginSuc: () {
          _routesStatus = RoutesStatus.home;
          notifyListeners();
        },
      ));
    }
    // 重新创建一个数组 否则pages 因引用没有改变路由不会生效
    tempPages = [...tempPages, page];
    pages = tempPages;
    return WillPopScope(
        child: Navigator(
          key: navigatorKey,
          pages: pages,

          /// 在这里可以控制是否可以返回
          onPopPage: (route, result) {
            if (route.settings is MaterialPage) {
              /// 登录页未登录反击拦截
              if ((route.settings as MaterialPage).child is LoginPage) {
                if (!hasLogin) {
                  Utils.showAlarmToast(message: '请先登录!');

                  /// return false 拦截返回
                  return false;
                }
              }
            }
            if (!route.didPop(result)) {
              return false;
            }
            pages.removeLast();
            return true;
          },
        ),
        onWillPop: () async {
          return !await navigatorKey.currentState!.maybePop();
        });
  }

  @override
  Future<void> setNewRoutePath(BiliRouterPath configuration) async {}
}

/// 定义路由数据 path

class BiliRouterPath {
  final String location;

  BiliRouterPath.home() : location = '/';

  BiliRouterPath.detail() : location = '/detail';
}

/// 创建路由页面
pageWrap(Widget child) {
  return MaterialPage(child: child, key: ValueKey(child.hashCode));
}
