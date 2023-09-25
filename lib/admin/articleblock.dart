class Article {
  String articleId,
      title,
      description,
      name,
      avatarImg,
      bannerImg,
      // subtitle,
      img,
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
      required this.img,
      //required this.location,
      required this.date});
}

class ArticleBloc {
  List<Article> articleList = [
    Article(
      articleId: "1",
      title: '''Striving to Achieve Over INR 100
Crore in Revenue for FY24, Housr
Sets Ambitious Growth Goals''',
      //subtitle: 'Just for PROH Members',
      date: "22-09-2023",
      //location: "Hi-Tech City",
      description:
          '''Housr, a co-living company, recently underwent a period of evaluation and optimization in its portfolio. Deepak Anand, the co-founder and CEO, explained that over the past four months, the company focused on reevaluating its entire portfolio and making necessary adjustments. This pause allowed them to clean up their operations and make strategic decisions for future growth. Looking ahead, Housr has ambitious plans to launch nine new centers in Gurugram, Bengaluru, and Hyderabad within the next four months. Their goal is to introduce two to three properties per month for the next year. \n\n Currently, Housr operates 70 centers with a total of 5,000 beds spread across Gurugram, Bengaluru, Pune, Hyderabad, and Visakhapatnam. The company boasts an impressive occupancy rate of 97-98% across all its centers. In addition to their expansion plans, Housr is also in the process of raising funds. Previously, they raised \$7 million at \$30 million about 2.5 years ago. Regarding rental prices, Anand mentioned that their price points have nearly doubled over the past five years. In Gurugram, room rents range from Rs 35,000-55,000 per month, while in Bengaluru, they range from Rs 30,000-45,000. In Hyderabad and Pune, rents range from Rs 35,000-45,000.''',
      name: 'What is the condition of real estate in hyderabad?',
      avatarImg: ' ',
      img: 'images/1.png',
      bannerImg:
          'https://res.cloudinary.com/hire-easy/image/upload/v1694936466/E4_sukfim.jpg',
    ),
    Article(
      articleId: "2",
      title: '''Catalyzing Southern Growth: Awfis
Sets Sights on 11 New Properties
Expansion in South India''',
      //subtitle: 'Just for PROH Members',
      date: "22-09-2023",
      //location: "Hi-Tech City",
      description:
          '''Awfis, a leading co-working space provider in India, is expanding its presence in South India with 11 new properties. The company's co-working spaces are designed to meet the needs of a variety of businesses, including startups, freelancers, and established companies. Awfis offers a variety of workspace options, amenities, and services that make it the ideal choice for businesses of all sizes. This expansion is part of Awfis's strategic approach to target emerging business hubs and offer an enhanced workspace experience through its diverse range of products and services. The company is targeting key cities in South India, including Hyderabad, Chennai, Bengaluru, and Coimbatore, for its new centers. \n\n Awfis's co-working spaces are designed to meet the needs of a variety of businesses, including startups, freelancers, and established companies. The company offers a variety of workspace options, including private cabins, dedicated desks, and hot desks. Awfis also offers a range of amenities and services, such as high-speed internet, meeting rooms, and printing and scanning facilities. \n\n Regarding rental prices, Anand mentioned that their price points have nearly doubled over the past five years. In Gurugram, room rents range from Rs 35,000-55,000 per month, while in Bengaluru, they range from Rs 30,000-45,000. In Hyderabad and Pune, rents range from Rs 35,000-45,000. \n\n The expansion of Awfis's co-working spaces in South India is expected to meet the growing demand for flexible workspace solutions in the region. The company's co- working spaces are affordable, convenient, and offer a range of amenities and services that make them ideal for businesses of all sizes.''',
      name: 'What is the condition of real estate in hyderabad?',
      avatarImg: ' ',
      img: 'images/2.png',
      bannerImg:
          'https://res.cloudinary.com/hire-easy/image/upload/v1694936466/E4_sukfim.jpg',
    ),
    Article(
      articleId: "3",
      title: '''Telangana HC Stays Memo Allowing
Flat Owners' Associations to Register
Under Societies Act''',
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
      img: 'images/3.png',
      bannerImg:
          'https://res.cloudinary.com/hire-easy/image/upload/v1694936466/E4_sukfim.jpg',
    ),
    Article(
      articleId: "4",
      title: "Five Homebuyers Get Relief in\n"
          "Sahiti Infra Scam",
      //subtitle: 'Just for PROH Members',
      date: "22-09-2023",
      //location: "Hi-Tech City",
      description: '''Five homebuyers who had invested in flats
promoted by the scam-hit Sahiti Infra in Hyderabad
have been granted relief by the Hyderabad District
Consumer Disputes Redressal Commission-3. The
commission has ordered the firm to refund the
entire amount invested by the consumers along
with interest and compensation.
The Hyderabad District Consumer Disputes
Redressal Commission-3 has ordered Sahiti
Infra to refund the entire amount invested
by five homebuyers along with interest and
compensation. The commission's order
comes as a relief to the homebuyers, who
had been cheated by the builder.
Sahiti Infra is a Hyderabad-based real estate
company that was founded in 2010. The
company had launched several residential
projects in the city, but it failed to deliver on
its promises. In 2022, the company was
accused of cheating homebuyers and was
investigated by the police and the
Enforcement Directorate. The five homebuyers who were granted
relief by the commission had invested in
Sahiti Infra's project called Sahiti Enclave.
The project was supposed to be completed
in 2022, but it is still under construction. The
homebuyers had paid the full amount for
their flats, but they have not been able to
take possession of them yet. The commission ordered Sahiti Infra to
refund the entire amount invested by the
homebuyers with interest at 9% per annum
from the date of investment. The
commission also ordered the firm to pay a
compensation of Rs. 50,000 to each
homebuyer. The commission's order is a significant
development in the Sahiti Infra scam. It will
give hope to other homebuyers who have
been cheated by the builder. The order also
sends a strong message to real estate
developers that they cannot cheat
homebuyers with impunity.\n
Additional details:\n
The five homebuyers who were granted
relief by the commission are:\n
Vishwanadham Keshetti\n
Chaluvadi Sridhar\n
Yarlagadda Sravanthi\n
B. Srinivas\n
S. Sudhakar \n
The Sahiti Enclave project is located in
the Jeedimetla area of Hyderabad. It was
launched in 2018 and was supposed to be
completed in 2022. However, the project
is still under construction.
Sahiti Infra is also facing cases in other
courts. In June 2023, the Telangana High
Court directed the Enforcement
Directorate to attach the assets of the
company's directors. The Hyderabad District Consumer Disputes
Redressal Commission-3's order granting
relief to five homebuyers who had invested
in Sahiti Infra's Sahiti Enclave project is a
significant development. It will give hope to
other homebuyers who have been cheated
by the builder and send a strong message to
real estate developers that they cannot
cheat homebuyers with impunity.
           ''',
      name: 'What is the condition of real estate in hyderabad?',
      avatarImg: ' ',
      img: 'images/4.png',
      bannerImg:
          'https://res.cloudinary.com/hire-easy/image/upload/v1694936466/E4_sukfim.jpg',
    ),
    Article(
      articleId: "5",
      title: '''Prospective Tenants in
Hyderabad Beware of Rental
Scams''',
      //subtitle: 'Just for PROH Members',
      date: "22-09-2023",
      //location: "Hi-Tech City",
      description: '''Prospective tenants in Hyderabad are being
targeted by con artists who are posing as landlords
and real estate agents. The con artists are duping
tenants into paying security deposits and advance
rent for flats that do not exist or are not available for
rent.
Prospective tenants in Hyderabad are being
targeted by con artists who are posing as
landlords and real estate agents. The con
artists are duping tenants into paying
security deposits and advance rent for flats
that do not exist or are not available for rent.
The Hyderabad Police have issued a warning
to prospective tenants to be vigilant and to
avoid paying any money to landlords or real
estate agents without verifying their
credentials. The police said that the con artists typically
target tenants who are new to the city or
who are in a hurry to find a place to live. The
con artists post fake advertisements for flats
on websites and social media platforms. They
also approach tenants directly and offer
them flats at discounted rates. Once the tenant agrees to rent the flat, the
con artists demand a security deposit and
advance rent. They often give the tenant a
copy of a fake lease agreement. Once the
tenant pays the money, the con artists
disappear.
The police said that there have been several
cases of rental scams in Hyderabad in recent
months. In one case, a tenant was duped of
Rs. 2 lakh by a con artist who posed as a
landlord. The tenant paid the security deposit and
advance rent for a flat in a posh locality, but
the flat did not exist.

In another case, a tenant was duped of Rs. 1
lakh by a con artist who posed as a real
estate agent. The tenant paid the agent a
commission fee to find him a flat, but the
agent never found him a flat.
The police have advised prospective tenants
to take the following precautions to avoid
falling victim to rental scams:\n
Do not pay any money to landlords or real
estate agents without verifying their
credentials.\n
Ask the landlord for the original title deed
of the property.\n
Ask the landlord for the previous tenant's
contact details and speak to them about
the landlord.\n
Visit the flat in person and inspect it
thoroughly before agreeing to rent it.\n
Sign a lease agreement with the landlord
before paying any money.\n
The police have also advised tenants to
report any suspicious activity to the
police immediately.\n
The Hyderabad Police have set up a
special task force to investigate rental
scams.\n
The task force has arrested several con
artists in recent months.\n
The police have also issued a list of tips
for prospective tenants to avoid falling
victim to rental scams.\n
Prospective tenants in Hyderabad should be
vigilant and take the necessary precautions
to avoid falling victim to rental scams. They
should not pay any money to landlords or
real estate agents without verifying their
credentials. They should also visit the flat in
person and inspect it thoroughly before
agreeing to rent it.
           ''',
      name: 'What is the condition of real estate in hyderabad?',
      avatarImg: ' ',
      img: 'images/5.png',
      bannerImg:
          'https://res.cloudinary.com/hire-easy/image/upload/v1694936466/E4_sukfim.jpg',
    ),
    Article(
      articleId: "6",
      title: '''Telangana Government
Distributes 2BHK Flats to 11,700
Beneficiaries in Hyderabad.''',
      //subtitle: 'Just for PROH Members',
      date: "22-09-2023",
      //location: "Hi-Tech City",
      description: '''The Telangana government on Saturday distributed
2BHK flats to 11,700 beneficiaries in Hyderabad. The
flats were allotted under the state government's
flagship 2BHK Dignity Housing Scheme. The scheme
aims to provide affordable and dignified housing to
low-income families.\n
The Telangana government on Saturday
distributed 2BHK flats to 11,700 beneficiaries
in Hyderabad. The flats were allotted under
the state government's flagship 2BHK
Dignity Housing Scheme. The scheme aims
to provide affordable and dignified housing
to low-income families.\n
The flats were distributed at nine different
locations across the city. The beneficiaries
were selected through a lottery system.\n
The flats are located in well-developed areas
with good access to schools, hospitals, and
other public facilities.\n
The Telangana government has launched
the 2BHK Dignity Housing Scheme in 2020
to provide affordable housing to low-income
families. The scheme targets families with an
annual income of less than Rs. 10 lakh. The
government has set a target of constructing
2.5 lakh 2BHK flats under the scheme.\n
The distribution of 2BHK flats to 11,700
beneficiaries in Hyderabad is a major
achievement for the Telangana government.
It is a step towards the government's goal of
providing affordable and dignified housing
to all low-income families in the state.\n
Additional details:\n
The 2BHK Dignity Housing Scheme is a flagship program of the Telangana
government.\n
The scheme aims to provide affordable and dignified housing to low-income
families.\n
The government has set a target of constructing 2.5 lakh 2BHK flats under the
scheme.\n
The flats are located in well-developed areas with good access to schools, hospitals,
and other public facilities.\n
The beneficiaries are selected through a lottery system.\n
The distribution of 2BHK flats to 11,700 beneficiaries in Hyderabad is a major
achievement for the Telangana government. It is a step towards the government's
goal of providing affordable and dignified housing to all low-income families in the
state.

           ''',
      name: 'What is the condition of real estate in hyderabad?',
      avatarImg: ' ',
      img: 'images/6.png',
      bannerImg:
          'https://res.cloudinary.com/hire-easy/image/upload/v1694936466/E4_sukfim.jpg',
    ),
    Article(
      articleId: "7",
      title: '''State and Central Government
Departments Owe Rs 6,000
Crore in Property Tax in
Hyderabad''',
      //subtitle: 'Just for PROH Members',
      date: "22-09-2023",
      //location: "Hi-Tech City",
      description: '''State and central government departments owe Rs
6,000 crore in property tax to the Greater
Hyderabad Municipal Corporation (GHMC). The
GHMC has sent notices to the defaulting
departments, but they have not responded. The
GHMC is now planning to take legal action against
the defaulting departments.
The Greater Hyderabad Municipal
Corporation (GHMC) is facing a challenge in
collecting property tax from state and
central government departments. The
GHMC estimates that the government
departments owe Rs 6,000 crore in property
tax.\n The GHMC has sent notices to the defaulting
departments, but they have not responded.
The GHMC is now planning to take legal
action against the defaulting departments.\n The GHMC is a local government body
responsible for providing civic services in
Hyderabad. The property tax is one of the
main sources of revenue for the GHMC. The
GHMC uses the property tax revenue to
provide services such as sanitation, garbage
collection, and road maintenance.
The non-payment of property tax by
government departments is a major
financial burden on the GHMC. The GHMC is
already facing a financial crunch due to the
COVID-19 pandemic. The non-payment of
property tax by government departments is
making it even more difficult for the GHMC
to provide basic civic services to the citizens
of Hyderabad.\n
The GHMC has urged the government departments to pay their property tax dues immediately.
The GHMC has also warned that it will take legal action against the defaulting departments if
they do not pay their dues.\n
Additional details:\n
The GHMC is a local government body responsible for providing civic services in Hyderabad.\n
The property tax is one of the main sources of revenue for the GHMC.\n
The GHMC uses the property tax revenue to provide services such as sanitation, garbage collection, and
road maintenance.\n
The non-payment of property tax by government departments is a major financial burden on the GHMC.\n
The GHMC is already facing a financial crunch due to the COVID-19 pandemic.\n
The non-payment of property tax by government departments is making it even more difficult for the
GHMC to provide basic civic services to the citizens of Hyderabad.\n
The GHMC has urged the government departments to pay their property tax dues immediately.\n
The GHMC has also warned that it will take legal action against the defaulting departments if they do
not pay their dues.\n
The non-payment of property tax by state and central government departments is a major
challenge for the GHMC. The GHMC is urging the government departments to pay their property
tax dues immediately. The GHMC is also planning to take legal action against the defaulting
departments.
           ''',
      name: 'What is the condition of real estate in hyderabad?',
      avatarImg: ' ',
      img: 'images/7.png',
      bannerImg:
          'https://res.cloudinary.com/hire-easy/image/upload/v1694936466/E4_sukfim.jpg',
    ),
  ];
}
