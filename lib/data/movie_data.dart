import '../models/movie.dart';

const List<Movie> allMovies = [
  Movie(
    id: 1,
    title: 'Dune: Part Two',
    year: 2024,
    posterUrl: 'https://picsum.photos/id/1025/600/400',
    overview:
    'Paul Atreides unites with Chani and the Fremen while seeking revenge against the people who destroyed his family.',
    genres: ['Action', 'Sci-Fi', 'Drama'],
    rating: 8.6,
    trailers: ['Official Trailer #1', 'IMAX Sneak Peek', 'Behind The Scenes'],
  ),
  Movie(
    id: 2,
    title: 'Deadpool & Wolverine',
    year: 2024,
    posterUrl: 'https://picsum.photos/id/1033/600/400',
    overview:
    'Deadpool teams up with Wolverine for an action-packed and funny mission across the multiverse.',
    genres: ['Action', 'Comedy'],
    rating: 8.3,
    trailers: ['Red Band Trailer', 'Final Trailer', 'Interview Clip'],
  ),
  Movie(
    id: 3,
    title: 'Inside Out 2',
    year: 2024,
    posterUrl: 'https://picsum.photos/id/1040/600/400',
    overview:
    'Riley enters a new stage of life, and her emotions must work together to handle new challenges.',
    genres: ['Animation', 'Comedy', 'Family'],
    rating: 7.9,
    trailers: ['Official Trailer', 'Meet Anxiety', 'Voice Cast Clip'],
  ),
  Movie(
    id: 4,
    title: 'Interstellar',
    year: 2014,
    posterUrl: 'https://picsum.photos/id/1050/600/400',
    overview:
    'A team of explorers travel through a wormhole in space in an attempt to save humanity.',
    genres: ['Sci-Fi', 'Drama'],
    rating: 8.7,
    trailers: ['Official Trailer', 'Docking Scene', 'Behind The Music'],
  ),
  Movie(
    id: 5,
    title: 'Joker',
    year: 2019,
    posterUrl: 'https://picsum.photos/id/1060/600/400',
    overview:
    'A troubled man in Gotham City slowly transforms into the criminal figure known as Joker.',
    genres: ['Drama', 'Crime'],
    rating: 8.4,
    trailers: ['Teaser Trailer', 'Final Trailer', 'Character Featurette'],
  ),
];