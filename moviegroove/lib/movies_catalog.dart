import 'package:flutter/material.dart';
import 'movie_service.dart';

class MoviesCatalog extends StatefulWidget {
  @override
  _MoviesCatalogState createState() => _MoviesCatalogState();
}

class _MoviesCatalogState extends State<MoviesCatalog> {
  final MovieService _movieService = MovieService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(  
        leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white), // Ícone de seta para voltar
    onPressed: () {
      Navigator.of(context).pop(); // Ação para voltar à tela anterior
    },
  ),
        title: Text('Movies Catalog', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(  // Permite rolar o conteúdo se necessário
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título da seção "Trending Now"
              Text(
                'Trending Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // Fileira de filmes "Trending Now"
              SizedBox(
                height: 240,  // Altura fixa para a fileira de filmes
                child: _buildMoviesRow('Trending Now', _movieService.fetchPopularMovies()),
              ),
              SizedBox(height: 10),
              // Título da seção "Top Rated"
              Text(
                'Top Rated',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // Fileira de filmes "Top Rated"
              SizedBox(
                height: 240,
                child: _buildMoviesRow('Top Rated', _movieService.fetchTopRatedMovies()),
              ),
              SizedBox(height: 20),
              // Título da seção "Upcoming"
              Text(
                'Upcoming',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // Fileira de filmes "Upcoming"
              SizedBox(
                height: 240,
                child: _buildMoviesRow('Upcoming', _movieService.fetchUpcomingMovies()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoviesRow(String sectionTitle, Future<List<dynamic>> movieFuture) {
    return FutureBuilder<List<dynamic>>(
      future: movieFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar filmes', style: TextStyle(color: Colors.white)));
        } else {
          final movies = snapshot.data!;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              final imageUrl = 'https://image.tmdb.org/t/p/w500${movie['poster_path']}';
              final synopsis = movie['overview']; // Sinopse do filme
              return MovieCard(imageUrl: imageUrl, title: movie['title'], synopsis: synopsis);
            },
          );
        }
      },
    );
  }
}

// Widget para exibir a miniatura de cada filme
class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String synopsis;

  const MovieCard({Key? key, required this.imageUrl, required this.title, required this.synopsis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Detecta clique no cartaz
      onTap: () {
        _showSynopsisDialog(context, title, synopsis); // Mostra a sinopse ao clicar
      },
      child: Container(
        margin: EdgeInsets.only(right: 12.0), // Espaçamento entre os cards
        width: 120, // Largura fixa para manter a proporção do pôster
        child: Column(
          mainAxisSize: MainAxisSize.min, // Evita expansão vertical excessiva
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do filme
            Container(
              width: 120,
              height: 180, // Altura fixa para o pôster
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 8), // Espaçamento entre a imagem e o título
            // Título do filme
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 1, // Limita o título a uma linha
              overflow: TextOverflow.ellipsis, // Adiciona "..." se o título for muito longo
            ),
          ],
        ),
      ),
    );
  }

  // Função para exibir um diálogo com a sinopse do filme
  void _showSynopsisDialog(BuildContext context, String title, String synopsis) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            synopsis,
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: Text('Fechar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}