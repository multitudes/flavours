//
//  testtab.swift
//  flavours
//
//  Created by Laurent B on 28/10/2020.
//

import SwiftUI

struct CircleView:View {
	@State var label:String
	var body:some View {
		ZStack{
			Circle()
				.fill(Color.yellow)
				.frame(width: 70, height: 70)
			Text(label)
		}
	}
}
struct testtab: View {
	var body: some View {

		VStack{
			Divider()
			ScrollView(.horizontal){
				HStack{
					ForEach(0..<10){
						index in
						CircleView(label: "\(index)")
					}
				}.padding()
			}.frame(height:100)
			Divider()
			Spacer()
		}

	}
}
struct testtab_Previews: PreviewProvider {
    static var previews: some View {
        testtab()
    }
}
