enum ProductState {
  verybad(name: 'Very Bad'),
  bad(name: 'Bad'),
  normal(name: 'Normal'),
  good(name: 'Good'),
  verygood(name: 'Very Good');

  const ProductState({required this.name});

  final String name;
}
