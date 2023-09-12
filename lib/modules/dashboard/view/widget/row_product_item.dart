import 'package:darshan_vachhani_flutter_yudiz/modules/core/utils/core_import.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/dashboard/bloc/cart_list/cart_list_bloc.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/dashboard/model/model_search_result_list.dart';
import 'package:readmore/readmore.dart';

class RowProduct extends StatelessWidget {
  final ProductData mSearchResult;

  const RowProduct({super.key, required this.mSearchResult});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimens.margin16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.margin15),
        color: Colors.tealAccent.shade100.withOpacity(0.3),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(Dimens.margin16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.margin15),
              color: Colors.teal.shade100,
            ),
            child: ImageViewerNetwork(
              url: mSearchResult.image ?? '',
              mHeight: Dimens.margin80,
              mWidth: Dimens.margin50,
            ),
          ),
          const SizedBox(width: Dimens.margin10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  mSearchResult.name ?? '',
                  style: const TextStyle(
                      fontSize: Dimens.textSize18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: Dimens.margin8),
                ReadMoreText(
                  mSearchResult.description ?? '',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: APPStrings.textReadMore,
                  trimExpandedText: APPStrings.textShowLess,
                  delimiter: '...',
                  moreStyle: const TextStyle(fontWeight: FontWeight.w500),
                  lessStyle: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: Dimens.margin8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        mSearchResult.price ?? '',
                        style: const TextStyle(
                            fontSize: Dimens.textSize16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    BlocBuilder<CartListBloc, CartListState>(
                      builder: (context, state) {
                        return Container(
                          height: Dimens.margin40,
                          width: Dimens.margin60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius:
                                  BorderRadius.circular(Dimens.margin20)),
                          child: IconButton(
                              onPressed: () {
                                if (!BlocProvider.of<CartListBloc>(context)
                                    .mCartList
                                    .contains(mSearchResult)) {
                                  BlocProvider.of<CartListBloc>(context)
                                      .add(AddToCart(product: mSearchResult));
                                } else {
                                  BlocProvider.of<CartListBloc>(context).add(
                                      RemoveFromCart(product: mSearchResult));
                                }
                              },
                              icon: Icon(
                                BlocProvider.of<CartListBloc>(context)
                                        .mCartList
                                        .contains(mSearchResult)
                                    ? Icons.check
                                    : Icons.add_shopping_cart_sharp,
                                size: 20,
                              )),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
