import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:imdb/repository.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:imdb/widgets/HeadingText.dart';
import 'package:imdb/widgets/MegaText.dart';

import '../widgets/NowPlayingMovies.dart';
import '../widgets/TopRatedMovies.dart';
import '../widgets/UpcomingMovies.dart';
import 'DetailsScreen.dart';
import 'FavouritesScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late var popularMoviesList = [];
  late var nowPlayingMoviesList = [];
  late var topRatedMoviesList = [];
  late var upcomingMoviesList = [];

  String imageUrl = 'https://image.tmdb.org/t/p/w500';
  MoviesRepository repository = MoviesRepository();
  @override
  initState() {
    getPopularMovies();
    getNowPlayingMovies();
    getTopRatedMovies();
    getUpcomingMovies();


    super.initState();
  }

  getPopularMovies() async {
    var movies = await repository.getPopularMovies();

    setState(() {
      popularMoviesList = movies;
    });
  }

  getNowPlayingMovies() async {
    var movies = await repository.getNowPlayingMovies();
    setState(() {
      nowPlayingMoviesList = movies;
    });
  }

  getTopRatedMovies() async {
    var movies = await repository.getTopRatedMovies();
    setState(() {
      topRatedMoviesList = movies;
    });
  }

  getUpcomingMovies() async {
    var movies = await repository.getUpcomingMovies();
    setState(() {
      upcomingMoviesList = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = popularMoviesList
        .map((item) => Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailsScreen(movie: item)));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          BlurredImage(item),
                          FrontImage(item),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
        .toList();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 35,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FavouritesScreen(),
              ));
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.center,
                child: MegaText(text: 'Popular Now'),
              ),
              TrendingCarousel(imageSliders),
              const Align(
                alignment: Alignment.centerLeft,
                child: HeadingText(text: 'Now Playing'),
              ),
              SizedBox(
                height: 250,
                child: nowPlayingMoviesList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : NowPlayingMovies(nowPlayingMoviesList, imageUrl),
              ),

              const Align(
                alignment: Alignment.centerLeft,
                child: HeadingText(text: 'Upcoming'),
              ),
              SizedBox(
                height: 350,
                child: nowPlayingMoviesList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : UpcomingMovies(upcomingMoviesList, imageUrl),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: HeadingText(text: 'Top Rated'),
              ),
              SizedBox(
                height: 200,
                child: topRatedMoviesList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : TopRatedMovies(topRatedMoviesList, imageUrl),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget TrendingCarousel(imageSliders) {
    return CarouselSlider(
      options: CarouselOptions(
        // height: 400,
        height: MediaQuery.of(context).size.height * 0.55,
        autoPlay: false,
        aspectRatio: 2,
        enlargeCenterPage: true,
      ),
      items: imageSliders,
    );
  }

  Widget BlurredImage(item) {
    return SizedBox(
      // height: 350,
      height: MediaQuery.of(context).size.height * 0.46,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Image.network(
            '$imageUrl${item['poster_path']}',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget FrontImage(item) {
    return Container(
      height: 300,
      width: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network('$imageUrl${item['poster_path']}'),
      ),
    );
  }
}
