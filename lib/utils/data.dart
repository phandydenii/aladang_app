import 'package:easy_localization/easy_localization.dart';

List shopMenuList = [
  {"name": "order".tr(), "image": "assets/images/order1.png"},
  {"name": "shop".tr(), "image": "assets/images/shop1.png"},
  {"name": "product".tr(), "image": "assets/images/product1.png"},
  {"name": "request".tr(), "image": "assets/images/request.png"},
  {"name": "payme".tr(), "image": "assets/images/qr.png"},
  {"name": "report".tr(), "image": "assets/images/report1.png"},
];

List customerMenuList = [
  {"id": 1, "name": "order_history", "image": "assets/images/order1.png"},
  {"id": 2, "name": "shop", "image": "assets/images/shop1.png"},
  //{"id": 3,"name": "product", "image":"assets/images/product1.png"},
];

List getStartList = [
  {
    "id": 1,
    "image": "assets/gifs/gif1.gif",
    "title": "Easy Market Search",
    "description":
        "Search for new markets and hungry for new ideas, opportunity and excitement."
  },
  {
    "id": 2,
    "image": "assets/gifs/istockphoto_illustration_step1.jpg",
    "title": "Professional Reviewer",
    "description":
        "try our services we will provide you our best analysis research for free."
  },
  {
    "id": 3,
    "image": "ssets/gifs/shopping_peoplegreate_illustration_step2.jpg",
    "title": "Find ideal Idea",
    "description":
        "Fusce elementum et elit eget placerat. Praesent suscipit metus nec dolor vestibulum, id pretium sapien ornare"
  },
];

List imageList = [
  {"id": 1, "img": "assets/images/hotel-1.jpg"},
  {"id": 2, "img": "assets/images/hotel-2.jpg"},
  {"id": 3, "img": "assets/images/hotel-3.jpg"},
  {"id": 4, "img": "assets/images/hotel-4.jpg"},
  {"id": 5, "img": "assets/images/hotel-5.jpg"},
  {"id": 6, "img": "assets/images/hotel-6.jpg"},
  {"id": 7, "img": "assets/images/hotel-7.jpg"}
];

List roomListAll = [
  {
    "id": 1,
    "roomno": "001",
    "roomtype": "Normal",
    "floor": "G",
    "servicecharge": 2,
    "price": 100,
    "status": "Free",
    "img": "assets/images/hotel-1.jpg"
  },
  {
    "id": 2,
    "roomno": "001",
    "roomtype": "Normal",
    "floor": "G",
    "servicecharge": 2,
    "price": 100,
    "status": "Free",
    "img": "assets/images/hotel-1.jpg"
  },
  {
    "id": 3,
    "roomno": "001",
    "roomtype": "Normal",
    "floor": "G",
    "servicecharge": 2,
    "price": 100,
    "status": "Free",
    "img": "assets/images/hotel-1.jpg"
  },
  {
    "id": 4,
    "roomno": "001",
    "roomtype": "Normal",
    "floor": "G",
    "servicecharge": 2,
    "price": 100,
    "status": "Free",
    "img": "assets/images/hotel-1.jpg"
  },
  {
    "id": 5,
    "roomno": "001",
    "roomtype": "Normal",
    "floor": "G",
    "servicecharge": 2,
    "price": 100,
    "status": "Free",
    "img": "assets/images/hotel-1.jpg"
  },
  {
    "id": 6,
    "roomno": "001",
    "roomtype": "Normal",
    "floor": "G",
    "servicecharge": 2,
    "price": 100,
    "status": "Free",
    "img": "assets/images/hotel-1.jpg"
  },
  {
    "id": 7,
    "roomno": "001",
    "roomtype": "Normal",
    "floor": "G",
    "servicecharge": 2,
    "price": 100,
    "status": "Free",
    "img": "assets/images/hotel-1.jpg"
  }
];

List categories = [
  {"name": "All", "icon": "assets/icons/home.svg"},
  {"name": "Single Room", "icon": "assets/icons/home.svg"},
  {"name": "Double Room", "icon": "assets/icons/home.svg"},
  {"name": "Family Room", "icon": "assets/icons/home.svg"},
  {"name": "Queen Room", "icon": "assets/icons/home.svg"},
  {"name": "King Room", "icon": "assets/icons/home.svg"},
  {"name": "Bungalow", "icon": "assets/icons/home.svg"},
  {"name": "Single Villa", "icon": "assets/icons/home.svg"},
  {"name": "Apartment", "icon": "assets/icons/home.svg"},
];

List cities = [
  {"name": "Normal", "icon": "assets/icons/home.svg"},
  {"name": "Double", "icon": "assets/icons/home.svg"},
  {"name": "VIP", "icon": "assets/icons/home.svg"},
];

List<String> albumImages = [
  "https://images.unsplash.com/photo-1598928636135-d146006ff4be?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1505692952047-1a78307da8f2?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1618221118493-9cfa1a1c00da?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1571508601891-ca5e7a713859?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
];

List features = [
  {
    "id": 100,
    "name": "Superior Room",
    "image":
        "https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "\$210",
    "type": categories[1]["name"],
    "rate": "4.5",
    "location": "Phnom Penh",
    "is_favorited": false,
    "album_images": albumImages,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
  },
  {
    "id": 101,
    "name": "Junior Suite",
    "image":
        "https://images.unsplash.com/photo-1505692952047-1a78307da8f2?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "\$150",
    "type": categories[3]["name"],
    "rate": "4.5",
    "location": "Phnom Penh",
    "is_favorited": true,
    "album_images": albumImages,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
  },
  {
    "id": 102,
    "name": "Classic Queen Room",
    "image":
        "https://images.unsplash.com/photo-1618221118493-9cfa1a1c00da?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "\$320",
    "type": categories[2]["name"],
    "rate": "4.5",
    "location": "Phnom Penh",
    "is_favorited": false,
    "album_images": albumImages,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
  },
  {
    "id": 103,
    "name": "Luxury King",
    "image":
        "https://images.unsplash.com/photo-1571508601891-ca5e7a713859?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "\$350",
    "type": categories[2]["name"],
    "rate": "4.5",
    "location": "Phnom Penh",
    "is_favorited": false,
    "album_images": albumImages,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
  },
  {
    "id": 104,
    "name": "Classic Room",
    "image":
        "https://images.unsplash.com/photo-1541123356219-284ebe98ae3b?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "\$180",
    "type": categories[4]["name"],
    "rate": "4.5",
    "location": "Phnom Penh",
    "is_favorited": false,
    "album_images": albumImages,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
  },
  {
    "id": 105,
    "name": "Twin Room",
    "image":
        "https://images.unsplash.com/photo-1566195992011-5f6b21e539aa?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "\$250",
    "type": categories[1]["name"],
    "rate": "4.5",
    "location": "Phnom Penh",
    "is_favorited": false,
    "album_images": albumImages,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
  },
];

List recommends = [
  {
    "id": 110,
    "name": "Luxury King",
    "image":
        "https://images.unsplash.com/photo-1541123356219-284ebe98ae3b?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "\$310",
    "type": categories[1]["name"],
    "rate": "4.5",
    "location": "Phnom Penh",
    "is_favorited": false,
    "album_images": albumImages,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
  },
  {
    "id": 111,
    "name": "Classic Room",
    "image":
        "https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "\$250",
    "type": categories[2]["name"],
    "rate": "4.5",
    "location": "Phnom Penh",
    "is_favorited": false,
    "album_images": albumImages,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
  },
  {
    "id": 112,
    "name": "Twin Room",
    "image":
        "https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "\$190",
    "type": categories[1]["name"],
    "rate": "4.5",
    "location": "Phnom Penh",
    "album_images": albumImages,
    "is_favorited": false,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
  },
];
