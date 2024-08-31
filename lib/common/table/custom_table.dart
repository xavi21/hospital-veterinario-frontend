import 'package:flutter/material.dart';
import 'package:paraiso_canino/common/button/custom_button.dart';
import 'package:paraiso_canino/common/input/custom_input_search.dart';
import 'package:paraiso_canino/resources/colors.dart';

class CustomTable extends StatelessWidget {
  final TextEditingController searchController;
  final List<String> headers;
  final List<Widget> rows;
  final Function()? onTapSearchButton;
  final Function()? onChangeSearchButton;
  final String pageTitle;

  const CustomTable({
    super.key,
    required this.searchController,
    required this.headers,
    required this.rows,
    required this.onTapSearchButton,
    this.onChangeSearchButton,
    required this.pageTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(
              15.0,
            ),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
            vertical: 25.0,
            horizontal: 80.0,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 22.0,
            horizontal: 25.0,
          ),
          child: Text(
            pageTitle,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(
                15.0,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 80.0,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 25.0,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomInputSearch(
                      controller: searchController,
                      onChanged: (String value) {
                        if (searchController.text.isEmpty) {
                          onChangeSearchButton!();
                        }
                      },
                      onPressed: () {
                        if (searchController.text.isNotEmpty) {
                          onTapSearchButton!();
                        }
                      },
                      hintTex: 'Buscar...',
                    ),
                    const Spacer(),
                    CustomButton(
                      onPressed: () {},
                      text: 'Agregar',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: headers
                      .map<Widget>(
                        (header) => Expanded(
                          child: Text(
                            header,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Expanded(
                  child: ListView(
                    children: rows,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
      ],
    );
  }
}
