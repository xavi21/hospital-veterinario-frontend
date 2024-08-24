import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paraiso_canino/resources/colors.dart';
import 'package:paraiso_canino/resources/constants.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // TODO cambiar por constante global
      color: const Color(0xFFF7F7F7),
      child: Row(
        children: [
          SideMenu(
            title: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 60,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.asset('${imagePath}logo.jpg'),
              ),
            ),
            items: <SideMenuItem>[
              SideMenuItem(
                title: 'Sucursales',
                iconWidget: SvgPicture.asset(
                  '${iconPath}tracking_blue.svg',
                ),
                onTap: (index, sideMenuController) =>
                    _handleSideMenuPages(index),
              ),
              SideMenuItem(
                title: 'Usuarios',
                iconWidget: SvgPicture.asset(
                  '${iconPath}users_blue.svg',
                ),
                onTap: (index, sideMenuController) =>
                    _handleSideMenuPages(index),
              ),
              SideMenuItem(
                title: 'Empleados',
                iconWidget: SvgPicture.asset(
                  '${iconPath}travel_expenses_blue.svg',
                ),
                onTap: (index, sideMenuController) =>
                    _handleSideMenuPages(index),
              ),
            ],
            controller: sideMenu,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.compact,
              compactSideMenuWidth: 85.0,
              selectedColor: blueSemiLight,
              backgroundColor: blue,
              showTooltip: true,
              itemHeight: 75.0,
              itemInnerSpacing: 0.0,
            ),
            footer: Image.asset('${imagePath}login.png'),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: ['Sucursales', 'Usuarios', 'Empleados']
                  .map(
                    (vista) => Center(
                      child: Text(
                        vista,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  _handleSideMenuPages(int index) => sideMenu.changePage(index);
}
