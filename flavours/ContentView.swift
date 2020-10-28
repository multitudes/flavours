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


		var berry = Node(flavor: Flavor(name: "Berry"))
		var driedFruit = Node(flavor: Flavor(name: "Dried Fruit"))

		var blackberry = Node(flavor: Flavor(name: "Blackberry"))
		var raspberry = Node(flavor: Flavor(name: "Raspberry"))
		var blueberry = Node(flavor: Flavor(name: "Blueberry"))
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
}

struct ContentView: View {
	var flavorWheel: FlavorWheel = FlavorWheel()
	@State private var currentIndexRoot = 0
	@State private var currentIndexBranch = 0
	@State private var currentIndexLeaf = 0

	private var wheel: [Node<Flavor>] {
		flavorWheel.root.children
	}
	//= ["Fruity"]
	private var middleFlavoursArray: [Node<Flavor>] {
		print(currentIndexRoot)
		print(flavorWheel.root.children)
		return flavorWheel.root.children[currentIndexRoot].children
	}

	//private var middleFlavoursArray: [String] = ["Berry","Dried Fruit"]
	private var leafArray: [String] = ["Blackberry","Raspberry","Blueberry","Strawberry","Raisin", "Prune"]

	var body: some View {
		NavigationView {
			VStack {
				TabView(selection: $currentIndexRoot)  {
					ForEach(wheel.indices) { index in
						ZStack(alignment: .bottom) {
							VStack {
								//Spacer()
								Color(wheel[index].flavor.name)
							}
							Text(wheel[index].flavor.name)
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
							}
							Text(middleFlavoursArray[index].flavor.name)
								.padding()
								.background(Color(.tertiarySystemBackground))
								.clipShape(Capsule())
								.padding(60)
						}.tag(index)

					}
				}.tabViewStyle(PageTabViewStyle())
				.clipShape(RoundedRectangle(cornerRadius: 25.0))



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

			}.padding(.init(top: 0, leading: 18, bottom: 18, trailing: 18))
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
