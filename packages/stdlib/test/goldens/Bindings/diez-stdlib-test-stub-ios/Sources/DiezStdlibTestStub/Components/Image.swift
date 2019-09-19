// This file was generated with Diez - https://diez.org
// Do not edit this file directly.

import Foundation
import CoreGraphics

@objc(DEZImage)
public final class Image: NSObject, Decodable {
    @objc public internal(set) var file: File
    @objc public internal(set) var file2x: File
    @objc public internal(set) var file3x: File
    @objc public internal(set) var size: Size2D

    init(
        file: File,
        file2x: File,
        file3x: File,
        size: Size2D
    ) {
        self.file = file
        self.file2x = file2x
        self.file3x = file3x
        self.size = size
    }
}

extension Image: ReflectedCustomStringConvertible {
    public override var description: String {
        return reflectedDescription
    }
}
