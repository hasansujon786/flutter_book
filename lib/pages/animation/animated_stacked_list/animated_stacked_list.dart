import 'package:flutter/material.dart';

import 'data.dart';
import 'widgets.dart';

const _itemHeightReducer = 0.7;
const _itemHeight = 160.0;

const _listTopPadding = 20.0;

class AnimatedStackedList extends StatefulWidget {
  const AnimatedStackedList({super.key});

  static const routeName = '/animated_stacked_list';

  @override
  State<AnimatedStackedList> createState() => _AnimatedStackedListState();
}

class _AnimatedStackedListState extends State<AnimatedStackedList> {
  final _itemList = <FoodData>[];

  var _showCategoryList = true;
  var _topContainer = 0.0;
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    FOOD_DATA.forEach(createItem);

    _scrollController.addListener(_handleScrollChange);
  }

  void _handleScrollChange() {
    double value = _scrollController.offset / (_itemHeight * _itemHeightReducer);

    setState(() {
      _topContainer = value;
      _showCategoryList = _scrollController.offset < 10;
    });

    // final value = _scrollController.offset / _itemHeight;
    // setState(() {
    //   _topContainer = value;
    // });

    // if (_scrollController.offset < 50 && !_showCategoryList) {
    //   setState(() {
    //     _showCategoryList = true;
    //   });
    // }
    // if (_scrollController.offset > 50 && _showCategoryList) {
    //   setState(() {
    //     _showCategoryList = false;
    //   });
    // }
  }

  void createItem(dynamic e) {
    _itemList.add(FoodData(e['name'], e['price'], e['brand'], e['image']));
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(_showCategoryList ? 'show' : 'hidden'),
      ),
      body: Column(
        children: [
          const SizedBox(height: _listTopPadding),
          categorList(),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 6),
            child: Row(
              children: [
                Text('My Coupons', style: tt.subtitle1?.copyWith(color: Colors.grey.shade600)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 60, top: 5),
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: _itemList.length,
              itemBuilder: (BuildContext context, int index) {
                final item = _itemList[index];
                var scale = 1.0;
                if (_topContainer > 0 && !_showCategoryList) {
                  scale = index + 0.99 - _topContainer;
                  if (scale < 0) {
                    scale = 0;
                  } else if (scale > 1) {
                    scale = 1;
                  }
                }
                return Opacity(
                  opacity: scale,
                  child: Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()..scale(scale, scale),
                    child: Align(
                      alignment: Alignment.topCenter,
                      heightFactor: _itemHeightReducer,
                      child: SizedBox(
                        height: _itemHeight,
                        child: FoodListItem(item: item),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget categorList() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
      opacity: _showCategoryList ? 1 : 0,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 200),
        height: _showCategoryList ? 200 : 0,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 28, bottom: _listTopPadding),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: const [
                  Category('Most Favorite', 12, color: Colors.amber),
                  Category('Most Favorite', 12),
                  Category('Most Favorite', 12, color: Colors.cyan),
                ],
              ),
            ),
            Positioned(
              left: 12,
              child: Text(
                'Discovery',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScrollChange);
    super.dispose();
  }
}
