class onBordContent {
  String? image;
  String? title;
  String? discription;

  onBordContent({this.image, this.title, this.discription});
}

List<onBordContent> contents = [
  onBordContent(
    title: 'Order in Seconds',
    image: 'assets/images/G6.png',
    discription: "Browse menus, customize meals, and place your food order within seconds with XpressBites.",
  ),
  onBordContent(
    title: 'Delivered Fresh & Fast',
    image: 'assets/images/G2.png',
    discription: "Hot, delicious meals delivered right to your hostel, home, or PG — just the way you like it.",
  ),
  onBordContent(
    title: 'Track Every Step',
    image: 'assets/images/G8.png',
    discription: "Know exactly where your food is — from kitchen to doorstep — with real-time live tracking.",
  ),
];
