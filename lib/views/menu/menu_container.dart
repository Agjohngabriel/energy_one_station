import 'package:energyone_station/views/menu/widget/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helpers/dimension.dart';
import '../../helpers/routes.dart';
import '../../model/response/menu_model.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<MenuModel> _menuList = [
      MenuModel(
        icon: 'assets/support.png',
        title: 'Station'.tr,
        backgroundColor: Color(0xFFFF8A80),
        route: RouteHelper.getStationRoute(),
        isBlocked: false,
      ),
      MenuModel(
          icon: 'assets/user.png',
          title: 'Profile',
          backgroundColor: const Color(0xFF4389FF),
          route: RouteHelper.getProfileRoute()),
      MenuModel(
        icon: 'assets/edit.png',
        title: 'Add Product'.tr,
        backgroundColor: const Color(0xFFFF8A80),
        route: RouteHelper.getProductRoute(0),
        isBlocked: false,
      ),
      MenuModel(
        icon: 'assets/support.png',
        title: 'Support'.tr,
        backgroundColor: const Color(0xFFFF8A80),
        route: RouteHelper.getSupportRoute(),
        isBlocked: false,
      ),
      MenuModel(
          icon: 'assets/log_out.png',
          title: 'logout'.tr,
          backgroundColor: Color(0xFFFF4B55),
          route: RouteHelper.getProductRoute(0)),
    ];

    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
        color: Theme.of(context).cardColor,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.keyboard_arrow_down_rounded, size: 30),
        ),
        const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: (1 / 1.2),
            crossAxisSpacing: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            mainAxisSpacing: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          ),
          itemCount: _menuList.length,
          itemBuilder: (context, index) {
            return MenuButton(
                menu: _menuList[index],
                isProfile: index == 0,
                isLogout: index == _menuList.length - 1);
          },
        ),
        const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
      ]),
    );
  }
}
