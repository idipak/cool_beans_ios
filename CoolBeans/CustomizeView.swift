//
//  CustomizeView.swift
//  CoolBeans
//
//  Created by Codebucket on 21/09/22.
//

import SwiftUI

struct CustomizeView: View {
    let drink: Drink
    
    @EnvironmentObject var menu: Menu
    @EnvironmentObject var history: History
    
    @State private var size = 0
    @State private var isDecafe = false
    @State private var extraShots = 0
    @State private var milk = ConfigurationOption.none
    @State private var syrup = ConfigurationOption.none
    
    let sizeOption = ["Small", "Medium", "Large"]
    
    var caffein: Int {
        var caffeineAmount = drink.caffeine[size]
        caffeineAmount += (extraShots * 60)
        
        if isDecafe{
            caffeineAmount /= 20
        }
        
        return caffeineAmount
    }
    
    var calories: Int{
        var calorieAmount = drink.baseCalories
        calorieAmount += extraShots * 10
        
        if drink.coffeeBased{
            calorieAmount += milk.calories
        } else {
            calorieAmount += milk.calories / 8
        }
        calorieAmount += syrup.calories
        return calorieAmount * (size + 1)
    }
    
    var body: some View {
        Form{
            Section("Basic Options"){
                Picker("Size", selection: $size){
                    ForEach(sizeOption.indices){index in
                        Text(sizeOption[index])
                    }
                }
                .pickerStyle(.segmented)
                
                if drink.coffeeBased{
                    Stepper("Extra shots: \(extraShots)", value: $extraShots, in: 0...8)
                }
                
                Toggle("Decafenated", isOn: $isDecafe)
            }
            
            Section("Customization"){
                Picker("Milk", selection: $milk) {
                    ForEach(menu.milkOptions) { option in
                        Text(option.name)
                            .tag(option)
                    }
                }
                
                if drink.coffeeBased {
                    Picker("Syrup", selection: $syrup) {
                        ForEach(menu.syrupOptions) { option in
                            Text(option.name)
                                .tag(option)
                        }
                    }
                }
            }
            
            
            
            Section("Estimate"){
                Text("**Caffein** \(caffein)mg")
                Text("**Calories** \(calories)")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(drink.name)
        .toolbar{
            Button("Save"){
                history.add(drink, size: sizeOption[size], extraShots: extraShots, isDecafe: isDecafe, milk: milk, syrup: syrup, caffeine: caffein, calories: calories)
            }
        }
    }
}

struct CustomizeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeView(drink: Drink.example)
            .environmentObject(Menu())
            .environmentObject(History())
    }
}
