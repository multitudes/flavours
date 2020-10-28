//
//  ContentView.swift
//  flavours
//
//  Created by Laurent B on 25/10/2020.
//

import SwiftUI

struct Flavor: Identifiable, Codable, Hashable {
	var id: String = UUID().uuidString

	var name: String
	var description: String = ""
	var image: String = ""
}

struct Node<Flavor>: Identifiable {
	var id = UUID()
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
extension Node: Equatable where Flavor: Equatable { }
extension Node: Hashable where Flavor: Hashable { }


struct FlavorWheel {
	private(set) var root: Node<Flavor>
	init() {
		root = Node(flavor: Flavor(name: "startNode"))
		var fruity = Node(flavor: Flavor(name: "Fruity"))
		root.add(child: fruity)

		var berry = Node(flavor: Flavor(name: "Berry"))
		let driedFruit = Node(flavor: Flavor(name: "driedFruit"))
		fruity.add(child: berry)
		fruity.add(child: driedFruit)
		let blackberry = Node(flavor: Flavor(name: "Blackberry"))
		let raspberry = Node(flavor: Flavor(name: "Raspberry"))
		let blueberry = Node(flavor: Flavor(name: "Blueberry"))
		let strawberry = Node(flavor: Flavor(name: "Strawberry"))
		berry.add(child: blackberry)
		berry.add(child: raspberry)
		berry.add(child: blueberry)
		berry.add(child: strawberry)


	}
}

struct ContentView: View {
	 var flavorWheel: FlavorWheel = FlavorWheel()


	private var wheel: [Node<Flavor>] {
		flavorWheel.root.children
	}
		//= ["Fruity"]
	private var flavoursArray: [String] = ["Berry","Dried Fruit"]
	private var leafArray: [String] = ["Blackberry","Raspberry","Blueberry","Strawberry","Raisin", "Prune"]

	var body: some View {
		NavigationView {
		  VStack {
			  TabView {
				ForEach(wheel) { flav in
					  GeometryReader { geo in
						  ZStack(alignment: .bottom) {
							  VStack {
								  //Spacer()
								Color(flav.flavor.name)
							  }
							Text(flav.flavor.name)
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
		.navigationTitle(Text("The Flavor Wheel"))
		}

		//.edgesIgnoringSafeArea(.all)

	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
