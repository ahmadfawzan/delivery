class aboutList {
  String title;
  String image;
  String discription;

  aboutList(
      {required this.title, required this.image, required this.discription});
}

List<aboutList> pages = [
  aboutList(
    title: "Water Bottles Services",
    image: "assets/images/image4.png",
    discription:
        "Lorem ipsum dolor sit amet,consectetur \nadipiscing elit. Nunc vulputate libero et.",
  ),
  aboutList(
    title: "Gas Services",
    image: "assets/images/image5.png",
    discription:
        "Lorem ipsum dolor sit amet,consectetur \nadipiscing elit. Nunc vulputate libero et.",
  ),
  aboutList(
    title: "Track Your Order",
    image: "assets/images/Group6809.png",
    discription:
        "Lorem ipsum dolor sit amet,consectetur \nadipiscing elit. Nunc vulputate libero et.",
  ),
];
