import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Cart/CartScreen.dart';
import '../../../Controller/CartController.dart';
import '../../../models/foodItems.dart';
import '../../HomeScreen/Widgets/RestaurantListScreen.dart';
import '../widget/FoodCard.dart';

class ShopScreen extends StatefulWidget {
  final RestaurantData? restaurant;
  const ShopScreen({super.key, required this.restaurant});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late TabController _tabController;
  final cartController = Get.find<CartController>();
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _categoryKeys = {};

  // Category management
  int selectedCategoryIndex = 0;
  bool showCategoryMenu = false;

  final List<String> categories = [
    'All',
    "Recommended",
    'Italian',
    'Indian',
    'Chinese',
    'Beverages',
  ];

  final List<int> categoryItemCounts = [
    8, // All items count
    4, // Recommended items count
    2, // Italian items count
    2, // Indian items count
    2, // Chinese items count
    2, // Beverages items count
  ];

  List<FoodItem> foodList = [
    // Italian
    FoodItem(
      imageUrl:
          'https://s.lightorangebean.com/media/20240914160809/Spicy-Penne-Pasta_-done.png',
      name: 'Pasta',
      category: 'Italian',
      price: 399,
      Recommended: false,
    ),
    FoodItem(
      imageUrl:
          'https://assets.tmecosys.cn/image/upload/t_web767x639/img/recipe/ras/Assets/48a49653c8716457eb0b2f7eb3c7d74c/Derivates/8d83d9ed4567fa15456d8eec7557e60006a15576.jpg',
      name: 'Pizza',
      category: 'Italian',
      price: 429,
      Recommended: true,
    ),

    // Indian
    FoodItem(
      imageUrl:
          'https://s.lightorangebean.com/media/20240914160809/Spicy-Penne-Pasta_-done.png',
      name: 'Chole Bhature',
      category: 'Indian',
      price: 229,
      Recommended: true,
    ),
    FoodItem(
      imageUrl:
          'https://s.lightorangebean.com/media/20240914160809/Spicy-Penne-Pasta_-done.png',
      name: 'Rajma Chawal',
      category: 'Indian',
      price: 199,
      Recommended: false,
    ),

    // Chinese
    FoodItem(
      imageUrl:
          'https://s.lightorangebean.com/media/20240914160809/Spicy-Penne-Pasta_-done.png',
      name: 'Hakka Noodles',
      category: 'Chinese',
      price: 249,
      Recommended: true,
    ),
    FoodItem(
      imageUrl:
          'https://s.lightorangebean.com/media/20240914160809/Spicy-Penne-Pasta_-done.png',
      name: 'Manchurian',
      category: 'Chinese',
      price: 259,
      Recommended: false,
    ),

    // Beverages
    FoodItem(
      imageUrl:
          'https://s.lightorangebean.com/media/20240914160809/Spicy-Penne-Pasta_-done.png',
      name: 'Masala Chai',
      category: 'Beverages',
      price: 49,
      Recommended: false,
    ),
    FoodItem(
      imageUrl:
          'https://s.lightorangebean.com/media/20240914160809/Spicy-Penne-Pasta_-done.png',
      name: 'Cold Coffee',
      category: 'Beverages',
      price: 99,
      Recommended: true,
    ),
  ];

  List<FoodItem> _getFilteredItems(String category) {
    if (category == 'All') {
      return foodList;
    } else if (category == 'Recommended') {
      return foodList.where((item) => item.Recommended == true).toList();
    } else {
      return foodList.where((item) => item.category == category).toList();
    }
  }

  Widget _buildCategorySection(String category) {
    _categoryKeys.putIfAbsent(category, () => GlobalKey());

    // Get filtered items for this category
    List<FoodItem> itemsToShow = _getFilteredItems(category);

    if (itemsToShow.isEmpty) return const SizedBox();

    return Container(
      key: _categoryKeys[category],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10),
            child: Text(
              category,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...itemsToShow.asMap().entries.map((entry) {
            int index = entry.key;
            FoodItem item = entry.value;
            return FoodCard(
              key: ValueKey(
                '${category}_${item.name}_$index',
              ), // Unique key for each card
              foodItem: item,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildFoodList() {
    String selectedCategory = categories[selectedCategoryIndex];

    // If "All" is selected, show all categories as separate sections
    if (selectedCategory == 'All') {
      return ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          for (var category in categories.skip(1)) // Skip "All" category
            _buildCategorySection(category),
        ],
      );
    } else {
      // For specific categories, show only that category
      return ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [_buildCategorySection(selectedCategory)],
      );
    }
  }

  void _scrollToCategory(int index) {
    // Only scroll if "All" is selected and index > 0
    if (categories[index] == 'All' || index == 0) {
      // Scroll to top for "All" category
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else if (selectedCategoryIndex == 0) {
      // If coming from "All" category
      final categoryName = categories[index];
      final key = _categoryKeys[categoryName];
      if (key != null && key.currentContext != null) {
        // Add a small delay to ensure the widget is built
        Future.delayed(const Duration(milliseconds: 100), () {
          Scrollable.ensureVisible(
            key.currentContext!,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
          );
        });
      }
    } else {
      // For specific categories, scroll to top of the food list
      _scrollController.animateTo(
        400, // Approximate position after the header sections
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onScroll() {
    // Only update category selection when "All" is selected
    if (categories[selectedCategoryIndex] != 'All') return;

    for (int i = 1; i < categories.length; i++) {
      // Skip "All" category
      final key = _categoryKeys[categories[i]];
      if (key != null) {
        final context = key.currentContext;
        if (context != null) {
          final box = context.findRenderObject() as RenderBox?;
          if (box != null) {
            final offset = box.localToGlobal(Offset.zero, ancestor: null).dy;

            // Adjust the threshold for better detection
            if (offset < 250 && offset > -100) {
              if (selectedCategoryIndex != i) {
                setState(() {
                  selectedCategoryIndex = i;
                  _tabController.animateTo(i);
                });
              }
              break;
            }
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _tabController = TabController(length: categories.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          selectedCategoryIndex = _tabController.index;
        });
        // Scroll to category when tab changes
        _scrollToCategory(_tabController.index);
      }
    });
    _animationController.forward();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 25,
                  color: Color(0xffC2262D),
                ),
              ),
            ),
            title: Text(
              widget.restaurant?.name ?? "Domino's Pizza",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: -0.3,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 10),
                child: IconButton(
                  onPressed: () {
                    Get.to(() => CartScreen());
                  },
                  icon: const Icon(
                    FontAwesomeIcons.cartShopping,
                    size: 23,
                    color: Color(0xffC2262D),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 10),

                // Shop Image and Details Card
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: Image.network(
                            widget.restaurant?.imageUrl ??
                                'https://inkbotdesign.com/wp-content/uploads/2012/09/Dominos-Logo-Design.png.webp',
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 180,
                                width: double.infinity,
                                color: Colors.grey.shade200,
                                child: const Icon(
                                  Icons.restaurant,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.restaurant?.name ?? 'Domino\'s Pizza',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.restaurant?.rating != null
                                        ? '${widget.restaurant!.rating} (${widget.restaurant!.reviewCount ?? 500} Reviews)'
                                        : '4.5 (500 Reviews)',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      widget.restaurant?.address ??
                                          'Sector 17, Chandigarh',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Quick Stats Section
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildStatItem(
                            icon: Icons.access_time_rounded,
                            title: "Delivery",
                            subtitle: widget.restaurant?.deliveryTime != null
                                ? "${int.parse(widget.restaurant!.deliveryTime.replaceAll(RegExp(r'[^0-9]'), '')) + 15} min"
                                : "${15 + 15} min", // default if null
                            color: const Color(0xFF4CAF50),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        Expanded(
                          child: _buildStatItem(
                            icon: Icons.local_shipping_rounded,
                            title: "Free Delivery",
                            subtitle: "Above ₹199",
                            color: const Color(0xFF2196F3),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        Expanded(
                          child: _buildStatItem(
                            icon: Icons.location_on_rounded,
                            title: "Distance",
                            subtitle: widget.restaurant?.distance ?? "1.2 km",
                            color: const Color(0xffC2262D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Category Selection TabBar
                Container(
                  decoration: BoxDecoration(color: Colors.grey.shade200),
                  child: TabBar(
                    onTap: (index) {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                      _scrollToCategory(index);
                    },
                    controller: _tabController,
                    isScrollable: true,
                    indicator: BoxDecoration(
                      color: const Color(0xffC2262D),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey.shade700,
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    dividerColor: Colors.transparent,
                    tabAlignment: TabAlignment.start,
                    padding: const EdgeInsets.all(4),
                    tabs: categories.map((category) {
                      return Tab(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            category,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // Food List
                _buildFoodList(),
                const SizedBox(height: 30),
              ],
            ),
          ),

          // Category Menu Modal
          if (showCategoryMenu)
            GestureDetector(
              onTap: () {
                setState(() {
                  showCategoryMenu = false;
                });
              },
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    height: 350,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Menu Categories',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategoryIndex = index;
                                    _tabController.animateTo(index);
                                    showCategoryMenu = false;
                                  });
                                  // Scroll to the selected category after closing the modal
                                  _scrollToCategory(index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: selectedCategoryIndex == index
                                        ? const Color(
                                            0xffC2262D,
                                          ).withOpacity(0.2)
                                        : Colors.transparent,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          categories[index],
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight:
                                                selectedCategoryIndex == index
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${categoryItemCounts[index]}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Floating Menu Button
          Positioned(
            bottom: 100,
            right: 20,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showCategoryMenu = !showCategoryMenu;
                });
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xffC2262D),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffC2262D).withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.menu, color: Colors.white, size: 24),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        final itemCount = cartController.totalItems;

        if (itemCount == 0) return const SizedBox();

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: GestureDetector(
            onTap: () {
              Get.to(() => CartScreen());
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xffC2262D).withOpacity(0.1),
                    const Color(0xffC2262D).withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xffC2262D).withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffC2262D).withOpacity(0.15),
                    blurRadius: 25,
                    offset: const Offset(0, 8),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    blurRadius: 15,
                    offset: const Offset(-5, -5),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xffC2262D), Color(0xffE63946)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xffC2262D,
                                  ).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(
                              FontAwesomeIcons.shoppingBag,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '$itemCount item${itemCount > 1 ? 's' : ''} added',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xff2D3748),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Ready to checkout',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xff718096),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xffC2262D), Color(0xffE63946)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xffC2262D).withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View Cart',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: const Color(0xFF2D3748),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
