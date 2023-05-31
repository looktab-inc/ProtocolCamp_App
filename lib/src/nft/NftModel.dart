class NftModel {
  final List<String> image;
  final String nftAddress;
  final String storeName;
  final String description;
  final String address;
  final String shopId;
  final String time;
  final int visited;

  NftModel(
      {required this.image,
      required this.nftAddress,
      required this.storeName,
      required this.description,
      required this.address,
      required this.shopId,
      required this.visited,
      required this.time});
}
