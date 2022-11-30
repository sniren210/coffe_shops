import 'package:dimy_teknologi_quiz/dimy_teknologi_quiz.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CoffeeItem extends StatefulWidget {
  final CoffeHotModel coffee;
  final GestureTapCallback onTap;
  final VoidCallback onDelete;
  final bool isGridView;

  const CoffeeItem({
    Key? key,
    required this.coffee,
    required this.onTap,
    required this.onDelete,
    required this.isGridView,
  }) : super(key: key);

  @override
  State<CoffeeItem> createState() => _CoffeeItemState();
}

class _CoffeeItemState extends State<CoffeeItem> {
  String firstHalf = '';
  String secondHalf = '';

  bool flag = true;
  bool isMore = true;

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_onScroll);

    if (widget.coffee.description.length > 100) {
      firstHalf = widget.coffee.description.substring(0, 100);
      secondHalf = widget.coffee.description
          .substring(100, widget.coffee.description.length);
      isMore = true;
    } else {
      firstHalf = widget.coffee.description;
      secondHalf = '';
      isMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isGridView) {
      return Card(
        elevation: 4.0,
        child: InkWell(
          onTap: () => widget.onTap(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1.0,
                          child: Image.network(
                            widget.coffee.image ?? kEmptyImageLink,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                kEmptyImageLink,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          right: 8.0,
                          child: Row(
                            children: [
                              for (int i = 0;
                                  i < widget.coffee.ingredients.length;
                                  i++)
                                if (i < 2)
                                  Container(
                                    padding: const EdgeInsets.all(2.0),
                                    color: i % 2 == 0
                                        ? const Color(0xFFBF25EB)
                                        : const Color(0xFFFFB700),
                                    child: Text(
                                      widget.coffee.ingredients[i],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.coffee.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(height: 4),
                          Text.rich(
                            TextSpan(
                              text: flag
                                  ? ('$firstHalf...')
                                  : (firstHalf + secondHalf),
                              children: <InlineSpan>[
                                if (isMore)
                                  TextSpan(
                                    text: flag ? '  Show more' : ' Show less',
                                    style: const TextStyle(color: Colors.grey),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        setState(() {
                                          flag = !flag;
                                        });
                                      },
                                  )
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: Image.network(
                      widget.coffee.image ?? kEmptyImageLink,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          kEmptyImageLink,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 8.0,
                    child: Row(
                      children: [
                        for (int i = 0;
                            i < widget.coffee.ingredients.length;
                            i++)
                          if (i < 2)
                            Container(
                              padding: const EdgeInsets.all(2.0),
                              color: i % 2 == 0
                                  ? const Color(0xFFBF25EB)
                                  : const Color(0xFFFFB700),
                              child: Text(
                                widget.coffee.ingredients[i],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.coffee.title,
                  style: context.theme.textTheme.bodyText1,
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(
                  TextSpan(
                    text: flag ? ('$firstHalf...') : (firstHalf + secondHalf),
                    children: <InlineSpan>[
                      if (isMore)
                        TextSpan(
                          text: flag ? '  Show more' : ' Show less',
                          style: const TextStyle(color: Colors.grey),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                flag = !flag;
                              });
                            },
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
