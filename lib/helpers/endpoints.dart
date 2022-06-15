class Endpoints {
  static const String APP_NAME = 'Energy One Station';

  static const String BASE_URL = 'https://eone.solemn.tech/';
  // static const String BASE_URL = 'http://127.0.0.1:8000/';
  static const String CONFIG_URI = '/api/v1/config';
  static const String LOGIN_URI = 'api/auth/station/login';
  static const String FORGET_PASSWORD_URI =
      '/api/v1/auth/vendor/forgot-password';
  static const String VERIFY_TOKEN_URI = '/api/v1/auth/vendor/verify-token';
  static const String RESET_PASSWORD_URI = '/api/v1/auth/vendor/reset-password';
  static const String TOKEN_URI = '/api/v1/vendor/update-fcm-token';
  static const String ALL_ORDERS_URI = 'api/station/all-orders';
  static const String CURRENT_ORDERS_URI = 'api/station/current-orders';
  static const String COMPLETED_ORDERS_URI = 'api/station/completed-orders';
  static const String ORDER_DETAILS_URI = 'api/station/order-details';
  static const String UPDATE_ORDER_STATUS_URI =
      'api/station/update-order-status';
  static const String NOTIFICATION_URI = 'api/station/notifications';
  static const String PROFILE_URI = 'api/station/profile';
  static const String UPDATE_PROFILE_URI = '/api/v1/vendor/update-profile';
  static const String PRODUCT_LIST_URI = 'api/station/get-products-list';
  static const String STATION_UPDATE_URI =
      '/api/v1/vendor/update-business-setup';
  static const String ADD_PRODUCT_URI = '/api/v1/vendor/product/store';
  static const String UPDATE_PRODUCT_URI = '/api/v1/vendor/product/update';
  static const String DELETE_PRODUCT_URI = '/api/v1/vendor/product/delete';
  static const String STATION_REVIEW_URI = '/api/v1/STATIONs/reviews';
  static const String PRODUCT_REVIEW_URI = '/api/v1/products/reviews';
  static const String UPDATE_PRODUCT_STATUS_URI =
      '/api/v1/vendor/product/status';
  static const String UPDATE_STATION_STATUS_URI =
      'api/station/update-active-status';
  static const String SEARCH_PRODUCT_LIST_URI = '/api/v1/vendor/product/search';
  static const String PLACE_ORDER_URI = '/api/v1/vendor/pos/place-order';
  static const String POS_ORDERS_URI = '/api/v1/vendor/pos/orders';
  static const String SEARCH_CUSTOMERS_URI = '/api/v1/vendor/pos/customers';
  static const String DM_LIST_URI = '/api/v1/vendor/delivery-man/list';
  static const String ADD_DM_URI = '/api/v1/vendor/delivery-man/store';
  static const String UPDATE_DM_URI = '/api/v1/vendor/delivery-man/update/';
  static const String DELETE_DM_URI = '/api/v1/vendor/delivery-man/delete';
  static const String UPDATE_DM_STATUS_URI =
      '/api/v1/vendor/delivery-man/status';
  static const String DM_REVIEW_URI = '/api/v1/vendor/delivery-man/preview';

  // Shared Key
  static const String THEME = 'theme';
  static const String INTRO = 'intro';
  static const String TOKEN = 'multivendor_station_token';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_NUMBER = 'user_number';
  static const String NOTIFICATION = 'notification';
  static const String NOTIFICATION_COUNT = 'notification_count';
  static const String SEARCH_HISTORY = 'search_history';
  static const String TOPIC = 'all_zone_STATION';
  static const String ZONE_TOPIC = 'zone_topic';
}
