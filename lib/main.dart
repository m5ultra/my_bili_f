import 'package:flutter/material.dart';
import 'package:my_bili_f/model/video_model.dart';
import 'package:my_bili_f/pages/home_page.dart';
import 'package:my_bili_f/pages/video_detail_page.dart';

void main() {
  runApp(const BiliRoot());
}

class BiliRoot extends StatefulWidget {
  const BiliRoot({Key? key}) : super(key: key);

  @override
  _BiliRootState createState() => _BiliRootState();
}

class _BiliRootState extends State<BiliRoot> {
  final BiliRouteDelegate _routerDelegate = BiliRouteDelegate();
  final BiliRouterInformationParser _routerInformationParser =
      BiliRouterInformationParser();

  @override
  Widget build(BuildContext context) {
    var widget = Router(
      routerDelegate: _routerDelegate,
      routeInformationParser: _routerInformationParser,

      ///routeInformationParser 为null可以缺省
      routeInformationProvider: PlatformRouteInformationProvider(
          initialRouteInformation: const RouteInformation(location: '/')),
    );

    return MaterialApp(
      home: widget,
      debugShowCheckedModeBanner: false,
    );
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRouterPah>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();
  List<MaterialPage> pages = [];
  VideoModel? _videoModel;
  BiliRouterPah? path;

  @override
  Widget build(BuildContext context) {
    /// 构建路由堆栈
    pages = [
      pageWrap(
        HomePage(
          onJumpDetail: (_videoModel) {
            _videoModel = _videoModel;
            notifyListeners();
          },
        ),
      ),
      if (_videoModel != null) pageWrap(VideoDetailPage(_videoModel!))
    ];
    return Navigator(
      key: navigatorKey,
      pages: pages,

      /// 在这里可以控制是否可以返回
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BiliRouterPah configuration) async {
    path = configuration;
  }
}

/// 可缺省
class BiliRouterInformationParser
    extends RouteInformationParser<BiliRouterPah> {
  @override
  Future<BiliRouterPah> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.isEmpty) {
      return BiliRouterPah.home();
    }
    return BiliRouterPah.detail();
  }
}

/// 定义路由数据 path

class BiliRouterPah {
  final String location;

  BiliRouterPah.home() : location = '/';

  BiliRouterPah.detail() : location = '/detail';
}

/// 创建路由页面
pageWrap(Widget child) {
  return MaterialPage(child: child, key: ValueKey(child.hashCode));
}
