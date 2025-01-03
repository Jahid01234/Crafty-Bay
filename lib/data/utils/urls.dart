
class Urls{
  static const String _baseUrl = 'https://ecommerce-api.codesilicon.com/api';

  static const String sliderListUrl = '$_baseUrl/ListProductSlider';
  static const String categoryListUrl = '$_baseUrl/CategoryList';
  static const String readProfile = '$_baseUrl/ReadProfile';
  static const String addToCart = '$_baseUrl/CreateCartList';
  static const String fetchCarts = '$_baseUrl/CartList';
  static const String createProductReview = '$_baseUrl/CreateProductReview';
  static const String createInvoice = '$_baseUrl/InvoiceCreate';

  static const String fetchWishList = '$_baseUrl/ProductWishList';
  static String addToWishList(String productId) => '$_baseUrl/CreateWishList/$productId';
  static String deleteFromWishList(String productId) => '$_baseUrl/RemoveWishList/$productId';

  static String deleteCartList(int productId) => '$_baseUrl/DeleteCartList/$productId';
  static String productListByRemark(String remark) => '$_baseUrl/ListProductByRemark/$remark';
  static String productListByCategory(int categoryId) => '$_baseUrl/ListProductByCategory/$categoryId';
  static String productDetailsByID(int productId) => '$_baseUrl/ProductDetailsById/$productId';
  static String reviewByProduct(int productId) => '$_baseUrl/ListReviewByProduct/$productId';

  static String verifyEmail(String email) => '$_baseUrl/UserLogin/$email';
  static String verifyOtp(String email, String otp) => '$_baseUrl/VerifyLogin/$email/$otp';



}