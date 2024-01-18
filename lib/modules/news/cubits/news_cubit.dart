import 'package:bank_app_v3/modules/news/cubits/news_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/news_model.dart';
import '../repository/news_repo.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepo _newsRepo;
  NewsCubit(this._newsRepo) : super(InitNewsState());

  int _page = 1;
  List<NewsModel> _listNews = [];
  bool isLoading = false;
  bool finishLoadMore = false;
  bool hasErrorWhenLoadMore = false;

  Future<void> getListNews(int page, {bool? loadMore}) async {
    isLoading = true;
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
          _listNews = response.listNews!;
          emit(SuccessfulNewsState(_listNews));
        } else {
          emit(ErrorNewsState('Gọi API bị null'));
        }
      }
      isLoading = false;
    } catch(error, stackTrace) {
      // if (kDebugMode) {
      //   print(error);
      //   print(stackTrace);
      // }
      emit(ErrorNewsState(error.toString()));
      rethrow;      // it also prints out the error and stackTrace, help make debugging easier.
    }
  }

  Future<void> onLoadMore() async {
    // if(isLoading) return;
    if (!finishLoadMore && !hasErrorWhenLoadMore) {
      _page++;
      await getListNews(_page, loadMore: true);
      // isLoading = false;
    }
  }
}
