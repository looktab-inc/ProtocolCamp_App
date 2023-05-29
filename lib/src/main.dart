import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'swipe/swipe.dart'; //Swipe

import 'candy_history/candy_history.dart'; //CandyHistory
import 'favorite/like_list.dart';  //LikeList

import 'login/login.dart'; //SignInDemo

import 'nft/nft_detail.dart'; //NftDetailScreen
import 'review/write_review.dart'; //ReviewWrite

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: Swipe(),
  ));
}
