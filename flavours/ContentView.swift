//
//  ContentView.swift
//  flavours
//
//  Created by Laurent B on 25/10/2020.
//

import SwiftUI

struct Flavor: Identifiable, Codable {
	var id: UUID = UUID()

	var name: String
	var description: String = ""
	var image: String = ""
}

struct Node<Flavor> {
	var flavor: Flavor
	private(set) var children: [Node]

	init(flavor: Flavor) {
		self.flavor = flavor
		children = []
	}
	init(flavor: Flavor, children: [Node]) {
		self.flavor = flavor
		self.children = children
	}
	mutating func add(child: Node) {
		children.append(child)
	}
}



class FlavorWheel: ObservableObject {
	init() {
		var root = Node(flavor: Flavor(name: "startNode"))
		var fruity = Node(flavor: Flavor(name: "Fruity"))
		root.add(child: fruity)

		var berry = Node(flavor: Flavor(name: "Berry"))
		var driedFruit = Node(flavor: Flavor(name: "driedFruit"))
		fruity.add(child: berry)
		fruity.add(child: driedFruit)
		var blackberry = Node(flavor: Flavor(name: "Blackberry"))
		var raspberry = Node(flavor: Flavor(name: "Raspberry"))
		var blueberry = Node(flavor: Flavor(name: "Blueberry"))
		var strawberry = Node(flavor: Flavor(name: "Strawberry"))
		berry.add(child: blackberry)
		berry.add(child: raspberry)
		berry.add(child: blueberry)
		berry.add(child: strawberry)


	}
}

struct ContentView: View {
	private var wheel: [String] = ["Fruity"]
	private var flavoursArray: [String] = ["Berry","Dried Fruit"]
	private var leafArray: [String] = ["Blackberry","Raspberry","Blueberry","Strawberry","Raisin", "Prune"]




    var body: some View {
		VStack {
			TabView {
				ForEach(wheel, id:\.self) { wheel in
					GeometryReader { geo in
						ZStack(alignment: .bottom) {
							VStack {
								//Spacer()
								Color(wheel)
							}
							Text(wheel)
								.padding()
								.background(Color(.tertiarySystemBackground))
								.clipShape(Capsule())
								.padding(60)
						}
					}
				}
			}.tabViewStyle(PageTabViewStyle())
			.clipShape(RoundedRectangle(cornerRadius: 25.0))
		   .padding()
			TabView {
				ForEach(flavoursArray, id:\.self) { flavor in
					GeometryReader { geo in
						ZStack(alignment: .bottom) {
							VStack {
								//Spacer()
								Color(flavor)
							}
							Text(flavor)
								.padding()

								.background(Color(.tertiarySystemBackground))
								.clipShape(Capsule())
								.padding(60)

						}
					}
				}
			}.tabViewStyle(PageTabViewStyle())
			.clipShape(RoundedRectangle(cornerRadius: 25.0))
		   .padding()
			TabView {
			  ForEach(leafArray, id: \.self) { flav in
				  GeometryReader { geo in
					  ZStack(alignment: .bottom) {
						  VStack {
							  //Spacer()
							  Color(flav)
						  }
						  Text(flav)
							  .padding()

							  .background(Color(.tertiarySystemBackground))
							  .clipShape(Capsule())
							  .padding(60)

					  }
				  }

			  }
		  }
		  .tabViewStyle(PageTabViewStyle())
		  .clipShape(RoundedRectangle(cornerRadius: 25.0))
			.padding()
		}
		//.edgesIgnoringSafeArea(.all)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
