import 'package:products_catalog/app/models/product.dart';

import 'fake_factory.dart';

class ProductFakeFactory extends FakeFactory<Product> {
  @override
  Product make() {
    return Product(
      id: faker.datatype.number(),
      title: faker.commerce.productName(),
      description: faker.commerce.productDescription(),
      category: faker.commerce.department(),
      price: faker.datatype.float(),
      image: faker.image.image(),
      rateAverage: faker.datatype.float(),
      rateCount: faker.datatype.number(),
    );
  }
}
