import 'package:dimy_teknologi_quiz/dimy_teknologi_quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderCoffeeList extends StatelessWidget {
  final bool isGridView;
  final ValueChanged<bool>? onChanged;
  final int? length;

  const HeaderCoffeeList({
    Key? key,
    this.isGridView = true,
    this.onChanged,
    this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${context.l10n.kCoffee} ${length ?? ''}'),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isGridView
                          ? context.isDarkTheme
                              ? Theme.of(context).primaryColor
                              : Colors.black
                          : null,
                    ),
                    child: IconButton(
                      iconSize: 18.0,
                      icon: const Icon(CupertinoIcons.square_grid_3x2_fill),
                      color: isGridView
                          ? Colors.white
                          : context.isDarkTheme
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => onChanged!(true),
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: !isGridView
                          ? context.isDarkTheme
                              ? Theme.of(context).primaryColor
                              : Colors.black
                          : null,
                    ),
                    child: IconButton(
                      iconSize: 18.0,
                      icon: const Icon(CupertinoIcons.rectangle_grid_1x2_fill),
                      color: !isGridView
                          ? Colors.white
                          : context.isDarkTheme
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => onChanged!(false),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
