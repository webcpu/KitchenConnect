//
//  RemoteControlView.swift
//  KitchenConnect
//
//  Created by liang on 01/04/2023.
//

import SwiftUI

struct RemoteControlView: View {
    var appliance: Appliance

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .accessibility(identifier: "remote-control-appliance-\(appliance.applianceId)")
    }
}

//struct RemoteControlView_Previews: PreviewProvider {
//    static var previews: some View {
//        RemoteControlView(appliance: Appliance())
//    }
//}
