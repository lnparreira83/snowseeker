//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Lucas Parreira on 24/05/21.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var favorites: Favorites
    @State private var selectedFacility: Facility?
    
    let resort: Resort
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 0){
                ZStack{
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    HStack{
                        Text("Credit: ").foregroundColor(.red)
                        Text(resort.imageCredit).foregroundColor(.red)
                            
                    }.offset(x:280,y:160)
                    
                }
                
                
                Group {
                    HStack{
                        if sizeClass == .compact {
                            Spacer()
                            VStack { ResortDetailView(resort: resort)}
                            VStack { SkiDetailsView(resort: resort)}
                            Spacer()
                        } else {
                            ResortDetailView(resort: resort)
                            Spacer().frame(height:0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
//                    Text(ListFormatter.localizedString(byJoining: resort.facilities))
//                        .padding(.vertical)
                    HStack{
                        ForEach(resort.facilityTypes){facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
            Button(favorites.contains(resort) ? "Remove from favorites" : "Add to favorites"){
                if self.favorites.contains(self.resort) {
                       self.favorites.remove(self.resort)
                   } else {
                       self.favorites.add(self.resort)
                   }
               }
               .padding()
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
    }
    
}

extension String: Identifiable {
    public var id: String { self }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
