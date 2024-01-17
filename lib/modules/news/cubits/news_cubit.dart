import 'package:bank_app_v3/modules/news/cubits/news_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/news_model.dart';
import '../repository/news_repo.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepo _newsRepo;
  NewsCubit(this._newsRepo) : super(InitNewsState());

  int page = 1;
  List<NewsModel> listNews = [];
  bool isFinish = false;

  Future<void> getListNews(int page, {bool? loadMore}) async {
    // if(loadMore ?? false) LoadMoreState(listNews);
    // if(loadMore ?? false) emit(LoadingNewsState());
    try {
      final response = await _newsRepo.getListNews(page);
      if(loadMore ?? false) {
        if(response.listNews!.isEmpty) {
          isFinish = true;
        }
        listNews.addAll(response.listNews ?? []);
        // loadingMore = false;
        emit(SuccessfulNewsState(listNews));
      } else {
        listNews = response.listNews ?? [];
        emit(SuccessfulNewsState(listNews));
      }
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
    if (state is SuccessfulNewsState) {
      /// Nếu như BE lỗi không xác định được isFinish thì không cho load nữa;
      // bool isFinish = (state as NotificationHasData).isFinish ?? true;

      if (!isFinish) {
      page++;
        await getListNews(page, loadMore: true);
      }
    }
  }
}
