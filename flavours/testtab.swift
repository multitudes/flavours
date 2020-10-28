//
//  testtab.swift
//  flavours
//
//  Created by Laurent B on 28/10/2020.
//

import SwiftUI


struct testtab: View {
	@State var numberOfPages: Int = 0

		var body: some View {
			VStack {
				Text("Tap Me").onTapGesture(count: 1, perform: {
					self.numberOfPages = [2,5,10,15].randomElement()!
				})
				if self.numberOfPages != 0 {
					TabView {
						ForEach(0..<numberOfPages, id: \.self) { index in
							Text("\(index)").frame(width: 300).background(Color.red)
						}
					}
					.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
					.frame(height: 300)
					.id(numberOfPages)
					
				}
			}.background(Color.blue)
		}
}
struct testtab_Previews: PreviewProvider {
    static var previews: some View {
        testtab()
    }
}
