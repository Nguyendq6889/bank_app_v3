import 'package:bank_app_v3/modules/news/cubits/news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/news_model.dart';
import '../repository/news_repo.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepo _newsRepo;
  NewsCubit(this._newsRepo) : super(InitNewsState());

  List<NewsModel> _listNews = [];
  int _page = 1;
  bool _isLoading = false;
  bool finishLoadMore = false;
  bool hasErrorWhenLoadMore = false;

  Future<void> getListNews({int page = 1, bool? reFresh, bool? loadMore}) async {
    // emit(LoadingNewsState());
    try {
      final response = await _newsRepo.getListNews(page);
      if(loadMore ?? false) {
        if(response.listNews == null) {
          hasErrorWhenLoadMore = true;
        } else if(response.listNews != null && response.listNews!.isEmpty) {
          finishLoadMore = true;
        }
        _listNews.addAll(response.listNews ?? []);
        emit(SuccessfulNewsState(_listNews));
      } else {
        if(response.listNews != null) {
          // final listA = response.listNews!;
          // _listNews = response.listNews! + listA;
          _listNews = response.listNews!;
          await Future.delayed(const Duration(seconds: 1));
          emit(SuccessfulNewsState(_listNews));
        } else {
          emit(ErrorNewsState('Gọi API bị null'));
        }
      }
    } catch(error, stackTrace) {
      emit(ErrorNewsState(error.toString()));
      rethrow;      // it also prints out the error and stackTrace, help make debugging easier.
    }
  }

  Future<void> onLoadMore() async {
    if(_isLoading) return;
    if (!finishLoadMore && !hasErrorWhenLoadMore) {
      _isLoading = true;
      _page++;
      await getListNews(page: _page, loadMore: true);
      _isLoading = false;
    }
  }

  Future<void> onRefresh() async {
    _page = 1;
    _listNews = [];
    finishLoadMore = false;
    hasErrorWhenLoadMore = false;
    await getListNews(reFresh: true);
  }
}
