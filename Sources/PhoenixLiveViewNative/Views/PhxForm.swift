//
//  PhxForm.swift
//  PhoenixLiveViewNative
//
//  Created by Shadowfacts on 2/9/22.
//

import SwiftUI
import SwiftSoup

struct PhxForm<R: CustomRegistry>: View {
    private let element: Element
    private let context: LiveContext<R>
    private let id: String
    
    @EnvironmentObject private var liveViewModel: LiveViewModel<R>
    
    private var model: FormModel<R> {
        liveViewModel.getForm(elementID: id)
    }
    
    init(element: Element, context: LiveContext<R>) {
        precondition(element.hasAttr("id"), "<form> must have an id")
        self.element = element
        self.context = context
        self.id = try! element.attr("id")
    }
    
    var body: some View {
        context.with(formModel: model).buildChildren(of: element)
            .onChange(of: element, perform: { newValue in
                model.updateFromElement(newValue)
            })
            .onAppear {
                model.coordinator = context.coordinator
                model.changeEvent = element.attrIfPresent("phx-change")
                model.updateFromElement(element)
            }
    }
    
}