import 'package:flutter/material.dart';
import 'package:my_bili_f/pages/home_page.dart';
import 'package:my_bili_f/pages/login_page.dart';
import 'package:my_bili_f/pages/registration_page.dart';
import 'package:my_bili_f/pages/video_detail_page.dart';

/// 创建路由页面
pageWrap(Widget child) {
  return MaterialPage(child: child, key: ValueKey(child.hashCode));
}

/// 获取路由页面在堆栈中的位置
int getPageIndex(List<MaterialPage> pages, RoutesStatus routesStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routesStatus) {
      return i;
    }
  }
  return -1;
}

/// 自定义路由的封装

enum RoutesStatus {
  login,
  registration,
  home,
  detail,
  unknown,
}

/// 获取page对应的RoutesStatus
RoutesStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RoutesStatus.login;
  } else if (page.child is RegistrationPage) {
    return RoutesStatus.registration;
  } else if (page.child is HomePage) {
    return RoutesStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RoutesStatus.detail;
  } else {
    return RoutesStatus.unknown;
  }
}

/// 封装路由信息

class RouteStatusInfo {
  final RoutesStatus routesStatus;
  final Widget page;

  RouteStatusInfo(this.routesStatus, this.page);
}
