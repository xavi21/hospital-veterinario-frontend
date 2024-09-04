import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/appbar/custom_appbar.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/common/dialog/custom_state_dialog.dart';
import 'package:paraiso_canino/common/loader/loader.dart';
import 'package:paraiso_canino/home/bloc/home_bloc.dart';
import 'package:paraiso_canino/home/model/submenu_list.dart';
import 'package:paraiso_canino/login/model/login_response.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:paraiso_canino/resources/constants.dart';
import 'package:paraiso_canino/routes/routes.dart';
import 'package:paraiso_canino/sucursal/sucursal_page.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final PageController pageController = PageController();
  final SideMenuController sideMenu = SideMenuController();

  late List<SideMenuExpansionItem> menu;
  late List<SubMenuListModel> submenu;

  late LoginResponse profileData;
  late String _userName;

  @override
  void initState() {
    menu = [];
    submenu = [];
    _userName = emptyString;
    _getNavigationMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, BaseState>(
      listener: (context, state) {
        if (state is HomeGetMenuSuccess) {
          setState(() {
            _userName = state.userEmail;
            submenu = state.subMenu;
            menu = state.menu.map<SideMenuExpansionItem>((menuItem) {
              return SideMenuExpansionItem(
                title: menuItem.name,
                children: submenu
                    .where((option) => option.idmenu == menuItem.idmenu)
                    .map<SideMenuItem>(
                      (element) => SideMenuItem(
                        title: element.opcionNombre,
                        icon: const Icon(Icons.pets),
                        onTap: (index, _) => _handleSideMenuPages(index),
                      ),
                    )
                    .toList(),
              );
            }).toList();
          });
          sideMenu.addListener((index) {
            pageController.jumpToPage(index);
          });
        }
        if (state is HomeServiceError) {
          CustomStateDialog.showAlertDialog(
            context,
            title: 'Menu',
            description: state.message,
            isWarning: true,
          );
        }
        if (state is ServerClientError) {
          CustomStateDialog.showAlertDialog(
            context,
            title: 'Error',
            description: 'En este momento no podemos atender tu solicitud.',
            isError: true,
          );
        }
      },
      child: BlocBuilder<HomeBloc, BaseState>(
        builder: (context, state) {
          if (state is HomeinProgress) {
            return const Loader();
          }
          if (state is HomeGetMenuSuccess) {
            return Container(
              color: fillInputSelect,
              child: Row(
                children: [
                  SideMenu(
                    title: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 60,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset('${imagePath}logo.jpg'),
                      ),
                    ),
                    items: menu,
                    controller: sideMenu,
                    style: SideMenuStyle(
                      showTooltip: true,
                      openSideMenuWidth: 200,
                      compactSideMenuWidth: 40.0,
                      hoverColor: blueSemiLight,
                      selectedColor: blueShade,
                      backgroundColor: blue,
                      displayMode: SideMenuDisplayMode.open,
                      iconSize: 20,
                      itemHeight: 40.0,
                      itemInnerSpacing: 8.0,
                      itemBorderRadius: BorderRadius.circular(
                        15.0,
                      ),
                      selectedTitleTextStyle: const TextStyle(
                        color: black,
                        fontSize: 14.0,
                      ),
                      unselectedTitleTextStyle: const TextStyle(
                        color: white,
                        fontSize: 14.0,
                      ),
                      arrowOpen: white,
                      arrowCollapse: white,
                      iconSizeExpandable: 24.0,
                      selectedIconColor: black,
                      unselectedIconColor: white,
                      selectedTitleTextStyleExpandable: const TextStyle(
                        color: white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedTitleTextStyleExpandable: const TextStyle(
                        color: blueShade,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    footer: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Chip(
                        label: Text(
                          'Versión 1.0.0',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      children: submenu.map<Widget>((page) {
                        return routes[page.opcionNombre.trim()] ??
                            Center(
                              child: Text(
                                page.opcionNombre,
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  void _handleSideMenuPages(int index) => sideMenu.changePage(index);

  void _getNavigationMenu() {
    context.read<HomeBloc>().add(
          HomeMenuShown(),
        );
  }
}
