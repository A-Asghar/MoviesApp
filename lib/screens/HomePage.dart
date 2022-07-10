import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imdb/repository.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:imdb/widgets/HeadingText.dart';
import 'package:imdb/widgets/MegaText.dart';

import 'DetailsScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late var popularMoviesList = [];
  late var nowPlayingMoviesList = [];
  late var topRatedMoviesList = [];

  String imageUrl = 'https://image.tmdb.org/t/p/w500';
  MoviesRepository repository = MoviesRepository();
  @override
  initState() {
    getPopularMovies();
    getNowPlayingMovies();
    getTopRatedMovies();
    // TODO: implement initState
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
    // print(await movies[0]);
    setState(() {
      nowPlayingMoviesList = movies;
    });
  }

  getTopRatedMovies() async {
    var movies = await repository.getTopRatedMovies();
    // print(await movies[0]);
    setState(() {
      topRatedMoviesList = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = popularMoviesList
        .map((item) => Container(
              child: Column(
                children: [
                  // Container(width: 30, child:  HeadingText(text: item['title']),),
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
          leading: const Icon(Icons.menu,color: Colors.white,),
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
                    : NowPlayingMovies(),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: HeadingText(text: 'Top Rated'),
              ),
              SizedBox(
                height: 200,
                child: topRatedMoviesList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : TopRatedMovies(),
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

  Widget NowPlayingMovies() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: nowPlayingMoviesList.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  DetailsScreen(movie: nowPlayingMoviesList[index])));
        },
        child: Container(
          padding: EdgeInsets.only(left: 15, bottom: 20),
          child: Image(
            image: NetworkImage(
                '$imageUrl${nowPlayingMoviesList[index]['poster_path']}'),
          ),
        ),
      ),
    );
  }

  Widget TopRatedMovies() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: topRatedMoviesList.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  DetailsScreen(movie: topRatedMoviesList[index])));
        },
        child: Container(
          padding: EdgeInsets.only(left: 15, bottom: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: NetworkImage(
                  '$imageUrl${topRatedMoviesList[index]['poster_path']}'),
            ),
          ),
        ),
      ),
    );
  }
}
