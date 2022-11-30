import 'package:dimy_teknologi_quiz/dimy_teknologi_quiz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Coffee extends StatelessWidget {
  final bool isGridView;

  const Coffee({
    Key? key,
    required this.isGridView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CoffeeRepository repository = context.watch();

    if (repository.isFetching) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (isGridView) {
      return AlignedGridView.count(
        itemCount: repository.value.length,
        crossAxisCount: context.isDevicesDekstop ? 4 : 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          return CoffeeItem(
            isGridView: isGridView,
            coffee: repository.value[index],
            onTap: () {},
            onDelete: () async {},
          );
        },
      );

      // return GridView.count(
      //   crossAxisCount: 2,
      //   children: repository.value
      //       .map<Widget>(
      //         (e) => CoffeeItem(
      //           isGridView: isGridView,
      //           coffee: e,
      //           onTap: () {},
      //           onDelete: () async {},
      //         ),
      //       )
      //       .toList(),
      // );
    } else {
      return PhoneWidthWidget(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return CoffeeItem(
                    isGridView: isGridView,
                    coffee: repository.value[index],
                    onTap: () {},
                    onDelete: () async {},
                  );
                },
                childCount: repository.value.length,
              ),
            ),
          ],
        ),
      );
      // return ListView.builder(
      //   itemCount: repository.value.length,
      //   itemBuilder: (context, index) {
      //     return CoffeeItem(
      //       isGridView: isGridView,
      //       coffee: repository.value[index],
      //       onTap: () {},
      //       onDelete: () async {},
      //     );
      //   },
      // );
    }
  }
}
