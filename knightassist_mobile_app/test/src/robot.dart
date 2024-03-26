class Robot {
  Robot(this.tester)
      : auth = AuthRobot(tester),
        products = ProductsRobot(tester),
        cart = CartRobot(tester),
        checkout = CheckoutRobot(tester),
        orders = OrdersRobot(tester),
        reviews = ReviewsRobot(tester),
        golden = GoldenRobot(tester);
}
