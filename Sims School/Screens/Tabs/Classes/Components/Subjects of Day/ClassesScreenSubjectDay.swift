//
//  ClassesScreenSubjectDay.swift
//  Sims School
//
//  Created by João Damazio on 17/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct ClassesScreenSubjectDay: View {
	@Binding var modalVisible: Bool

	var body: some View {
		ZStack {
			GeometryReader { geometry in
				VStack(spacing: 5) {
					HStack {
						Text("15, Jun")
							.font(.system(size: 22, weight: .bold))
						Spacer()
						Button(action: {
							self.modalVisible.toggle()
						}) {
							Image(systemName: "xmark.circle")
								.resizable()
								.frame(width: 25, height: 25, alignment: .center)
						}
					}
					VStack(spacing: 2) {
						HStack(alignment: .firstTextBaseline, spacing: 20) {
							VStack {
								Image(systemName: "studentdesk")
									.resizable()
									.frame(width: 25, height: 25, alignment: .center)
									.padding(.bottom, -15)
							}
							VStack(alignment: .leading, spacing: 5) {
								Text("Gestão de projeto - Agile")
									.font(.system(size: 16, weight: .semibold))
								Text("Renato silva de lima")
									.font(.system(size: 14, weight: .semibold))
							}
							Spacer()
						}
						HStack(alignment: .firstTextBaseline, spacing: 20) {
							Rectangle()
								.fill(Color.black)
								.frame(width: 2, height: 50)
								.padding(.leading, 10)
							Spacer()
						}
						HStack(alignment: .firstTextBaseline, spacing: 20) {
							VStack {
								Image(systemName: "paperplane")
									.resizable()
									.frame(width: 25, height: 25, alignment: .center)
									.padding(.bottom, -15)
							}
							VStack(alignment: .leading, spacing: 5) {
								Text("Trabalho de agile")
									.font(.system(size: 16, weight: .semibold))
								Text("Grupo de 2 até 4 pessoas")
									.font(.system(size: 14, weight: .semibold))
							}
							Spacer()
						}
						HStack(alignment: .firstTextBaseline, spacing: 20) {
							Rectangle()
								.fill(Color.black)
								.frame(width: 2, height: 50)
								.padding(.leading, 10)
							Spacer()
						}
						HStack(alignment: .firstTextBaseline, spacing: 20) {
							VStack {
								Image(systemName: "paperclip")
									.resizable()
									.frame(width: 25, height: 25, alignment: .center)
									.padding(.bottom, -15)
							}
							VStack(alignment: .leading, spacing: 5) {
								Text("Prova de agile")
									.font(.system(size: 16, weight: .semibold))
								Text("Individual")
									.font(.system(size: 14, weight: .semibold))
							}
							Spacer()
						}
					}
					.padding()
				}
				.padding()
				.frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
			}
		}
	}
}

struct ClassesScreenSubjectDay_Previews: PreviewProvider {
	@State static var modalVisible: Bool = true

	static var previews: some View {
		ClassesScreenSubjectDay(modalVisible: $modalVisible)
	}
}
