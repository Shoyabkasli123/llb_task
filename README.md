LLB Task - Flutter Product App
Overview

This project is a Flutter application that displays a list of products with search, filtering, and product detail 
functionality. The app follows a clean architecture approach using GetX for state management, 
dependency injection, routing, and API handling.

Features
Product Listing
Product Details Screen
Search Products
Filter Products by Category
Filter Products by Price Range
Pagination (Load More)
Internet Connectivity Check
Responsive UI
GetX State Management

 lib/
│
├── controller/
│   └── ProductController
│
├── data/
│   ├── api/
│   ├── model/
│   └── repo/
│
├── helper/
│   ├── get_di.dart
│   └── route_helper.dart
│
├── utils/
│   ├── app_constant.dart
│   ├── app_colors.dart
│   ├── dimensions.dart
│   └── images.dart
│
├── view/
│   ├── screens/
│   │   ├── splash/
│   │   ├── product/
│   │   └── product_detail/
│   │
│   └── base/
│
└── main.dart


State Management

The project uses GetX for:

/// State Management

Dependency Injection
Navigation & Routing

Controllers are initialized using the dependency injection setup in:

helper/get_di.dart

Example:

Get.lazyPut(() => ProductController(
productRepo: Get.find(),
));

/// API Handling

API-related functionality is managed inside the data layer.

Structure
data/
├── api/
├── model/
└── repo/
Responsibilities
API Calls
Response Models
Repository Pattern
Error Handling


/// Screens

Splash Screen

Purpose:

Initial screen of the app.
Checks internet connectivity before loading data.
Product Screen

Features:

Fetch all products.
Display products in a list.
Pagination support.
Search products.
Filter by category.
Filter by maximum price using a slider.
Product Detail Screen

Features:

Displays complete product information.
Product images.
Product price.
Product category.
Product description.
Additional metadata.