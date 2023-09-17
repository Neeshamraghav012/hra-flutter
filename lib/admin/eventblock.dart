class Event {
  String eventId,
      title,
      description,
      name,
      avatarImg,
      bannerImg,
      subtitle,
      date,
      location;

  Event(
      {required this.eventId,
      required this.subtitle,
      required this.title,
      required this.description,
      required this.name,
      required this.avatarImg,
      required this.bannerImg,
      required this.location,
      required this.date});
}

class EventBloc {
  List<Event> eventList = [
    Event(
      eventId: "1",
      title: 'CP Event',
      subtitle: 'Just for PROH Members',
      date: "22-09-2023",
      location: "Hi-Tech City",
      description:
          'on the future of ticketing systems. Honed over time, combined with research, experience, and an eye for the best possible future state of support, we think you’ll be interested in knowing these perspectives of modern ticketing.on the future of ticketing systems. Honed over time, combined with research, experience, and an eye for the best possible future state of support, we think you’ll be interested in knowing these perspectives of modern ticketing.',
      name: 'What is the condition of real estate in hyderabad?',
      avatarImg: ' ',
      bannerImg: 'https://res.cloudinary.com/hire-easy/image/upload/v1694936466/E4_sukfim.jpg',
    ),
    Event(
      eventId: "1",
      title: 'CP Event',
      subtitle: 'Just for PROH Members',
      date: "22-09-2023",
      location: "Hi-Tech City",
      description:
          'on the future of ticketing systems. Honed over time, combined with research, experience, and an eye for the best possible future state of support, we think you’ll be interested in knowing these perspectives of modern ticketing.on the future of ticketing systems. Honed over time, combined with research, experience, and an eye for the best possible future state of support, we think you’ll be interested in knowing these perspectives of modern ticketing.',
      name: 'What is the condition of real estate in hyderabad?',
      avatarImg: ' ',
      bannerImg: 'https://res.cloudinary.com/hire-easy/image/upload/v1694936466/E4_sukfim.jpg',
    ),
    Event(
      eventId: "1",
      title: 'CP Event',
      subtitle: 'Just for PROH Members',
      date: "22-09-2023",
      location: "Hi-Tech City",
      description:
          'on the future of ticketing systems. Honed over time, combined with research, experience, and an eye for the best possible future state of support, we think you’ll be interested in knowing these perspectives of modern ticketing.on the future of ticketing systems. Honed over time, combined with research, experience, and an eye for the best possible future state of support, we think you’ll be interested in knowing these perspectives of modern ticketing.',
      name: 'What is the condition of real estate in hyderabad?',
      avatarImg: ' ',
      bannerImg: 'https://res.cloudinary.com/hire-easy/image/upload/v1694936466/E4_sukfim.jpg',
    ),
  ];
}
