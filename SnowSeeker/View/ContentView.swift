//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Lucas Parreira on 24/05/21.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @ObservedObject var favorites = Favorites()
    
    var body: some View {
        NavigationView{
            
            List(resorts) { resort in
                
                NavigationLink(destination: ResortView(resort: resort)){
                    
                    Image(resort.country)
                        .resizable()
                        .scaledToFit()
                        .frame(width:40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 1))
                    
                    VStack(alignment: .leading){
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort){
                        Spacer()
                            Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                                .foregroundColor(.red)
                        }
                }
            }
            .navigationBarTitle("Resorts")
            
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
