//
//  ContentView.swift
//  CoolBeans
//
//  Created by Codebucket on 21/09/22.
//

//Tutorial link: https://www.youtube.com/watch?v=tSwDfV6D_70

import SwiftUI

struct ContentView: View {
    @StateObject var menu = Menu()
    @StateObject var history = History()
    @State private var showingAddScree = false
    
    var totalCaffeine: Int{
        history.servings.map(\.caffeine).reduce(0, +)
    }
    
    var totalCalories: Int{
        history.servings.map(\.calories).reduce(0, +)
    }
    
    var body: some View {
        NavigationView{
            List{
                if history.servings.isEmpty{
                    Button("Add your first drink") {
                        showingAddScree = true
                    }
                } else {
                    Section("Summary"){
                        Text("Caffeine: \(totalCaffeine)mg")
                        Text("Calories: \(totalCalories)")
                    }
                    
                    ForEach(history.servings){serving in
                        HStack{
                            VStack(alignment: .leading){
                                Text(serving.name)
                                    .font(.headline)
                                
                                Text(serving.description)
                                    .font(.caption)
                            }
                            
                            Spacer()
                            
                            Text("\(serving.caffeine)mg")
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    history.delete(serving)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                            Button {
                                withAnimation {
                                    history.reorder(serving)
                                }
                            } label: {
                                Label("Repeat", systemImage: "repeat")
                            }
                            .tint(.blue)


                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddScree, content: MenuView.init)
            .navigationTitle("Cool Beans")
            .toolbar{
                Button {
                    showingAddScree = true
                } label: {
                    Label("Add New Drink", systemImage: "plus")
                }

            }
        }
            .environmentObject(menu)
            .environmentObject(history)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
