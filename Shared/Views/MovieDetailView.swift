import SwiftUI


enum MovieReviewViewModelFactory{
    static func getMovieReviewViewModel()-> MovieReviewsViewModel{
        let repo:MovieReviewRepoProtocol = MovieReviewRepo()
        let useCase:MovieReviewsUseCaseProtocol = MovieReviewsUseCase(movieReviewsRepo: repo)
        let viewModel = MovieReviewsViewModel(movieReviewUseCase: useCase)
        return viewModel
    }
}


enum CastViewModelFactory{
    static func getCastViewModel()->CastViewModel{
        let repo:CastRepoProtocol = CastRepo()
        let useCase:CastUseCaseProtocol = CastUseCase(castRepo: repo)
        let viewModel = CastViewModel(castUseCase: useCase)
        return viewModel
    }
}


struct MovieDetailView: View {
    @EnvironmentObject private var movieBookmarkViewModel:MovieBookmarkViewModel
    @StateObject private var movieReviewViewModel = MovieReviewViewModelFactory.getMovieReviewViewModel()
    @StateObject private var moviesViewModel = MoviesViewModelFactory.getMoviesViewModel()
    @State private var castViewModel = CastViewModelFactory.getCastViewModel()
    var movie: Movie
    @State private var selectedColorIndex = 0
    @Environment (\.horizontalSizeClass) var horizontalClass
    
    
    var body: some View {
#if os(iOS)
        content
#else
        content.frame(maxWidth: 800, maxHeight: 600)
#endif
    }
    @ViewBuilder
    var content: some View {
        
        VStack(spacing:0){
            ScrollView(.vertical,showsIndicators: false){
                AsyncImageView(imageUrl:  movie.posterURL)
                    .frame(maxHeight:300)
                Spacer()
                VStack {
                    VStack(alignment: .leading, spacing: 16) {
                        VStack {
                            Text(movie.title ?? "")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                        }
                        
                        Text(movie.overview)
                        
                        HStack {
                            if !movie.ratingText.isEmpty {
                                Text(movie.ratingText).foregroundColor(.yellow)
                            }
                            Text(movie.scoreText)
                            Spacer()
                            
                            
                            Image(systemName: movieBookmarkViewModel.isBookmarked(for: movie) ? "bookmark.fill":"bookmark")
                                .onTapGesture {
                                    withAnimation{
                                        movieBookmarkViewModel.toggleBookmark(for: movie)
                                    }
                                }
                                .padding(.trailing)
                            
                            
                        }
                    }
                    .padding()
                    
                    
                    Picker("Favorite Color", selection: $selectedColorIndex, content: {
                        Text("Similar").tag(0)
                        Text("Cast").tag(1)
                        Text("reviews").tag(2)
                    })
                    .pickerStyle(SegmentedPickerStyle()) // <1>
                    .padding()
                    
                    
                    switch selectedColorIndex{
                    case 1:
                      movieCastView
                    case 0:
                        similarMoviesView
                    case 2:
                        movieReviewsView
                        
                    default:
                        similarMoviesView
                    }
                }
            }
        }
        .task{
            await loadSimilarMovies(movieId: movie.id?.description ?? "")
            await loadMovieCast(movieId: movie.id?.description ?? "")
            await loadReviews(movieId: movie.id?.description ?? "")
            
        }
    }
    
    @ViewBuilder
    private var movieReviewsView:some View{
        if movieReviewViewModel.phaseState.value?.count  ?? 0 > 1 {
            MovieReviewsView(reviews: movieReviewViewModel.phaseState.value ?? [])
        } else {
            EmptyPlaceholderView(text: "No Reviews found", image: Image(systemName: "film"))
        }
    }
    
    @ViewBuilder
    private var movieCastView:some View{
        if castViewModel.castState.value?.count ?? 0 > 1{
            CastListItemView(cast: castViewModel.castState.value ?? [])
        }
        else{
            EmptyPlaceholderView(text: "No Cast Found", image: Image(systemName: "film"))
        }
    }
    
    @ViewBuilder
    private var similarMoviesView:some View{
        if moviesViewModel.similarMoviesState.value?.count ?? 0 > 1{
            SimilarMovieView(movies: moviesViewModel.similarMoviesState.value ?? [])
            } else {
                EmptyPlaceholderView(text: "No Similar Movies found", image: Image(systemName: "film"))
            }
    }
    
    private func loadSimilarMovies(movieId:String) async{
        await moviesViewModel.fetchSimilarMovies(movieId: movieId)
    }
    
    private func loadMovieCast(movieId:String) async{
        await castViewModel.getMovieCast(movieId: movieId)
    }
    private func loadReviews(movieId:String) async {
        await movieReviewViewModel.getMovieReviews(movieId: movieId)
    }
    
}

struct MovieDetailView_Previews: PreviewProvider {
    @StateObject static  var movieBookmarkViewModel = MovieBookmarkViewModel()
    static var previews: some View {
        MovieDetailView(movie: .stubbedMovies[0])
            .environmentObject(movieBookmarkViewModel)
    }
}
