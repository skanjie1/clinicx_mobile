// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const dOrangeColor = Color(0xffff9800);
const dBlueColor = Color(0xff2292ff);
const dDarkBlue = Color(0xff19427d);

const dAccentBlueColor = Color(0xff4E8FFF);
const dGreyColor = Color(0xffE5E5E5);
const dPrimaryTextColor = Color(0xff000000);

const dBorderRadius = 8.0;

final kBorder = const Color(0xFF1A1A1A).withOpacity(0.1);
const kDark = Color(0xffcfd1d3);

OutlineInputBorder outlineBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: BorderSide(
    color: const Color(0xFF1A1A1A).withOpacity(0.1),
    width: 1,
  ),
);
UnderlineInputBorder inputBorder = const UnderlineInputBorder(
  borderSide: BorderSide(
    color: kDark,
    width: 1,
  ),
);

OutlineInputBorder focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: const BorderSide(
    color: kDark,
    width: 1,
  ),
);

OutlineInputBorder errorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: const BorderSide(
    color: Colors.red,
    width: 1,
  ),
);

//Transparent border
OutlineInputBorder transparentBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: const BorderSide(
    color: Colors.transparent,
    width: 1,
  ),
);

showErrorSnackBar(BuildContext context, String message) {
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}

const Color backgroundColor2 = Color(0xFF17203A);
const Color backgroundColorLight = Color(0xFFF2F6FF);
const Color backgroundColorDark = Color(0xFF25254B);
const Color shadowColorLight = Color(0xFF4A5367);
const Color shadowColorDark = Colors.black;

const NATS_URL = "nats://nats.dev.dadanadagroup.com:10010";

const IDENTITY_SERVICE_URL = "https://identity-service.dev.da-ride.com/";
const LOCATION_URL = "https://location-service.dev.da-ride.com/";
const PAYMENT_URL = "https://payment-service.dev.da-ride.com/api/";
const COUPON_URL = "https://coupons-service.dev.da-ride.com/v1/";
const FEEDBACK_URL = "https://feedback-service.dev.da-ride.com/api/";
const TRIP_URL = "https://trip-service.dev.da-ride.com/api/";

const GEOCODE_URL = "https://maps.googleapis.com/maps/api/geocode/json?latlng=";
const GEOCODE_KEY = "AIzaSyCTaAbuFC4IZLkdfYqtg3_kziZefWHjiw8";

const DIRECTIONS_URL = "https://maps.googleapis.com/maps/api/directions/json?";
const DIRECTIONS_KEY = "AIzaSyCTaAbuFC4IZLkdfYqtg3_kziZefWHjiw8";

const PLACES_URL =
    "https://maps.googleapis.com/maps/api/place/autocomplete/json?";

const PLACES_DETAILS_URL =
    "https://maps.googleapis.com/maps/api/place/details/json?";
const PLACES_KEY = "AIzaSyCTaAbuFC4IZLkdfYqtg3_kziZefWHjiw8";

const SELECTED_PAYMENT_METHOD = "selectedPaymentMethod";
const SELECTED_WALLET = "selectedWallet";

const GOOGLE_API_KEY = "AIzaSyCTaAbuFC4IZLkdfYqtg3_kziZefWHjiw8";

//NATS
const RIDE_TYPE = "payment_request_type";
const FLEXI_REQUEST = "FLEXI_PAY_REQUEST";
const FLEXI_BIDS = "rider_flexi_request_bids";
const ACCEPT_FLEXI_BID = "accept_flexi_bid_request";

//Conts

const TRIP_ID = "tripId";
const HAS_RATED = "hasRated";



//  {"action":"accept_flexi_bid_status_rider","topic":"trip_status.user.90","description":"getting your ride ready","bid_status":"ACCEPTED","expiry_time":"2024/01/22 13:56:29 WAT","ride_id":17059281527590490}