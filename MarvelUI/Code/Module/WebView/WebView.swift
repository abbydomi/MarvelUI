//
//  WebView.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 6/6/24.
//

import SwiftUI
import WebKit

struct WebView: View {
    @EnvironmentObject var router: Router
    
    let url: URL
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack {
                WebViewRepresentable(url: url)
                Button {
                    router.goBack()
                } label: {
                    Text("Go back")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .clipShape(.capsule)
                        .padding(.horizontal)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    WebView(url: URL(string: "https://google.com")!)
}

struct WebViewRepresentable: UIViewRepresentable {
    
    let webView: WKWebView
    let url: URL
    
    init(url: URL) {
        webView = WKWebView(frame: .zero)
        self.url = url
    }
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
}
