
import 'package:fluro/fluro.dart';
import 'package:flutterhuquan/pages/account/page/account_page.dart';
import 'package:flutterhuquan/routers/router_init.dart';


class AccountRouter implements IRouterProvider{

  static String accountPage = '/account';

  
  @override
  void initRouter(Router router) {
    router.define(accountPage, handler: Handler(handlerFunc: (_, params) => AccountPage()));
  }
  
}