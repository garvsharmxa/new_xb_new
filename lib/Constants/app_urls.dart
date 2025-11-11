/// app_urls.dart

class AppUrls {
  /// Base URL for local or production
  static const String baseUrl = 'https://dfd615f669e9.ngrok-free.app/api';

  // ──────────────────────────────────────────────
  // USER AUTH ENDPOINTS
  // ──────────────────────────────────────────────

  static const String sendRegisterOtp = '$baseUrl/auth/register/send-otp';
  static const String verifyRegistration = '$baseUrl/auth/register/verify';
  static const String sendLoginOtp = '$baseUrl/auth/login/send-otp';
  static const String resendLoginOtp = '$baseUrl/auth/login/resend-otp';
  static const String verifyLogin = '$baseUrl/auth/login/verify';
  static const String refreshToken = '$baseUrl/auth/refresh-token';
  static const String getUserProfile = '$baseUrl/auth/profile';
  static const String logout = '$baseUrl/auth/logout';
  static const String logoutAll = '$baseUrl/auth/logout-all';
  static const String checkOtpValidity = '$baseUrl/auth/check-otp-validity';
  static const String sendUpdateOtp = '$baseUrl/auth/send-update-otp';
  static const String updateWithOtp = '$baseUrl/auth/update-with-otp';

  // ──────────────────────────────────────────────
  // ADMIN ENDPOINTS
  // ──────────────────────────────────────────────

  static const String createFirstAdmin = '$baseUrl/auth/admin/create-first';
  static const String adminLogin = '$baseUrl/auth/admin/login';
  static const String getAllUsers = '$baseUrl/auth/admin/users';
  static String updateUserRole(String userId) =>
      '$baseUrl/auth/admin/update-role/$userId';
  static const String getAdminProfile = '$baseUrl/auth/profile';
  static const String adminLogout = '$baseUrl/auth/logout';
  static const String adminLogoutAll = '$baseUrl/auth/logout-all';

  // ──────────────────────────────────────────────
  // FOOD ENDPOINTS
  // ──────────────────────────────────────────────

  static const String getAllFoods = '$baseUrl/foods';
  static const String addFood = '$baseUrl/foods/add';
  static const String getTrendingFoods = '$baseUrl/foods/trending';
  static String getFoodsByShop(String shopId) => '$baseUrl/foods/shop/$shopId';
  static String getFoodById(String id) => '$baseUrl/foods/$id';
  static String updateFood(String id) => '$baseUrl/foods/update/$id';
  static String toggleFoodStock(String id) => '$baseUrl/foods/toggle-stock/$id';
  static String incrementOrderCount(String id) => '$baseUrl/foods/increment-order/$id';
  static String deleteFood(String id) => '$baseUrl/foods/delete/$id';
  static const String getFoodCuisines = '$baseUrl/foods/meta/cuisines';
  static const String getFoodCategories = '$baseUrl/foods/meta/categories';
  static const String getFoodStats = '$baseUrl/foods/stats/overview';

  // ──────────────────────────────────────────────
  // SHOP ENDPOINTS
  // ──────────────────────────────────────────────

  static const String getAllShops = '$baseUrl/shops';
  static const String createShop = '$baseUrl/shops/create';
  static const String getMyShops = '$baseUrl/shops/my/shops';
  static String getShopById(String id) => '$baseUrl/shops/$id';
  static String updateShop(String id) => '$baseUrl/shops/$id';
  static String deleteShop(String id) => '$baseUrl/shops/$id';
  static String updateShopStatus(String id) => '$baseUrl/shops/$id/status';
  static String updateShopSchedule(String id) => '$baseUrl/shops/$id/schedule';
  static String getShopAnalytics(String id) => '$baseUrl/shops/$id/analytics';
  static String verifyShop(String id) => '$baseUrl/shops/$id/verify';
  static String toggleFeaturedShop(String id) => '$baseUrl/shops/$id/featured';

  // Location-based shop endpoints
  static const String getLocationHierarchy = '$baseUrl/shops/locations/hierarchy';
  static const String getStates = '$baseUrl/shops/locations/states';
  static String getCitiesByState(String state) => '$baseUrl/shops/locations/cities/$state';
  static String getAreasByStateCity(String state, String city) =>
      '$baseUrl/shops/locations/areas/$state/$city';
  static String getShopsByLocation(String state, String city, String area) =>
      '$baseUrl/shops/location/$state/$city/$area';
  static String getTrendingShops(String state, String city) =>
      '$baseUrl/shops/trending/$state/$city';
  static String getShopsByCity(String state, String city) =>
      '$baseUrl/shops/city/$state/$city';
  static String getShopRecommendations(String userId) =>
      '$baseUrl/shops/recommendations/$userId';
  static const String searchShops = '$baseUrl/shops/search';

  // Admin shop endpoints
  static const String fixEmptyArrays = '$baseUrl/shops/admin/fix-empty-arrays';
  static const String debugAllShops = '$baseUrl/shops/debug/all';

  // ──────────────────────────────────────────────
  // CART ENDPOINTS
  // ──────────────────────────────────────────────

  static const String getCart = '$baseUrl/cart';
  static const String addToCart = '$baseUrl/cart/add';
  static String updateCartItem(String itemIndex) => '$baseUrl/cart/update/$itemIndex';
  static String removeFromCart(String itemIndex) => '$baseUrl/cart/remove/$itemIndex';
  static const String clearCart = '$baseUrl/cart/clear';
  static const String getCartSummary = '$baseUrl/cart/summary';
  static const String checkout = '$baseUrl/cart/checkout';
  static const String getCartCount = '$baseUrl/cart/count';

  // ──────────────────────────────────────────────
  // HELPER METHODS FOR DYNAMIC URLS
  // ──────────────────────────────────────────────

  /// Build URL with query parameters
  static String buildUrlWithParams(String endpoint, Map<String, dynamic> params) {
    if (params.isEmpty) return endpoint;

    final uri = Uri.parse(endpoint);
    final newUri = uri.replace(queryParameters: {
      ...uri.queryParameters,
      ...params.map((key, value) => MapEntry(key, value.toString())),
    });
    return newUri.toString();
  }

  /// Get foods with filters
  static String getFoodsWithFilters({
    int? page,
    int? limit,
    int? menuCategory,
    String? cuisine,
    double? minPrice,
    double? maxPrice,
    String? search,
    String? sortBy,
    String? sortOrder,
    bool? instock,
    int? shopid,
    bool? veg,
    bool? beverage,
    int? minOrderNum,
  }) {
    final params = <String, dynamic>{};
    if (page != null) params['page'] = page;
    if (limit != null) params['limit'] = limit;
    if (menuCategory != null) params['menu_category'] = menuCategory;
    if (cuisine != null) params['cuisine'] = cuisine;
    if (minPrice != null) params['minPrice'] = minPrice;
    if (maxPrice != null) params['maxPrice'] = maxPrice;
    if (search != null) params['search'] = search;
    if (sortBy != null) params['sortBy'] = sortBy;
    if (sortOrder != null) params['sortOrder'] = sortOrder;
    if (instock != null) params['instock'] = instock;
    if (shopid != null) params['shopid'] = shopid;
    if (veg != null) params['veg'] = veg;
    if (beverage != null) params['beverage'] = beverage;
    if (minOrderNum != null) params['minOrderNum'] = minOrderNum;

    return buildUrlWithParams(getAllFoods, params);
  }

  /// Get shops with filters
  static String getShopsWithFilters({
    int? page,
    int? limit,
    String? state,
    String? city,
    String? area,
    String? pincode,
    String? cuisine,
    String? menuCategory,
    double? rating,
    String? search,
    String? sortBy,
    String? sortOrder,
    bool? featured,
    bool? isOpen,
    bool? takeawayAvailable,
    bool? preOrderAvailable,
    bool? fastService,
    String? tags,
  }) {
    final params = <String, dynamic>{};
    if (page != null) params['page'] = page;
    if (limit != null) params['limit'] = limit;
    if (state != null) params['state'] = state;
    if (city != null) params['city'] = city;
    if (area != null) params['area'] = area;
    if (pincode != null) params['pincode'] = pincode;
    if (cuisine != null) params['cuisine'] = cuisine;
    if (menuCategory != null) params['menuCategory'] = menuCategory;
    if (rating != null) params['rating'] = rating;
    if (search != null) params['search'] = search;
    if (sortBy != null) params['sortBy'] = sortBy;
    if (sortOrder != null) params['sortOrder'] = sortOrder;
    if (featured != null) params['featured'] = featured;
    if (isOpen != null) params['isOpen'] = isOpen;
    if (takeawayAvailable != null) params['takeawayAvailable'] = takeawayAvailable;
    if (preOrderAvailable != null) params['preOrderAvailable'] = preOrderAvailable;
    if (fastService != null) params['fastService'] = fastService;
    if (tags != null) params['tags'] = tags;

    return buildUrlWithParams(getAllShops, params);
  }

  /// Get trending foods with filters
  static String getTrendingFoodsWithFilters({
    int? limit,
    int? shopid,
  }) {
    final params = <String, dynamic>{};
    if (limit != null) params['limit'] = limit;
    if (shopid != null) params['shopid'] = shopid;

    return buildUrlWithParams(getTrendingFoods, params);
  }

  /// Get foods by shop with filters
  static String getFoodsByShopWithFilters(String shopId, {
    int? limit,
    bool? instock,
    bool? veg,
    bool? beverage,
    int? menuCategory,
  }) {
    final params = <String, dynamic>{};
    if (limit != null) params['limit'] = limit;
    if (instock != null) params['instock'] = instock;
    if (veg != null) params['veg'] = veg;
    if (beverage != null) params['beverage'] = beverage;
    if (menuCategory != null) params['menu_category'] = menuCategory;

    return buildUrlWithParams(getFoodsByShop(shopId), params);
  }

  /// Get users with pagination and search
  static String getUsersWithFilters({
    int? page,
    int? limit,
    String? search,
  }) {
    final params = <String, dynamic>{};
    if (page != null) params['page'] = page;
    if (limit != null) params['limit'] = limit;
    if (search != null) params['search'] = search;

    return buildUrlWithParams(getAllUsers, params);
  }

  /// Get shop analytics with period
  static String getShopAnalyticsWithPeriod(String id, {String? period}) {
    final params = <String, dynamic>{};
    if (period != null) params['period'] = period;

    return buildUrlWithParams(getShopAnalytics(id), params);
  }
}
