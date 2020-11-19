import 'package:flutter/cupertino.dart';

const banner_url = 'banner/json';
const top_article_url = 'article/top/json';
const tree_url = 'tree/json';
const project_tree_url = 'project/tree/json';
const navi_url = 'navi/json';
const hotkey_url = 'hotkey/json';
const login_url = 'user/login';
const register_url = 'user/register';
const logout_url = 'user/logout/json';
const test_login_url = 'lg/todo/listnotdo/0/json/1';
const coin_count_url = 'lg/coin/getcount/json';

String articles_urls(int pageNum) => 'article/list/$pageNum/json';

String weixin_url(int pageNum, int id) => 'wxarticle/list/$id/$pageNum/json';

String search_result_url({int pageNum = 0}) => 'article/query/$pageNum/json';

String collect_list_url(int pageNum) => 'lg/collect/list/$pageNum/json';

String do_collect_url(int id) => 'lg/collect/$id/json';

String uncollect_url(int id) => 'lg/uncollect_originId/$id/json';

String my_coin_record(int pageNum) => 'lg/coin/list/$pageNum/json';

String ranking_list(int pageNum) => 'coin/rank/$pageNum/json';
