//
//  ContentView.swift
//  ExampleNetwrokingApp
//
//  Created by Carson_Nov_2025 on 2/5/26.
//

import SwiftUI

struct ContentView: View {
    @State private var uiImage1: UIImage?
    @State private var uiImage2: UIImage?
    @State private var uiImage3: UIImage?
    @State private var description: String = ""
    
    var body: some View {
        VStack {
            Text("Image Loader")
                .font(.title)
            
            TextField("Describe your image in one word", text: $description)
                .textFieldStyle(.roundedBorder)
            
            Button("Fetch") {
                // TODO: call some fetchImage method
                Task {
                    let (uiImage1, uiImage2, uiImage3) = await fetchThreeImages()
                    self.uiImage1 = UIImage(data: uiImage1)
                    self.uiImage2 = UIImage(data: uiImage2)
                    self.uiImage3 = UIImage(data: uiImage3)
                }
            }
            .buttonStyle(.borderedProminent)
            
            if let uiImage1 {
                Image(uiImage: uiImage1)
            }
            
            if let uiImage2 {
                Image(uiImage: uiImage2)
            }
            
            if let uiImage3 {
                Image(uiImage: uiImage3)
            }
        }
        .padding()
        
        Spacer()
    }
    
    private func fetchImage() async -> Data?{
        let url = URL(string: "https://robohash.org/\(description)")!
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return data
        } catch {
            print("Network request failed")
            return nil
        }
                      
    }
    
    private func fetchThreeImages() async -> (Data, Data, Data) {
        let url = URL(string: "https://robohash.org/\(description)")!
        let request = URLRequest(url: url)
        
        async let (data1, _) = try! await URLSession.shared.data(for: request)
        async let (data2, _) = try! await URLSession.shared.data(for: request)
        async let (data3, _) = try! await URLSession.shared.data(for: request)
        
        return await (data1, data2, data3)
    }
        
}

#Preview {
    ContentView()
}
