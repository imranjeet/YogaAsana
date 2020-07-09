import '../repository/repository.dart';

class YogaPostService {

  Repository _repository;

  YogaPostService() {
    _repository = Repository();
  }

  getAllYogaPost() async{
    return await _repository.httpGet('get-all-blog-posts');
  }
}