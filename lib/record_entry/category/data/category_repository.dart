import '../models/category_models.dart';

abstract class CategoryRepository {
  Future<List<CategoryGroup>> listExpenseGroups();
  Future<List<CategoryGroup>> listIncomeGroups(); // 新增
}
