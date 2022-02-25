import 'dart:convert';

class CoinModell {
  CoinModell coinModelFromJson(String str) => CoinModell.fromJson(json.decode(str));

String coinModelToJson(CoinModell data) => json.encode(data.toJson());
    CoinModell({
        required this.id,
        required this.icon,
        required this.name,
        required this.symbol,
        required this.rank,
        required this.price,
        required this.volume,
        required this.marketCap,
        required this.totalSupply,
        required this.priceChange1H,
        required this.priceChange1D,
        required this.priceChange1W,
        required this.priceBtc,
        required this.websiteUrl,
        required this.twitterUrl,
        required this.availableSupply,
        required this.contractAddress,
        required this.exp,
    });
    String id;
    String icon;
    String name;
    String symbol;
    String websiteUrl;
    String twitterUrl;
    String contractAddress;
    int rank;
    double price;
    double priceBtc;
    double volume;
    double marketCap;
    double availableSupply;
    double totalSupply;
    double priceChange1H;
    double priceChange1D;
    double priceChange1W;
     List<String>? exp;
    
    factory CoinModell.fromJson(Map<String, dynamic> json) => CoinModell( //Buradaki verileri json'dan CoinModel sınıfına dönüştür.
        id: json["id"] == null ? null : json["id"],
        icon: json["icon"] == null ? null : json["icon"],
        name: json["name"] == null ? null : json["name"],
        symbol: json["symbol"] == null ? null : json["symbol"],
        websiteUrl: json["websiteUrl"] == null ? null : json["websiteUrl"],
        twitterUrl: json["twitterUrl"] == null ? null : json["twitterUrl"],
        contractAddress: json["contractAddress"] == null ? null : json["contractAddress"],
        rank: json["rank"] == null ? null : json["rank"],
        priceBtc: json["priceBtc"] == null ? null : json["priceBtc"].toDouble(),
        price: json["price"] == null ? null : json["price"].toDouble(),
        volume: json["volume"] == null ? null : json["volume"].toDouble(),
        availableSupply: json["availableSupply"] == null ? null : json["availableSupply"].toDouble(),
        marketCap: json["marketCap"] == null ? null : json["marketCap"].toDouble(),
        totalSupply: json["totalSupply"] == null ? null : json["totalSupply"].toDouble(),
        priceChange1H: json["priceChange1h"] == null ? null : json["priceChange1h"].toDouble(),
        priceChange1D: json["priceChange1d"] == null ? null : json["priceChange1d"].toDouble(),
        priceChange1W: json["priceChange1w"] == null ? null : json["priceChange1w"].toDouble(),
         exp: json["exp"] == null ? null : List<String>.from(json["exp"].map((x) => x)),

    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "icon": icon == null ? null : icon,
        "name": name == null ? null : name,
        "symbol": symbol == null ? null : symbol,
        "websiteUrl": websiteUrl == null ? null : websiteUrl,
        "twitterUrl": twitterUrl == null ? null : twitterUrl,
        "contractAddress": contractAddress == null ? null : contractAddress,
        "rank": rank == null ? null : rank,
        "price": price == null ? null : price,
        "priceBtc": priceBtc == null ? null : priceBtc,
        "volume": volume == null ? null : volume,
        "marketCap": marketCap == null ? null : marketCap,
        "totalSupply": totalSupply == null ? null : totalSupply,
         "availableSupply": availableSupply == null ? null : availableSupply,
        "priceChange1h": priceChange1H == null ? null : priceChange1H,
        "priceChange1d": priceChange1D == null ? null : priceChange1D,
        "priceChange1w": priceChange1W == null ? null : priceChange1W,
        "exp": exp == null ? null : List<dynamic>.from(exp!.map((x) => x)),
    };
}
