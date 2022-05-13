import SwiftUI
struct MovieDetailView: View {
    @EnvironmentObject private var movieBookmarkViewModel:MovieBookmarkViewModel
    
    var movie: Movie
    @State private var selectedColorIndex = 0
    let columns = [GridItem(.adaptive(minimum: 80, maximum: 280))]
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
                        Text("Cast").tag(0)
                        Text("similar").tag(1)
                        Text("reviews").tag(2)
                    })
                    .pickerStyle(SegmentedPickerStyle()) // <1>
                    .padding()
                    
                    VStack{
                    switch selectedColorIndex{
                    case 0:
                        CastListItemView(movie: movie)
                    case 1:
                        SimilarMovieView(movie: movie)
                    case 2:
                        ReviewsView(movie:  movie)
                    default:
                        ReviewsView(movie:  movie)
                    }
                    }
                }
            }
        }
    
        
    }
    
}

struct MovieDetailView_Previews: PreviewProvider {
    @StateObject static  var movieBookmarkViewModel = MovieBookmarkViewModel()
    static var previews: some View {
        MovieDetailView(movie: .stubbedMovies[0])
            .environmentObject(movieBookmarkViewModel)
    }
}


struct SimilarMovieView:View{
    let movie:Movie
    
    var body: some View{
        LazyVGrid(columns:
                UIDevice.current.userInterfaceIdiom != .pad ?
                  [GridItem(.adaptive(minimum: 120, maximum: 260))]: [GridItem(.adaptive(minimum: 200, maximum: 360))]
                  ,spacing: 20){
                            ForEach(0 ..< 10) { item in
                               CustomCardView(movie: movie)
                      
                        }
                    
                    }
        .padding()
    }
}

// cast view
struct CastListItemView: View {
    let movie:Movie
    var body: some View {

        
        LazyVGrid(columns: UIDevice.current.userInterfaceIdiom != .pad ?
                  [GridItem(.adaptive(minimum: 120, maximum: 260))]: [GridItem(.adaptive(minimum: 200, maximum: 360))],spacing: 20){
                            ForEach(0 ..< 10) { item in
                                AsyncImageView(imageUrl: movie.posterURL)
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .padding()
                      
                        }
                    }

        }
    }


struct ReviewsView: View {
    var movie:Movie
    var body: some View {
        ForEach(0 ..< 5) { item in
            HStack(alignment:.center,spacing: 0){
                AsyncImageView(imageUrl: movie.posterURL)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(height: 80, alignment: .leading)
                    .padding()
                VStack(alignment: .leading,spacing:0){
                    HStack {
                        Text("John Chard")
                        Text(movie.releaseDate ?? "")
                            .foregroundColor(Color.secondary)
                        
                    }
                    Text("(As I'm writing this review, Darth Vader's theme music begins to build in my mind...)Well, it actually has a title, what the Darth Vader theme. And that title is \"The Imperial March\", composed by the great John ")
                        .lineLimit(4)
                        .foregroundColor(Color.secondary)
                        .padding(4)
                }
                Spacer()
            }
            
            
            .padding()
        }
    }
}
