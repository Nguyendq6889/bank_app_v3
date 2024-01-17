import '../models/news_model.dart';

abstract class NewsState {}

class InitNewsState extends NewsState {}

class LoadingNewsState extends NewsState {}

class ErrorNewsState extends NewsState {
  final String message;
  ErrorNewsState(this.message);
}

class SuccessfulNewsState extends NewsState {
  final List<NewsModel> listNews;
  final bool? isFinish;
  SuccessfulNewsState(this.listNews, {this.isFinish});
}