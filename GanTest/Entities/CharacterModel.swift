//
//  CharacterModel.swift
//  GanTest
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import Foundation

struct CharacterRemoteModel: Codable {
    var char_id: Int?
    var name: String?
    var birthday: String?
    var occupation: [String]?
    var img: String?
    var status: String?
    var nickname: String?
    var appearance: [Int]?
    var portrayed: String?
    var category: String?
    var better_call_saul_appearance: [Int]?

}
