import 'package:get/get.dart';
import '../models/product_model.dart';

class DetailsController extends GetxController {
  final detailsList = <Product>[
    Product(
      photos: [
        "assets/model/saiom1.png",
        "assets/model/saiom2.png",
        "assets/model/saiom3.png",

      ],

      name: "SAIOM",
      price: "1,199",
      id: "0",
      qty: 0,
      CategoryId: "Dresses",
      description: 'Cross String Work on Neck Solid Top',
    ),
    Product(
      photos: [
        "assets/model/punk1.png",
        "assets/model/punk2.png",
        "assets/model/punk3.png",

      ],
      name: "Oversized Punk Shirt",
      price: "449",
      id: "1",
      qty: 0,
      CategoryId: 'Dresses',
      description: 'soft, comfortable 100% cotton fabric',
    ),
    Product(
      photos:[

        "assets/model/toplot1.png",
        "assets/model/toplot2.png",
        "assets/model/toplot3.png",
      ],
      name: "Toplot T-Shirt",
      price: "329",
      id: "2",
      qty: 0,
      CategoryId: 'Dresses',
      description: 'Casual Printed with Short Sleeve (Mens-T-Shirt-5097)',
    ),
    Product(
      photos:[
        "assets/model/verido1.png",
        "assets/model/verido2.png",
        "assets/model/verido3.png",

      ],
      name: "Veirdo Oversized shirt",
      price: "529",
      id: "3",
      qty: 0,
      CategoryId: 'Dresses',
      description: 'Oversized Cotton Graphic Print Purple Crew Neck T-Shirt',
    ),
    Product(
      photos:[
        "assets/model/blackpanther1.png",
        "assets/model/blackpanther2.png",
        "assets/model/blackpanther3.png",

      ],
      name: "Black Panther",
      price: "1455",
      id: "4",
      qty: 0,
      CategoryId: 'Jackets',
      description: 'The Suit Cotton Men Hoodie ',
    ),
    Product(
      photos: [
        "assets/model/stranger1.png",
        "assets/model/stranger2.png",
        "assets/model/stranger3.png",
      ],
      name: "Stranger Things",
      price: "2499",
      id: "5",
      qty: 0,
      CategoryId: 'Jackets',
      description: '60% Cotton 40% Polyester',
    ),
    Product(
      photos: [
        "assets/model/gangsta1.png",
        "assets/model/gangsta2.png",
        "assets/model/gangsta3.png",
      ],
      name: "Gangsta Jacket",
      price: "2599",
      id: "6",
      qty: 0,
      CategoryId: 'Jackets',
      description: '100% Polyester',
    ),
    Product(
      photos: [
        "assets/model/batman1.png",
        "assets/model/batman2.png",
        "assets/model/batman3.png",

      ],
      name: "Batman",
      price: "2127",
      id: "7",
      qty: 0,
      CategoryId: 'Jackets',
      description: 'Classic Logo Black Printed Puffer Jackets',
    ),
    Product(
      photos: [
        "assets/model/jeangrey1.png",
        "assets/model/jeangrey2.png",
        "assets/model/jeangrey3.png",
      ],
      name: "Highlander Men Grey",
      price: "811",
      id: "8",
      qty: 0,
      CategoryId: 'Jeans',
      description: 'Men Tapered Fit Mid Rise Grey Jeans',
    ),
    Product(
      photos: [
        "assets/model/jeannavyblue1.png",
        "assets/model/jeannavyblue2.png",
        "assets/model/jeannavyblue3.png",

      ],
      name: "Highlander Navy Blue",
      price: "649",
      id: "9",
      qty: 0,
      CategoryId: 'Jeans',
      description: 'KETCH Men Jeans',
    ),
    Product(
      photos:[
        "assets/model/jeanlightgrey1.png",
        "assets/model/jeanlightgrey2.png",
        "assets/model/jeanlightgrey3.png",

      ],
      name: "Highlander Light Grey",
      price: "706",
      id: "10",
      qty: 0,
      CategoryId: 'Jeans',
      description: 'Men Grey Tapered Fit Mid-Rise Clean Look Stretchable Jeans',
    ),
    Product(
      photos: [
        "assets/model/jeandarkgrey1.png",
        "assets/model/jeandarkgrey2.png",
        "assets/model/jeandarkgrey3.png",

      ],
      name: "Highlander Men",
      price: "1680",
      id: "11",
      qty: 0,
      CategoryId: 'Jeans',
      description: 'Men Tapered Fit Mid Rise Dark Grey Jeans',
    ),
    Product(
      photos: [

        "assets/model/RedTapeBlue1.png",
        "assets/model/RedTapeBlue2.png",
        "assets/model/RedTapeBlue3.png",
      ],
      name: "RedTape Men Blue",
      price: "499",
      id: "12",
      qty: 0,
      CategoryId: 'Shoes',
      description: 'Enhanced Comfort with Cushioned Insole and Slip-Resistant',
    ),
    Product(
      photos: [
        "assets/model/RedTapewb1.png",
        "assets/model/RedTapewb2.png",
        "assets/model/RedTapewb3.png",

      ],
      name: "RedTape white black",
      price: "499",
      id: "13",
      qty: 0,
      CategoryId: 'Shoes',
      description:
          'Soft Cushioned Insole, Slip-Resistance, Dynamic Feet Support, Arch Support ',
    ),
    Product(
      photos: [
        "assets/model/RedtapeBeige1.png",
        "assets/model/RedtapeBeige2.png",
        "assets/model/RedtapeBeige3.png",
      ],
      name: "RedTape Beige",
      price: "1679",
      id: "14",
      qty: 0,
      CategoryId: 'Shoes',
      description: 'Elevated Comfort, Perfect Casual Shoes for Men',
    ),
    Product(
      photos: [
        "assets/model/Redtapewhite1.png",
        "assets/model/Redtapewhite2.png",
        "assets/model/Redtapewhite3.png",

      ],
      name: "RedTape White",
      price: "1449",
      id: "15",
      qty: 0,
      CategoryId: 'Shoes',
      description:
          'Elevated Comfort, Perfect Casual Shoes for Men ',
    ),
  ];
  // Get a list of products by id
  List<Product> getProductsById(String CategoryId) {
    return detailsList
        .where((product) => product.CategoryId == CategoryId)
        .toList();
  }

  final searchResults = <Product>[].obs;

  // Function to filter products based on search query
  void searchProducts(String query) {
    query = query.trim();
    searchResults.value = detailsList
        .where((product) =>
    product.name.trim().toLowerCase().contains(query) ||
        product.description.trim().toLowerCase().contains(query))
        .toList();
    if (searchResults.isNotEmpty) {
      addRecentSearch(searchResults[0]); // Add the first result to recent searches
    }
  }



  // Function to clear the search results
  void clearSearchResults() {
    searchResults.clear();
  }
  final recentSearches = <Product>[].obs;

  // Function to add a recently searched product
  void addRecentSearch(Product product) {
    if (!recentSearches.contains(product)) {
      recentSearches.insert(0, product);
    }
  }

  int parsePrice(String price) {
    return int.parse(price.replaceAll(',', ''));
  }

  // Function to filter products by price range
  List<Product> filterProductsByPriceRange(
      String CategoryId, double minPrice, double maxPrice) {
    return detailsList
        .where((product) =>
    product.CategoryId == CategoryId &&
        parsePrice(product.price) >= minPrice &&
        parsePrice(product.price) <= maxPrice)
        .toList();
  }
  List<Product> filteredProducts = [];
  void updateFilteredProducts(List<Product> products) {
    filteredProducts = products;
    update(); // Notify listeners
  }
}
