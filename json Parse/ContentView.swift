//
//  ContentView.swift
//  json Parse
//
//  Created by 野澤拓己 on 2020/08/28.
//  Copyright © 2020 Takumi Nozawa. All rights reserved.
//

import SwiftUI
import  SDWebImageSwiftUI

struct ContentView: View {
    
    @ObservedObject var getData = Datas()

    var body: some View {
        
        NavigationView {
            
            List(getData.jsonData) { i in
                
                ListRow(url: i.avatar_url, name: i.login)
                
            }.navigationBarTitle("Json Parsing")
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class Datas: ObservableObject {
    
    @Published var jsonData = [dataType]()
    
    init() {
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: "https://api.github.com/users/hadley/orgs")!) { (data, _, _) in
            
            
            do {
                
                let fetch = try JSONDecoder().decode([dataType].self, from: data!)
                
                DispatchQueue.main.async {
                    
                    self.jsonData = fetch
                    
                }
                
            }
            catch {
                
                print(error.localizedDescription)
                
            }
            
        }.resume()
        
        
    }
}

struct dataType: Identifiable, Decodable {
    
    var id: Int
    var login: String
    var node_id: String
    var avatar_url: String
    
    // I'm going to use only four attributes from json data
}


struct ListRow: View {
    
    var url: String
    var name: String
    
    var body: some View {
        
        HStack {
            
            AnimatedImage(url: URL(string: url)).resizable().frame(width: 60, height: 60).clipShape(Circle()).shadow(radius: 20)
            
            Text(name).fontWeight(.heavy).padding(.leading, 10)
            
        }
        
        
        
    }
    
}


// I'm going to add sdweb image package bcz I'm going to download image from json data.....


