import '../models/category_models.dart';

abstract class CategoryRepository {
  Future<List<CategoryGroup>> listExpenseGroups();
  Future<List<CategoryGroup>> listIncomeGroups(); // 新增
  Future<List<CategoryGroup>> listTransferGroups(); // 新增：转账（账户选择分组）
}
