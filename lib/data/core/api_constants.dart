class APIConstants {
  APIConstants._();

  static const String PROD_BASE_URL = '';
  static const String DEV_BASE_URL = 'http://ec2-13-245-209-129.af-south-1.compute.amazonaws.com:3000';

  static const String REGISTER_SEGMENT = 'signup';
  static const String LOGIN_SEGMENT = 'login';
  static const String VERIFY_EMAIL_SEGMENT = 'verify-confirmation-code';
  static const String RESEND_CONFIRMATION_CODE_SEGMENT = 'resend-confirmation-code';
  static const String FORGOT_PASSWORD_SEGMENT = 'forgot-password';
  static const String VERIFY_PASSWORD_RESET_CODE_SEGMENT = 'verify-password-code';
  static const String RESET_PASSWORD_SEGMENT = 'reset-password';

  static const String COUNTRIES_SEGMENT = 'countries';
  static const String STATES_SEGMENT = 'states';
  static const String SCHOOLS_BY_COUNTRY_SEGMENT = 'schools';

  static const String LIFE_UPDATE_SEGMENT = 'life-update';
  static const String UPDATE_BVN_BIO = 'update-bvn-bio';
  static const String UPDATE_ADDRESS = 'update-address';
  static const String UPLOAD_PROFILE_IMAGE = 'profile-image';
  static const String UTILITY_BILL_SEGMENT = 'utility-bill';
  static const String FETCH_INTERESTS = 'fetch-interests';
  static const String UPDATE_INTERESTS = 'update-interests';

}