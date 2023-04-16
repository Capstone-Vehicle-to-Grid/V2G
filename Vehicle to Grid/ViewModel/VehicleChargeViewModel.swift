//
//  VehicleChargeViewModel.swift
//  Vehicle to Grid
//
//  Created by Julia Brixey on 4/15/23.
//

import Foundation


protocol KafkaClient {
    func produce(message: String)
    func consume() -> String?
    func commit()
}

class MockKafkaClient: KafkaClient {
    var message: String?

    func produce(message: String) {
        self.message = message
    }

    func consume() -> String? {
        return message
    }

    func commit() {
        message = nil
    }
}


class KafkaViewModel: ObservableObject {
    let kafkaClient: KafkaClient
    @Published var messages: [String] = []

    init(kafkaClient: KafkaClient) {
        self.kafkaClient = kafkaClient
    }

    func produceMessage(_ message: String) {
        kafkaClient.produce(message: message)
    }

    func consumeMessages() {
        DispatchQueue.global(qos: .background).async {
            while true {
                let message = self.kafkaClient.consume()
                if let message = message {
                    DispatchQueue.main.async {
                        self.messages.append(message)
                    }
                }
                self.kafkaClient.commit()
            }
        }
    }

    func stopConsumingMessages() {
        // Stop the message consumption
    }
}
