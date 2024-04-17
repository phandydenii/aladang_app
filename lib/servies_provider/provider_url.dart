class ProviderUrl {
  static const String basicUrlWebApi = "http://webapi1.aladangs.com/app/v1";
  static const String getImageUrlApi =
      "http://webapi1.aladangs.com/imagesUpload/";

  //Url Base For Testing
  // static const String basicUrlWebApi = "http://localhost:55131/app/v1";
  // static const String getImageUrlApi = "http://localhost:55131/imagesUpload/";

  static const String updloadSingleFileUrl = "/uploadfile/singlefile";
  static const String loginUserAppUrl = "/AppLoginUser";

  //=======================
  static String createShopUrl = "/shop/create";
  static String updateShopUrl = "/shop/update";
  static String getShopAllUrl = "/shop/all";
  static String getShopUrl = "/shop/all/page?page=";
  static String getShopByIdUrl = "/shop/id?id=";
  static String getOtherShopUrl = "/shop/othershop?id=";
  static String getResetPasswordShopUrl = "/shop/resetpassword";
  static String getChangePasswordShopUrl = "/shop/changepassword";
  static String changeLogoShopUrl = "/shop/change-logo-shop";
  static String changeQRShopUrl = "/shop/change-logo-qr";

  static String createDeliveryTypeUrl = "/deliverytype/create";
  static String updateDeliveryTypeUrl = "/deliverytype/update";
  static String getDeliveryTypeAllUrl = "/deliverytype/all";
  static String getDeliveryTypeByIdUrl = "/deliverytype/id?id=";
  static String getDeliveryTypeByPageUrl =
      "/deliverytype/status/page?status=1&page=1";

  static String getCurrencyAllUrl = "/currency/all";
  static String getCurrencyAllByPageUrl = "/currency/all/page?page=";
  static String getCurrencyByIdUrl = "/currency/id?id=";
  static String createCurrencyUrl = "/currency/create";
  static String updateCurrencyUrl = "/currency/update";

  static String getCustomerAllUrl = "/customer/all";
  static String getCustomerAllByPageUrl = "/customer/all/page?page=";
  static String getCustomerAllByIdUrl = "/customer/id?id=";
  static String getCustomerByIdUrl = "/customer/id?id=";
  static String createCustomerUrl = "/customer/create";
  static String updateCustomerUrl = "/customer/update";
  // ignore: non_constant_identifier_names
  static String CustomerCurrenPasswordUrl = "/customer/getCurrentPassword";
  // ignore: non_constant_identifier_names
  static String CustomerChangePasswordUrl = "/customer/changepassword";
  static String CustomerResetPasswordUrl = "/customer/resetpassword";
  // ignore: non_constant_identifier_names
  static String CustomerUpdatePhotoUrl = "/customer/updatePhoto";

  static String getOrderUrl = "/order/all?page=";
  static String createOrderUrl = "/order/create";
  static String updateOrderUrl = "/order/update";
  static String getOrderByStatusUrl = "/order/status/page?status=";
  static String getOrderByShopIdUrl = "/order/shopid/page?shopid=";
  static String getOrderByCustomerIdUrl = "/order/customerid/page?customerid=";
  static String getOrderByIdUrl = "/order/id?id=";

  static String getProductAllUrl = "/product/all";
  static String getProductUrl = "/product/all?page=";
  static String getProductByStatusUrl = "/product/status/page?status=";
  static String getProductByShopIdUrl = "/product/shopid/page/status?shopid=";
  static String getProductByIDUrl = "/product/id?id=";
  static String createProductUrl = "/product/create";
  static String updateProductUrl = "/product/update";

  static String getExchangeRateAllUrl = "/exchange/all";
  static String getExchangeRateByShopIdUrl = "/exchange/shopid?shopid=";
  static String getExchangeRateAllByPageUrl = "/exchange/all/page?page=";
  static String createExchangeRateUrl = "/exchange/create";
  static String updateExchangeRateUrl = "/exchange/update";

  static String getLocationAllUrl = "/location/all";
  static String getLocationAllByPageUrl = "/location/all?page=";
  static String createLocationUrl = "/location/create";
  static String updateLocationUrl = "/location/update";

  static String getPaymentMethodAllUrl = "/paymentmethod/all";
  static String getPaymentMethodAllByPageUrl = "/paymentmethod/all/page?page=";
  static String createPaymentMethodUrl = "/paymentmethod/create";
  static String updatePaymentMethodUrl = "/paymentmethod/update";

  static String getPrivacyAllUrl = "/privacy/all";
  static String getPrivacyAllByPageUrl = "/privacy/all/page?page=";
  static String createPrivacyUrl = "/privacy/create";
  static String updatePrivacyUrl = "/privacy/update";

  static String getProductImageAllUrl = "/productimage/all";
  static String getProductImageAllByPageUrl = "/productimage/all/page?page=";
  static String createProductImageUrl = "/productimage/create";
  static String updateProductImageUrl = "/productimage/update";

  static String getQrcodeAllUrl = "/qrcode/all";
  static String getQrcodeAllByPageUrl = "/qrcode/all/page?page=";
  static String createQrcodeUrl = "/qrcode/create";
  static String updateQrcodeUrl = "/qrcode/update";

  static String getSetupFeeAllUrl = "/setupfee/all";
  static String getSetupFeeByPageUrl = "/setupfee/all/page?page=";
  static String createSetupFeeUrl = "/setupfee/create";
  static String updateSetupFeeUrl = "/setupfee/update";

  static String getShopPaymentAllUrl = "/shoppayment/all";
  static String getShopPaymentByPageUrl = "/shoppayment/all/page?page=";
  static String createShopPaymentUrl = "/shoppayment/create";
  static String updateShopPaymentUrl = "/shoppayment/update";

  static String getOrderDetailAllUrl = "/orderdetail/all";
  static String getOrderDetailViewUrl =
      "/orderdetail/orderdetailview/orderid?orderid=";
  static String getOrderDetailByPageUrl = "/orderdetail/all/page?page=";
  static String getOrderDetailByOrderIdUrl = "/orderdetail/orderid?orderid=";
  static String createOrderDetailUrl = "/orderdetail/create";
  static String updateOrderDetailUrl = "/orderdetail/update";

  static String getBannerAllUrl = "/banner/all";
  static String getBannerByIdUrl = "/banner/id?id=";
  static String getBannerByPageUrl = "/banner/all/page?page=";
  static String getBannerByShopUrl = "/banner/shopid/page?shopid=1&page=1";
  static String createBannertUrl = "/banner/create";
  static String updateBannerUrl = "/banner/update";
}
