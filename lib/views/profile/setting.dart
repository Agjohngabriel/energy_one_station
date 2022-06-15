import 'dart:io';

import 'package:energyone_station/views/profile/widget/off_day.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/station_controller.dart';
import '../../helpers/apptheme.dart';
import '../../helpers/dimension.dart';
import '../../model/response/profile_model.dart';
import '../../widget/custom_button.dart';
import '../../widget/snackbar.dart';
import '../../widget/switch_button.dart';
import '../../widget/time_picker.dart';
import '../products/widget/text_field.dart';

class StationSettingsScreen extends StatefulWidget {
  final Station station;
  StationSettingsScreen({required this.station});

  @override
  State<StationSettingsScreen> createState() => _StationSettingsScreenState();
}

class _StationSettingsScreenState extends State<StationSettingsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _orderAmountController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _contactNode = FocusNode();
  final FocusNode _addressNode = FocusNode();
  final FocusNode _orderAmountNode = FocusNode();
  Station? _station;

  @override
  void initState() {
    super.initState();

    Get.find<StationController>()
        .initStationData('${widget.station.offDay}', widget.station.gstStatus!);

    _nameController.text = widget.station.name!;
    _contactController.text = widget.station.phone!;
    _addressController.text = widget.station.address!;
    _orderAmountController.text = widget.station.minimumOrder.toString();
    _gstController.text = widget.station.gstCode!;
    _station = widget.station;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.blue,
        automaticallyImplyLeading: true,
        title: Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Station Setting",
            textAlign: TextAlign.center,
            style: GoogleFonts.mulish(
              color: AppTheme.notWhite,
              fontSize: 17,
              fontStyle: FontStyle.normal,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: GetBuilder<StationController>(builder: (stationController) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            Text(
              'Logo',
              style: GoogleFonts.mulish(
                  fontWeight: FontWeight.w400,
                  fontSize: Dimensions.FONT_SIZE_SMALL,
                  color: Theme.of(context).disabledColor),
            ),
            const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Align(
                alignment: Alignment.center,
                child: Stack(children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    child: stationController.pickedLogo != null
                        ? GetPlatform.isWeb
                            ? Image.network(
                                stationController.pickedLogo!.path,
                                width: 150,
                                height: 120,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(stationController.pickedLogo!.path),
                                width: 150,
                                height: 120,
                                fit: BoxFit.cover,
                              )
                        : FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.jpg',
                            image: '/${widget.station.logo}',
                            height: 120,
                            width: 150,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (c, o, s) => Image.asset(
                                'assets/placeholder.jpg',
                                height: 120,
                                width: 150,
                                fit: BoxFit.cover),
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    top: 0,
                    left: 0,
                    child: InkWell(
                      onTap: () => stationController.pickImage(true, false),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          border: Border.all(
                              width: 1, color: Theme.of(context).primaryColor),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white),
                            shape: BoxShape.circle,
                          ),
                          child:
                              const Icon(Icons.camera_alt, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ])),
            const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            MyTextField(
              hintText: 'Station name',
              controller: _nameController,
              focusNode: _nameNode,
              nextFocus: _contactNode,
              capitalization: TextCapitalization.words,
              inputType: TextInputType.name,
            ),
            const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            MyTextField(
              hintText: 'Contact number',
              controller: _contactController,
              focusNode: _contactNode,
              nextFocus: _addressNode,
              inputType: TextInputType.phone,
            ),
            const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            MyTextField(
              hintText: 'Address',
              controller: _addressController,
              focusNode: _addressNode,
              nextFocus: _orderAmountNode,
              inputType: TextInputType.streetAddress,
            ),
            const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            Row(children: [
              Expanded(
                  child: MyTextField(
                hintText: 'minimum_order_amount',
                controller: _orderAmountController,
                focusNode: _orderAmountNode,
                nextFocus: null,
                inputAction: TextInputAction.done,
                inputType: TextInputType.number,
                isAmount: true,
              )),
              const SizedBox(),
            ]),
            const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            Row(children: [
              Expanded(
                  child: Text(
                'gst',
                style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w400,
                    fontSize: Dimensions.FONT_SIZE_SMALL,
                    color: Theme.of(context).disabledColor),
              )),
              Switch(
                value: stationController.isGstEnabled,
                activeColor: Theme.of(context).primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (bool isActive) => stationController.toggleGst(),
              ),
            ]),
            MyTextField(
              hintText: 'gst',
              controller: _gstController,
              inputAction: TextInputAction.done,
              title: false,
              isEnabled: stationController.isGstEnabled,
            ),
            const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'weekly_off_day',
                  style: GoogleFonts.mulish(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.FONT_SIZE_SMALL,
                      color: Theme.of(context).disabledColor),
                )),
            Row(children: [
              OffDayCheckBox(weekDay: 1, stationController: stationController),
              OffDayCheckBox(weekDay: 2, stationController: stationController),
            ]),
            Row(children: [
              OffDayCheckBox(weekDay: 3, stationController: stationController),
              OffDayCheckBox(weekDay: 4, stationController: stationController),
            ]),
            Row(children: [
              OffDayCheckBox(weekDay: 5, stationController: stationController),
              OffDayCheckBox(weekDay: 6, stationController: stationController),
            ]),
            Row(children: [
              OffDayCheckBox(weekDay: 7, stationController: stationController),
            ]),
            const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            Row(children: [
              Expanded(
                  child: CustomTimePicker(
                title: 'open_time',
                time: '${_station?.availableTimeStarts}',
                onTimeChanged: (time) => _station?.availableTimeStarts = time,
              )),
              const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Expanded(
                  child: CustomTimePicker(
                title: 'close_time',
                time: '${_station?.availableTimeEnds}',
                onTimeChanged: (time) => _station?.availableTimeEnds = time,
              )),
            ]),
            const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                child: stationController.pickedCover != null
                    ? GetPlatform.isWeb
                        ? Image.network(
                            stationController.pickedCover.path,
                            width: context.width,
                            height: 170,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(stationController.pickedCover.path),
                            width: context.width,
                            height: 170,
                            fit: BoxFit.cover,
                          )
                    : FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.jpg',
                        image: '/${widget.station.coverPhoto}',
                        height: 170,
                        width: context.width,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (c, o, s) => Image.asset(
                            'assets/placeholder.jpg',
                            height: 170,
                            width: context.width,
                            fit: BoxFit.cover),
                      ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                top: 0,
                left: 0,
                child: InkWell(
                  onTap: () => stationController.pickImage(false, false),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      border: Border.all(
                          width: 1, color: Theme.of(context).primaryColor),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        border: Border.all(width: 3, color: Colors.white),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt,
                          color: Colors.white, size: 50),
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 30),
            !stationController.isLoading
                ? CustomButton(
                    onPressed: () {
                      String _name = _nameController.text.trim();
                      String _contact = _contactController.text.trim();
                      String _address = _addressController.text.trim();
                      String _minimumOrder = _orderAmountController.text.trim();
                      String _gstCode = _gstController.text.trim();
                      if (_name.isEmpty) {
                        showCustomSnackBar('enter_your_station_name');
                      } else if (_contact.isEmpty) {
                        showCustomSnackBar('enter_station_contact_number');
                      } else if (_address.isEmpty) {
                        showCustomSnackBar('enter_station_address');
                      } else if (_minimumOrder.isEmpty) {
                        showCustomSnackBar('enter_minimum_order_amount');
                      } else if (stationController.isGstEnabled &&
                          _gstCode.isEmpty) {
                        showCustomSnackBar('enter_gst_code');
                      } else {
                        _station?.name = _name;
                        _station?.phone = _contact;
                        _station?.address = _address;
                        _station?.minimumOrder = double.parse(_minimumOrder);
                        _station?.gstStatus = stationController.isGstEnabled;
                        _station?.gstCode = _gstCode;
                        _station?.offDay = stationController.weekendString;
                        // stationController.updateStation(_station,
                        //     Get.find<AuthController>().getUserToken());
                      }
                    },
                    buttonText: 'Update',
                  )
                : const Center(
                    child: CircularProgressIndicator(
                    color: AppTheme.blue,
                  )),
          ]),
        );
      }),
    );
  }
}
