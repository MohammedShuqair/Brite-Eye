import 'package:brite_eye/core/data/network/app_exception.dart';
import 'package:brite_eye/faetures/child/repo/child_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/shared/logic/single_request_provider.dart';
import '../../child/model/child_model.dart';

class ChildrenProvider extends SingleRequestProvider<List<Child>> {
  final ChildRepository childRepository;
  int? selectedChildId;

  ChildrenProvider({
    required this.childRepository,
  });

  @override
  Future<Either<AppException, List<Child>>> callRequest(caregiverId) {
    return childRepository.getChildren(caregiverId as int);
  }

  @override
  void handleSuccess(List<Child> serverResponse) {}
}
