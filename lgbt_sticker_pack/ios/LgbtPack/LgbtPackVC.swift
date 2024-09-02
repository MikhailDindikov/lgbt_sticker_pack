import UIKit
import Messages

class LgbtPackVC: MSStickerBrowserViewController {

    //create stickers array
    var gstickers = [MSSticker]()

    //load assets into stickers array
    func loadStickers() {
        var gtype = 0
        
        if let guserDefaults = UserDefaults(suiteName: "group.lgbtPack") {
                    if (guserDefaults.value(forKey: "pack_type") != nil) {
                        gtype = guserDefaults.integer(forKey: "pack_type")
                    }
                }
        if (gtype == 0) {
            createLgbtSticker(asset: "5", localizedDescription: "1")
            createLgbtSticker(asset: "6", localizedDescription: "2")
            createLgbtSticker(asset: "7", localizedDescription: "3")
            createLgbtSticker(asset: "8", localizedDescription: "4")
            createLgbtSticker(asset: "9", localizedDescription: "5")
            createLgbtSticker(asset: "16", localizedDescription: "6")
        } else if (gtype == 1) {
            createLgbtSticker(asset: "10", localizedDescription: "1")
            createLgbtSticker(asset: "11", localizedDescription: "2")
            createLgbtSticker(asset: "12", localizedDescription: "3")
            createLgbtSticker(asset: "13", localizedDescription: "4")
            createLgbtSticker(asset: "17", localizedDescription: "5")
            createLgbtSticker(asset: "18", localizedDescription: "6")
        }else if (gtype == 2) {
            createLgbtSticker(asset: "1", localizedDescription: "1")
            createLgbtSticker(asset: "2", localizedDescription: "2")
            createLgbtSticker(asset: "3", localizedDescription: "3")
            createLgbtSticker(asset: "4", localizedDescription: "4")
            createLgbtSticker(asset: "14", localizedDescription: "5")
            createLgbtSticker(asset: "15", localizedDescription: "6")
        }
    }

    //func to create sticker
    func createLgbtSticker(asset: String, localizedDescription: String) {

        //create url from assets in main bundle
        guard let gstickerPath = Bundle.main.path(forResource: asset, ofType: "png") else {
            
            return
        }
        let gstickerURL = URL(fileURLWithPath: gstickerPath)
        let gsticker: MSSticker

        //create sticker from path(and localized description) and add to array
        do {
            try gsticker = MSSticker(contentsOfFileURL: gstickerURL,
                                 localizedDescription: localizedDescription)
            gstickers.append(gsticker)
        } catch {
            print(error)
            return
        }
    }

    //datasource methods
    override func numberOfStickers(in stickerBrowserView: MSStickerBrowserView) -> Int {
        return gstickers.count
    }
    override func stickerBrowserView(_ stickerBrowserView: MSStickerBrowserView,
                                          stickerAt index: Int) -> MSSticker {
        return gstickers[index]
    }
}
