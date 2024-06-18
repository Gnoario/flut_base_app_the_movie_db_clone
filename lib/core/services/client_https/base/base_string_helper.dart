class BaseStringHelper {
  final String baseUrl;
  final String protocol;
  final Duration timeout;

  BaseStringHelper({
    this.baseUrl = "#",
    this.protocol = "https",
    this.timeout = const Duration(seconds: 10),
  });

  factory BaseStringHelper.get() {
    const baseUrl = "https://api.themoviedb.org/3";
    return BaseStringHelper(baseUrl: baseUrl);
  }

  String get fullUrl => "$protocol://$baseUrl";
}
