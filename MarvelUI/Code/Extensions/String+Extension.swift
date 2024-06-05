//
//  String+Extension.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation
import CryptoKit

extension String {
    func md5() -> String {
        let digest = Insecure.MD5.hash(data: Data(self.utf8))

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
