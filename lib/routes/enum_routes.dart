
enum pages {
  login_page,
  signUp_page,
  home_page,
  upload_photo_page,
}

extension pagesExtension on pages {
  String routeName() {
    switch (this) {
      case pages.login_page:
        return '/loginPage';
      case pages.signUp_page:
        return '/signUpPage';
      case pages.home_page:
        return '/homePage';
      case pages.upload_photo_page:
        return '/uploadPhotoPage';
      default:
        return '/homePage';
    }
  }
}