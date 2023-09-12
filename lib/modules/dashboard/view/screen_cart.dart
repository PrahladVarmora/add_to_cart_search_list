import 'package:darshan_vachhani_flutter_yudiz/modules/core/utils/core_import.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/dashboard/bloc/cart_list/cart_list_bloc.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/dashboard/view/widget/row_product_item.dart';

class ScreenCart extends StatefulWidget {
  const ScreenCart({super.key});

  @override
  State<ScreenCart> createState() => _ScreenCartState();
}

class _ScreenCartState extends State<ScreenCart> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartListBloc, CartListState>(
      builder: (context, state) {
        return SafeArea(
          top: false,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(APPStrings.textCart),
            ),
            body: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.margin16),
              itemCount:
                  BlocProvider.of<CartListBloc>(context).mCartList.length,
              itemBuilder: (context, index) {
                return RowProduct(
                    mSearchResult: BlocProvider.of<CartListBloc>(context)
                        .mCartList[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: Dimens.margin10);
              },
            ),
            bottomNavigationBar: BlocProvider.of<CartListBloc>(context)
                    .mCartList
                    .isEmpty
                ? null
                : Container(
                    padding: const EdgeInsets.all(Dimens.margin16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "\$${(BlocProvider.of<CartListBloc>(context).mCartList.map((e) => double.parse((e.price ?? '0').replaceAll('\$', ''))).reduce((value, element) => value + element)).toString()}",
                            style: const TextStyle(fontSize: Dimens.textSize20),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<CartListBloc>(context)
                                  .add(const ClearCart());
                            },
                            child: const Text(
                              APPStrings.textBuy,
                              style: TextStyle(fontSize: Dimens.textSize20),
                            ))
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
