import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final ProductFilter selectedFilter;
  final ValueChanged<ProductFilter> onFilterChanged;

  const FilterBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
          ),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ProductFilter>(
          value: selectedFilter,
          isExpanded: true,
          dropdownColor: Colors.white,
          items: ProductFilter.values.map((filter) {
            return DropdownMenuItem(
              value: filter,
              child: Text(filter.label),
            );
          }).toList(),
          onChanged: (filter) {
            if (filter != null) {
              onFilterChanged(filter);
            }
          },
        ),
      ),
    );
  }
}

enum ProductFilter {
  all,
  lowToHigh,
  highToLow;

  String get label {
    switch (this) {
      case ProductFilter.all:
        return 'All';
      case ProductFilter.lowToHigh:
        return 'Price: Low to High';
      case ProductFilter.highToLow:
        return 'Price: High to Low';
    }
  }
}