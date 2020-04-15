//
//  ContentView.swift
//  PhotoCode
//
//  Created by Daniel Khromov on 4/15/20.
//  Copyright © 2020 Daniel Khromov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
        Spacer(minLength: 40)
        Text("P H O T O C O D E")
        .bold()
            .font(.title)
            
            
            HStack{
            ZStack{
        RoundedRectangle(cornerRadius: 23)
            .foregroundColor(Color("violet"))
            .frame(width: 150, height: 150)
            .padding()
                VStack{
            Image(systemName: "person.circle.fill")
                .foregroundColor(.white)
                .font(.title)
            Text("Account")
                    .foregroundColor(.white)
                    .font(.title)
                    
                }
            }
            ZStack{
            RoundedRectangle(cornerRadius: 23)
                .foregroundColor(Color("green"))
                .frame(width: 150, height: 150)
                .padding()
            VStack{
            Image(systemName: "camera.fill")
                .foregroundColor(.white)
                .font(.title)
            Text("Camera")
                    .foregroundColor(.white)
                    .font(.title)
                    
                }
            }
        }
            ZStack
                {
                RoundedRectangle(cornerRadius: 23)
                           .foregroundColor(Color("yellow"))
                           .frame(width: 350, height: 150)
                           .padding()
                HStack{
                Image(systemName: "photo.fill.on.rectangle.fill")
                    .foregroundColor(.white)
                    .font(.title)
                Text("From library")
                        .foregroundColor(.white)
                        .font(.title)
                        
                    }
            }
            HStack{
                VStack {
                    ZStack{
                    RoundedRectangle(cornerRadius: 23)
                               .foregroundColor(Color("red"))
                               .frame(width: 150, height: 230)
                               .padding()
                    VStack{
                    Text("GO")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                    Text("to your \n codes")
                            .foregroundColor(.white)
                            .font(.title)
                            
                        }
                    }
                    Spacer()
                }
                VStack{
                ZStack{
                 RoundedRectangle(cornerRadius: 23)
                      .foregroundColor(Color("blue"))
                       .frame(width: 150, height: 110)
                       .padding()
                    VStack{
                    Text("12")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                    Text("Scanned")
                            .foregroundColor(.white)
                            .font(.title)
                            
                        }
                }
                Spacer()
                    
                }
            }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
