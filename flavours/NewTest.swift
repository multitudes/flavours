//
//  NewTest.swift
//  flavours
//
//  Created by Laurent B on 28/10/2020.
//

import SwiftUI


struct NewTest: View {
	var body: some View {
		VStack {
			Color("Blueberry")
				.frame(height: 300)
				.ignoresSafeArea(edges: .top)
			Text("Blueberry")
				.font(.largeTitle)
				.padding()
				.background(Color(.tertiarySystemBackground))
				.clipShape(Capsule())
				.overlay(Capsule().stroke(Color.white, lineWidth: 4))
				.shadow(radius: 10)
				//.padding(60)
				.offset(y: -90)
				 .padding(.bottom, -130)
			  Spacer()
//			Text("Blueberry")
//				.foregroundColor(.white)
//				.font(.title)
//				.padding(60)
//			if leafArray[index].flavor.name == "Blueberry" {
//				Image("blueberry").resizable().frame(maxWidth: .infinity, alignment: .center)
//				//Text("🫐").font(.largeTitle)
//			} else { EmptyView()}

		}
		//}.ignoresSafeArea(edges: .bottom)
	}
}

struct NewTest_Previews: PreviewProvider {
	static var previews: some View {
		NewTest()
	}
}
