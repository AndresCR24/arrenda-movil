//
//  VerPerfilView.swift
//  ArrendamientoSantaFe
//
//  Created by Andres David Cardenas Ramirez on 26/10/23.
//

import SwiftUI

struct VerPerfilView: View
{
    var body: some View
    {
        NavigationView {
            ZStack
            {
                Spacer()
                Color(red: 19/255, green: 30/255, blue: 53/255, opacity:1.0).ignoresSafeArea()
                VStack{
                    
                    Image("logosantafe").resizable().aspectRatio(contentMode: .fit).frame(width:300).padding(.bottom, 50)
                    
                }
        }.navigationBarHidden(true)
        }
    }
        
}


#Preview {
    VerPerfilView()
}
