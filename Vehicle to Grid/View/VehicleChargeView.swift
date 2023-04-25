//
//  VehicleChargeView.swift
//  Vehicle to Grid
//
//  Created by Julia Brixey on 4/15/23.
//

import SwiftUI

struct VehicleChargeView: View {
    @State private var kafkaMessage: String = ""
    private let kafkaClient: KafkaClient = MockKafkaClient()
    @StateObject var viewModel = UserAccountViewModel()
    @State var vehicleCharge: Float

        var body: some View {
            ZStack{
                Color("Primary Black").ignoresSafeArea() // sets background color, zstack allows for it to be under fields
                VStack {
                    HStack{
                        Text("Current Vehicle Charge")
                            .font(.custom("overpass-semibold", size: 30))
                            .foregroundColor(Color("Accent Blue"))
                            .bold()
                            .padding()
                            .onAppear{
                                let _ = viewModel.getUserData() }
                    }
                    Spacer()
                        .frame(height: 30)
                    if (viewModel.user.vehicleMake != "" && viewModel.user.vehicleModel != "") {
                        Text("Your vehicle, \(viewModel.user.vehicleMake) \(viewModel.user.vehicleModel), is currently")
                            .font(.custom("overpass-semibold", size: 20))
                            .foregroundColor(Color("Accent Blue"))
                            .bold()
                            .padding()
                            .onAppear {
                                kafkaClient.produce(message: "0.62")
                                kafkaMessage = kafkaClient.consume() ?? "No message"
                                var message = kafkaMessage.codingKey.stringValue
                                self.vehicleCharge = Float(message) ?? 0.0
                            }
                            .onDisappear {
                                kafkaClient.commit()
                                kafkaMessage = ""
                            }
                        
                        ChargeLevelBar(progress: self.$vehicleCharge)
                            .frame(width: 150.0, height: 150.0)
                            .padding(40.0)
                        
                        Button("Refresh") {
                            kafkaMessage = kafkaClient.consume() ?? "No message"
                        }
                    }
                    else{
                        Text("You do not currently have a General Motors vehicle connected to this account.")
                            .font(.custom("overpass-semibold", size: 20))
                            .foregroundColor(Color("Accent Blue"))
                            .bold()
                            .padding()
                            .multilineTextAlignment(.center)
                        
                        Text("Navigate to your account page to update your vehicle information.")
                            .font(.custom("overpass-semibold", size: 20))
                            .foregroundColor(Color("Accent Blue"))
                            .bold()
                            .padding()
                            .multilineTextAlignment(.center)
                    }
                    
                }
            }
        }
}

struct ChargeLevelBar: View {
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            
            Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.red)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear)
            
            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                .font(.largeTitle)
                .bold()
        }
    }
}

struct VehicleChargeView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleChargeView(vehicleCharge: 0.0)
    }
}
