//
//  ContentView.swift
//  flavours
//
//  Created by Laurent B on 25/10/2020.
//

import SwiftUI

struct Flavor: Codable, Hashable, Equatable, Identifiable {
	var id = UUID()
	var name: String
	var description: String = ""
	var image: String = ""


}
extension Flavor {
	init(name: String, description: String) {
		self.name = name
		self.description = description
	}
}

struct Node<Flavor> {
	static func == (lhs: Node<Flavor>, rhs: Node<Flavor>) -> Bool {
		lhs.id == rhs.id
	}

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
//extension Node: Equatable where Flavor: Equatable { }
//extension Node: Hashable where Flavor: Hashable { }


class FlavorWheel: ObservableObject {
	private(set) var root: Node<Flavor>
	init() {
		root = Node(flavor: Flavor(name: "startNode"))
		var fruity = Node(flavor: Flavor(name: "Fruity"))

		var berry = Node(flavor: Flavor(name: "Berry"))
		var driedFruit = Node(flavor: Flavor(name: "Dried Fruit"))

		var blackberry = Node(flavor: Flavor(name: "Blackberry",
											 description: "The sweet, dark, fruity, floral, slightly sour, somewhat woody aromatic associated with blackberries."))
		var raspberry = Node(flavor: Flavor(name: "Raspberry",description: "The slightly dark, fruity, sweet, slightly sour, musty, dusty, floral aromatic associated with raspberry."))
		var blueberry = Node(flavor: Flavor(name: "Blueberry",
											description: "The slightly dark, fruity, sweet, slightly sour, musty, dusty, floral aromatic associated with blueberry."))
		var strawberry = Node(flavor: Flavor(name: "Strawberry"))
		var raisin = Node(flavor: Flavor(name: "Raisin"))
		var prune = Node(flavor: Flavor(name: "Prune"))
		berry.add(child: blackberry)
		berry.add(child: raspberry)
		berry.add(child: blueberry)
		berry.add(child: strawberry)
		driedFruit.add(child: raisin)
		driedFruit.add(child: prune)
		fruity.add(child: berry)
		fruity.add(child: driedFruit)
		root.add(child: fruity)
	}
	var wheel: [Node<Flavor>] {
		self.root.children
	}

	func update() {
		objectWillChange.send()
	}
}

struct ContentView: View {
	@ObservedObject var flavorWheel: FlavorWheel = FlavorWheel()
	@State private var currentIndexRoot = 0
	@State private var currentIndexBranch = 0
	@State private var currentIndexLeaf = 0

	@State private var showDescription = false

	private var middleFlavoursArray: [Node<Flavor>] {
	//	print(currentIndexRoot)
		//print(flavorWheel.root.children)
		return flavorWheel.root.children[currentIndexRoot].children
	}

	//private var middleFlavoursArray: [String] = ["Berry","Dried Fruit"]
	private var leafArray: [Node<Flavor>] {
		return flavorWheel.root.children[currentIndexRoot].children[currentIndexBranch].children
	}
	//["Blackberry","Raspberry","Blueberry","Strawberry","Raisin", "Prune"]

	var body: some View {

		//NavigationView {
			//ScrollView {

				VStack {
					Spacer()
					Text("Coffee Flavor Wheel").font(.largeTitle).minimumScaleFactor(0.5)
					TabView(selection: $currentIndexRoot)  {
						ForEach(flavorWheel.wheel.indices) { index in
							ZStack(alignment: .bottom) {
								VStack {
									//Spacer()
									Color(flavorWheel.wheel[index].flavor.name)
								}
								Text(flavorWheel.wheel[index].flavor.name)
									.padding()
									.background(Color(.tertiarySystemBackground))
									.clipShape(Capsule())
									.padding(60)
							}.tag(index)
						}
					}.tabViewStyle(PageTabViewStyle())
					.clipShape(RoundedRectangle(cornerRadius: 25.0))

					TabView(selection: $currentIndexBranch) {
						ForEach(middleFlavoursArray.indices) { index in
							ZStack(alignment: .bottom) {
								VStack {
									//Spacer()
									Color(middleFlavoursArray[index].flavor.name)
									//Text(index.description)
								}
								Text(middleFlavoursArray[index].flavor.name)
									.padding()
									.background(Color(.tertiarySystemBackground))
									.clipShape(Capsule())
									.padding(60)
							}.tag(index)
						}
					}
					.id(Int.random(in: 0..<Int.max))
					.tabViewStyle(PageTabViewStyle())
					.clipShape(RoundedRectangle(cornerRadius: 25.0))

					TabView(selection: $currentIndexLeaf) {
						ForEach(leafArray.indices) { index in
							ZStack(alignment: .bottom) {
								Color(leafArray[index].flavor.name)
								Text(leafArray[index].flavor.name)
									.padding()
									.background(Color(.tertiarySystemBackground))
									.clipShape(Capsule())
									.padding(60)
							}
							.tag(index)
							.onTapGesture {
								showDescription = true
							}
							.sheet(isPresented: $showDescription) {
								ZStack(alignment: .center) {
									Color(leafArray[index].flavor.name)
									VStack {
										Text(leafArray[index].flavor.name)
											.font(.largeTitle)
											.padding()
											.background(Color(.tertiarySystemBackground))
											.clipShape(Capsule())
											.padding(60)
										Text(leafArray[index].flavor.description)
											.foregroundColor(.white)
											.font(.body)
											.padding(60)
										if leafArray[index].flavor.name == "Blueberry" {
											Image("blueberry").resizable().frame(maxWidth: .infinity, alignment: .center)
											//Text("🫐").font(.largeTitle)
										} else { EmptyView()}

									}
								}.ignoresSafeArea(edges: .bottom)
							}
						}
					}
					.id(Int.random(in: 0..<Int.max))
					.tabViewStyle(PageTabViewStyle())
					.clipShape(RoundedRectangle(cornerRadius: 25.0))
//					.onAppear() {
//						print(leafArray.debugDescription)
//					}
				}.padding(.init(top: 0, leading: 18, bottom: 18, trailing: 18))

				//.navigationTitle(Text("The Flavor Wheel"))
			//}
		//}

		//.edgesIgnoringSafeArea(.bottom)

	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
