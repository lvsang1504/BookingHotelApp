import 'package:bloc/bloc.dart';
import 'package:book_hotel/module/home/home_bloc.dart';
import 'package:book_hotel/module/home/ui/room_by_category.dart';
import 'package:book_hotel/shared_code/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatefulWidget {
  final List<CategoryModel> categories;
  final HomeBloc bloc;
  const CategoryList({Key? key, required this.categories, required this.bloc})
      : super(key: key);
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    with SingleTickerProviderStateMixin {
  late final List<CategoryModel> categories;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    categories = widget.categories;
    _tabController = TabController(vsync: this, length: categories.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 1.0,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              isScrollable: true,
              tabs: categories.map((CategoryModel categoryModel) {
                return Container(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 10.0),
                    child: Text(
                      categoryModel.name!,
                      style: const TextStyle(
                          color: Colors.black38,
                          fontFamily: "Gotik",
                          fontWeight: FontWeight.w800,
                          fontSize: 14.0)),
                    );
              }).toList(),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          
          children: categories.map((CategoryModel categoryModel) {
            return CategoryRooms(
              categoryId: categoryModel.id.toString(),
              homeBloc: widget.bloc,
            );
          }).toList(),
        ),
      ),
    );
  }
}
