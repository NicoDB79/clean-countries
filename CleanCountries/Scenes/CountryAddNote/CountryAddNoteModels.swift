//
//  CountryAddNoteModels.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 13/12/2020.
//

import UIKit

enum CountryAddNoteModels {
    
    struct FetchRequest {
        let country: Country
    }
    
    struct Response {
        let note: String
    }
    
    struct NoteViewModel {
        let displayedNote: DisplayedNote
    }
    
    struct DisplayedNote {
        let note: String
    }
}

