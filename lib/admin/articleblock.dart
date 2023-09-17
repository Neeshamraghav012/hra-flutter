class Article {
  String articleId,
      title,
      description,
      name,
      avatarImg,
      bannerImg,
      // subtitle,
      date;
  // location;

  Article(
      {required this.articleId,
      // required this.subtitle,
      required this.title,
      required this.description,
      required this.name,
      required this.avatarImg,
      required this.bannerImg,
      //required this.location,
      required this.date});
}

class ArticleBloc {
  List<Article> articleList = [
    Article(
      articleId: "1",
      title:
          'Striving to Achieve Over INR 100 Crore in Revenue for FY24, Housr Sets Ambitious Growth Goals',
      //subtitle: 'Just for PROH Members',
      date: "22-09-2023",
      //location: "Hi-Tech City",
      description:
          'Housr, a co-living company, recently underwent a period of evaluation and optimization in its portfolio. Deepak Anand, the co-founder and CEO, explained that over the past four months, the company focused on reevaluating its entire portfolio and making necessary adjustments. This pause allowed them to clean up their operations and make strategic decisions for future growth. Looking ahead, Housr has ambitious plans to launch nine new centers in Gurugram, Bengaluru, and Hyderabad within the next four months. Their goal is to introduce two to three properties per month for the next year. \n\n Currently, Housr operates 70 centers with a total of 5,000 beds spread across Gurugram, Bengaluru, Pune, Hyderabad, and Visakhapatnam. The company boasts an impressive occupancy rate of 97-98% across all its centers. In addition to their expansion plans, Housr is also in the process of raising funds. Previously, they raised \$7 million at \$30 million about 2.5 years ago. Regarding rental prices, Anand mentioned that their price points have nearly doubled over the past five years. In Gurugram, room rents range from Rs 35,000-55,000 per month, while in Bengaluru, they range from Rs 30,000-45,000. In Hyderabad and Pune, rents range from Rs 35,000-45,000.',
      name: 'What is the condition of real estate in hyderabad?',
      avatarImg: ' ',
      bannerImg:
          'https://res.cloudinary.com/hire-easy/image/upload/v1694936466/E4_sukfim.jpg',
    ),
    Article(
      articleId: "2",
      title:
          'Catalyzing Southern Growth: Awfis Sets Sights on 11 New Properties Expansion in South India',
      //subtitle: 'Just for PROH Members',
      date: "22-09-2023",
      //location: "Hi-Tech City",
      description:
          "Awfis, a leading co-working space provider in India, is expanding its presence in South India with 11 new properties. The company's co-working spaces are designed to meet the needs of a variety of businesses, including startups, freelancers, and established companies. Awfis offers a variety of workspace options, amenities, and services that make it the ideal choice for businesses of all sizes. This expansion is part of Awfis's strategic approach to target emerging business hubs and offer an enhanced workspace experience through its diverse range of products and services. The company is targeting key cities in South India, including Hyderabad, Chennai, Bengaluru, and Coimbatore, for its new centers. \n\n Awfis's co-working spaces are designed to meet the needs of a variety of businesses, including startups, freelancers, and established companies. The company offers a variety of workspace options, including private cabins, dedicated desks, and hot desks. Awfis also offers a range of amenities and services, such as high-speed internet, meeting rooms, and printing and scanning facilities. \n\n Regarding rental prices, Anand mentioned that their price points have nearly doubled over the past five years. In Gurugram, room rents range from Rs 35,000-55,000 per month, while in Bengaluru, they range from Rs 30,000-45,000. In Hyderabad and Pune, rents range from Rs 35,000-45,000. \n\n The expansion of Awfis's co-working spaces in South India is expected to meet the growing demand for flexible workspace solutions in the region. The company's co- working spaces are affordable, convenient, and offer a range of amenities and services that make them ideal for businesses of all sizes.",
      name: 'What is the condition of real estate in hyderabad?',
      avatarImg: ' ',
      bannerImg:
          'https://res.cloudinary.com/hire-easy/image/upload/v1694936466/E4_sukfim.jpg',
    ),
    Article(
      articleId: "3",
      title:
          "Telangana HC Stays Memo Allowing Flat Owners' Associations to Register Under Societies Act",
      //subtitle: 'Just for PROH Members',
      date: "22-09-2023",
      //location: "Hi-Tech City",
      description:
          '''The Telangana High Court has stayed a memo issued by the state revenue secretary allowing flat owners' associations in Telangana to register themselves under the Telangana Societies Registration Act (TSRA). The memo had allowed flat owners' associations to circumvent the need to register under the Cooperatives Societies Act (CSA). The court order was passed in response to a petition filed by a flat owner, Madamanchi Ramesh Babu. The petition argued that the memo was illegal and arbitrary, and that it deprived flat owners of their rights under the CSA. \n\n
          The court agreed with the petitioner's arguments and stayed the operation of the memo. The court held that the memo was contrary to the law of the land, and that it could not replace the CSA.
The court's order is a significant development, as it has implications for flat owners across Telangana. The CSA provides flat owners with a number of important rights, including:
The right to elect and remove the managing committee of the flat owners' association
The right to inspect the accounts of the flat owners' association
The right to challenge any decisions of the managing committee that are in violation of the CSA
The TSRA does not provide flat owners with the same level of protection. For example, the TSRA does not require flat owners' associations to hold regular elections or to disclose their accounts to members.
The court's order is a victory for flat owners in Telangana, as it will protect their rights and interests. It is also a reminder that the government cannot simply issue memos to change the law of the land.

The TSRA does not provide flat owners with the same level of protection. For example, the TSRA does not require flat owners' associations to hold regular elections or to disclose their accounts to members.
The court's order is a victory for flat owners in Telangana, as it will protect their rights and interests. It is also a reminder that the government cannot simply issue memos to change the law of the land.
           ''',
      name: 'What is the condition of real estate in hyderabad?',
      avatarImg: ' ',
      bannerImg:
          'https://res.cloudinary.com/hire-easy/image/upload/v1694936466/E4_sukfim.jpg',
    ),
  ];
}
