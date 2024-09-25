import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  final String _apiKey = 'ea4a1937e2601988da8bedd47759fe40';
  final String _baseUrl = 'https://api.themoviedb.org/3';
  
  // Função para buscar filmes populares
  Future<List<dynamic>> fetchPopularMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey&language=en-US&page=1'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Erro ao buscar filmes populares');
    }
  }

  // Função para buscar filmes com as melhores avaliações
  Future<List<dynamic>> fetchTopRatedMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/top_rated?api_key=$_apiKey&language=en-US&page=1'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Erro ao buscar filmes com as melhores avaliações');
    }
  }

  // Função para buscar filmes que estão por vir
  Future<List<dynamic>> fetchUpcomingMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/upcoming?api_key=$_apiKey&language=en-US&page=1'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Erro ao buscar filmes que estão por vir');
    }
  }
}