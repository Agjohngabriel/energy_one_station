import 'package:energyone_station/helpers/apptheme.dart';
import 'package:energyone_station/views/stations/widget/product_view.dart';
import 'package:energyone_station/views/stations/widget/review_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/station_controller.dart';
import '../../helpers/date_converter.dart';
import '../../helpers/dimension.dart';
import '../../helpers/price_converter.dart';
import '../../helpers/routes.dart';
import '../../model/response/profile_model.dart';
import '../../widget/snackbar.dart';
import '../menu/widget/image.dart';
import '../products/new_product.dart';

class StationScreen extends StatefulWidget {
  @override
  State<StationScreen> createState() => _StationScreenState();
}

class _StationScreenState extends State<StationScreen>
    with TickerProviderStateMixin {
  StationController stationController = Get.put(StationController());
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  final bool? _review =
      Get.find<AuthController>().profileModel!.station!.reviewsSection!;

  @override
  void initState() {
    super.initState();
    //
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    Get.find<StationController>().getProductList('1');
    Get.find<StationController>()
        .getStationReviewList(Get.find<AuthController>().profileModel?.id);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StationController>(builder: (restController) {
      return GetBuilder<AuthController>(builder: (authController) {
        Station _station = authController.profileModel!.station!;

        return Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // if (Get.find<AuthController>().profileModel!.productSection) {
              //   if (_station != null) {
              Get.toNamed(RouteHelper.getProductRoute(0),
                  arguments: AddProductScreen());
              //   }
              // } else {
              //   showCustomSnackBar('This feature is blocked by admin');
              // }
            },
            backgroundColor: AppTheme.blue,
            child: Icon(Icons.add_circle_outline,
                color: Theme.of(context).cardColor, size: 30),
          ),
          body: _station != null
              ? CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 230,
                      toolbarHeight: 50,
                      pinned: true,
                      floating: false,
                      backgroundColor: AppTheme.blue,
                      leading: IconButton(
                        icon: const Icon(Icons.chevron_left,
                            color: AppTheme.blue),
                        onPressed: () => Get.back(),
                      ),
                      actions: [
                        IconButton(
                          icon: Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: AppTheme.blue,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_SMALL)),
                            child: Image.asset("assets/edit.png"),
                          ),
                          onPressed: () => Get.toNamed(
                              RouteHelper.getStationSettingsRoute(_station)),
                        )
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: CustomImage(
                          fit: BoxFit.cover,
                          placeholder: 'assets/toni.png',
                          image: '${_station.coverPhoto}',
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Center(
                            child: Container(
                      width: 1170,
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      color: Theme.of(context).cardColor,
                      child: Column(children: [
                        Row(children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(Dimensions.RADIUS_SMALL),
                            child: CustomImage(
                              image: '/${_station.logo}',
                              height: 40,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(
                                  '${_station.name}',
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimensions.FONT_SIZE_LARGE),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  _station.address ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w400,
                                      fontSize: Dimensions.FONT_SIZE_SMALL,
                                      color: Theme.of(context).disabledColor),
                                ),
                              ])),
                        ]),
                        const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        _station.availableTimeStarts != null
                            ? Row(children: [
                                Text('Daily Time',
                                    style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          Dimensions.FONT_SIZE_EXTRA_SMALL,
                                      color: Theme.of(context).disabledColor,
                                    )),
                                const SizedBox(
                                    width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Text(
                                  '${DateConverter.convertTimeToTime('${_station.availableTimeStarts}')}'
                                  ' - ${DateConverter.convertTimeToTime('${_station.availableTimeEnds}')}',
                                  style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          Dimensions.FONT_SIZE_EXTRA_SMALL,
                                      color: AppTheme.blue),
                                ),
                              ])
                            : const SizedBox(),
                        const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Row(children: [
                          const Icon(Icons.star,
                              color: AppTheme.blue, size: 18),
                          Text(
                            _station.avgRating!.toStringAsFixed(1),
                            style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w400,
                                fontSize: Dimensions.FONT_SIZE_SMALL),
                          ),
                          const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                          Text(
                            '${_station.ratingCount} ${'Ratings'}',
                            style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w400,
                                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                color: Theme.of(context).disabledColor),
                          ),
                        ]),
                        const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      ]),
                    ))),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverDelegate(
                          child: Center(
                              child: Container(
                        width: 1170,
                        decoration:
                            BoxDecoration(color: Theme.of(context).cardColor),
                        child: TabBar(
                            controller: _tabController,
                            indicatorColor: AppTheme.blue,
                            indicatorWeight: 3,
                            labelColor: AppTheme.blue,
                            unselectedLabelColor:
                                Theme.of(context).disabledColor,
                            unselectedLabelStyle: GoogleFonts.mulish(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).disabledColor,
                                fontSize: Dimensions.FONT_SIZE_SMALL),
                            labelStyle: GoogleFonts.mulish(
                                fontWeight: FontWeight.w700,
                                fontSize: Dimensions.FONT_SIZE_SMALL,
                                color: AppTheme.blue),
                            tabs: const [
                              Tab(text: 'All Product'),
                              Tab(text: 'Reviews'),
                            ]),
                      ))),
                    ),
                    SliverToBoxAdapter(
                        child: AnimatedBuilder(
                      animation: _tabController,
                      builder: (context, child) {
                        if (_tabController.index == 0) {
                          return ProductView(
                              scrollController: _scrollController);
                        } else {
                          return restController.stationReviewList != null
                              ? restController.stationReviewList!.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: restController
                                          .stationReviewList?.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_SMALL),
                                      itemBuilder: (context, index) {
                                        return ReviewWidget(
                                          review: restController
                                              .stationReviewList![index],
                                          hasDivider: index !=
                                              restController.stationReviewList!
                                                      .length -
                                                  1,
                                        );
                                      },
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: Dimensions.PADDING_SIZE_LARGE),
                                      child: Center(
                                          child: Text('no_review_found',
                                              style: GoogleFonts.mulish(
                                                  fontWeight: FontWeight.w400,
                                                  color: Theme.of(context)
                                                      .disabledColor))),
                                    )
                              : const Padding(
                                  padding: EdgeInsets.only(
                                      top: Dimensions.PADDING_SIZE_LARGE),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: AppTheme.blue,
                                  )),
                                );
                        }
                      },
                    )),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(
                  color: AppTheme.blue,
                )),
        );
      });
    });
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}
