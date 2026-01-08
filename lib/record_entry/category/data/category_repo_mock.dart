import 'package:flutter/material.dart';
import '../models/category_models.dart';
import 'category_repository.dart';

class CategoryRepoMock implements CategoryRepository {
  @override
  Future<List<CategoryGroup>> listExpenseGroups() async {
    return const [
      CategoryGroup(
        id: 'food',
        name: '食品酒水',
        icon: Icons.fastfood_outlined,
        children: [
          CategoryItem(
            id: 'food_meal',
            name: '早午晚餐',
            icon: Icons.restaurant_outlined,
          ),
          CategoryItem(
            id: 'food_smoke',
            name: '烟酒茶',
            icon: Icons.wine_bar_outlined,
          ),
          CategoryItem(
            id: 'food_snack',
            name: '水果零食',
            icon: Icons.icecream_outlined,
          ),
        ],
      ),
      CategoryGroup(
        id: 'traffic',
        name: '行车交通',
        icon: Icons.directions_car_outlined,
        children: [
          CategoryItem(
            id: 'traffic_bus',
            name: '公共交通',
            icon: Icons.directions_bus_outlined,
          ),
          CategoryItem(
            id: 'traffic_taxi',
            name: '打车租车',
            icon: Icons.local_taxi_outlined,
          ),
          CategoryItem(
            id: 'traffic_private',
            name: '私家车费用',
            icon: Icons.commute_outlined,
          ),
        ],
      ),
      CategoryGroup(
        id: 'home',
        name: '居家物业',
        icon: Icons.home_outlined,
        children: [
          CategoryItem(
            id: 'home_daily',
            name: '日常用品',
            icon: Icons.inventory_2_outlined,
          ),
          CategoryItem(
            id: 'home_util',
            name: '水电煤气',
            icon: Icons.water_drop_outlined,
          ),
          CategoryItem(
            id: 'home_rent',
            name: '房租',
            icon: Icons.apartment_outlined,
          ),
          CategoryItem(
            id: 'home_prop',
            name: '物业管理',
            icon: Icons.business_outlined,
          ),
        ],
      ),
    ];
  }

  @override
  Future<List<CategoryGroup>> listIncomeGroups() async {
    return const [
      CategoryGroup(
        id: 'career',
        name: '职业收入',
        icon: Icons.work_outline,
        children: [
          CategoryItem(
            id: 'salary',
            name: '工资收入',
            icon: Icons.account_balance_wallet_outlined,
          ),
          CategoryItem(id: 'overtime', name: '加班收入', icon: Icons.more_time),
          CategoryItem(
            id: 'bonus',
            name: '奖金收入',
            icon: Icons.emoji_events_outlined,
          ),
          CategoryItem(id: 'parttime', name: '兼职收入', icon: Icons.paid_outlined),
          CategoryItem(
            id: 'biz',
            name: '经营所得',
            icon: Icons.storefront_outlined,
          ),
        ],
      ),
      CategoryGroup(
        id: 'other',
        name: '其他收入',
        icon: Icons.category_outlined,
        children: [
          CategoryItem(
            id: 'invest',
            name: '投资收入',
            icon: Icons.trending_up_outlined,
          ),
          CategoryItem(
            id: 'interest',
            name: '利息收入',
            icon: Icons.savings_outlined,
          ),
          CategoryItem(
            id: 'gift',
            name: '礼金收入',
            icon: Icons.card_giftcard_outlined,
          ),
          CategoryItem(
            id: 'lottery',
            name: '中奖收入',
            icon: Icons.celebration_outlined,
          ),
          CategoryItem(
            id: 'windfall',
            name: '意外来钱',
            icon: Icons.volunteer_activism_outlined,
          ),
        ],
      ),
    ];
  }
}
