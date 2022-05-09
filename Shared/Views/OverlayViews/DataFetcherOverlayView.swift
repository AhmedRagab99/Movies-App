//
//  DataFetcherOverlayView.swift
//  MoviesApp 
//
//  Created by Ahmed Ragab on 09/05/2022.
//

import SwiftUI

protocol EmptyData{
    var isEmpty:Bool{get}
}

struct DataFetcherOverlayView<V:EmptyData>: View {
    let phase:DataFetchPhase<V>
    let retryAction:()->()
    var body: some View {
        switch phase{
        case .empty:
            ProgressView()
        case .success(let value) where value.isEmpty:
            EmptyPlaceholderView(text: "No Data", image: Image(systemName: "film"))
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: retryAction)
        default:
            EmptyView()
        }
    }
}
extension Array:EmptyData{}
extension Optional:EmptyData{
    var isEmpty: Bool{
        if case .none = self {
            return true
        }
        return false
    }
}

struct DataFetcherOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
        DataFetcherOverlayView(phase: .success([])){
            print("retry")
        }
            
            DataFetcherOverlayView<[Movie]>(phase: .empty){
                print("retry")
            }
            
            DataFetcherOverlayView<Movie?>(phase: .failure(MoviesAppError.serializationError)){
                print("retry")
            }
        }
    }
}
