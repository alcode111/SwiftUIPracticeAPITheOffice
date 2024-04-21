//
//  QuoteView.swift
//  SwiftUIPracticeAPITheOffice
//
//  Created by Ismaïl LP on 21/04/2024.
//

import SwiftUI

struct QuoteView: View {
    
    @StateObject var vm = ViewModel(controller: FetchController())
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Image("the-office")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: geo.size.width * 2.7,
                        height: geo.size.height * 1.34)
                
                    VStack {
                        VStack {
                            Spacer(minLength: 140)
                            
                            ScrollView {
                                switch vm.status {
                                case .success(let data):
                                    ZStack(alignment: .bottom) {
                                        AsyncImage(url: data.characterAvatarUrl) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        
                                        Text(data.character)
                                            .foregroundStyle(.white)
                                            .fontWeight(.bold)
                                            .padding(10)
                                            .frame(maxWidth: .infinity)
                                            .background(.ultraThinMaterial)
                                    }
                                    .frame(
                                        width: geo.size.width / 1.1,
                                        height: geo.size.height / 1.8)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    
                                    Text(data.quote)
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(.white)
                                        .padding()
                                        .background(.black.opacity(0.5))
                                        .cornerRadius(25)
                                        .padding(.horizontal)
                                    
                                case .fetching:
                                    ProgressView()
                                    
                                default:
                                    EmptyView()
                                }
                            }
                            .padding(.top, 60)
                        }
                        
                        Spacer()
                        
                        Button {
                            print("Button tapped")
                            Task {
                                await vm.getData()
                            }
                        } label: {
                            Text("Get Random Quote")
                                .font(.title)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black)
                                .fontWeight(.semibold)
                                .clipShape(.rect(cornerRadius: 8))
                        }
                        
                        Spacer(minLength: 180)

                    }
                    .frame(width: geo.size.width)

            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    QuoteView()
}
